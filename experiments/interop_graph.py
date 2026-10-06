#!/usr/bin/env python3
"""Operator-level inter-op parallelism in ONE inference.

Can independent operators of ResNet-50 run at the same time on different
cores? The only independent operators are the downsample branch (1x1 conv +
BN) of the first block of each stage (4 of 16 blocks), which could overlap
with the block's main path (conv1..bn3). Everything else is a chain.

Modes (intra-op threads K, inter-op threads I, process pinned by the caller):
  eager        canonical model; torch.set_num_interop_threads(I). Eager
               PyTorch executes operators one after another, so I should
               not matter.
  fork_eager   the 4 downsample branches launched with torch.jit.fork and
               joined with torch.jit.wait before the residual add (eager).
  fork_traced  the same model traced with torch.jit.trace; TorchScript runs
               forked subgraphs on the inter-op thread pool.
Also records, in the same process, the time of the 4 downsample branches and
of the whole inference with per-module hooks -> the most that overlapping
those branches could save (dependency bound).

usage: interop_graph.py --mode fork_traced --intra 1 --inter 2 --out DIR --name NAME
"""
import argparse
import json
import os
import sys
import time

sys.path.insert(0, os.path.join(os.path.dirname(__file__), ".."))
from cpuinf import runtime  # noqa: E402,F401  (thread env defaults before torch import)

ap = argparse.ArgumentParser()
ap.add_argument("--mode", choices=["eager", "fork_eager", "fork_traced"], required=True)
ap.add_argument("--intra", type=int, default=1)
ap.add_argument("--inter", type=int, default=1)
ap.add_argument("--iters", type=int, default=30)
ap.add_argument("--warmup", type=int, default=10)
ap.add_argument("--out", required=True)
ap.add_argument("--name", required=True)
args = ap.parse_args()
import torch  # noqa: E402

torch.set_num_interop_threads(args.inter)      # must precede any inter-op work
torch.set_num_threads(args.intra)
torch.set_grad_enabled(False)
from cpuinf.resnet import Bottleneck, build  # noqa: E402

model = build("random")
x = torch.randn(1, 3, 224, 224, generator=torch.Generator().manual_seed(123))
with torch.inference_mode():
    ref = model(x)

# Dependency bound, measured at this K: time of the downsample branches vs whole inference.
ds_mods = [m.downsample for m in model.modules() if isinstance(m, Bottleneck) and m.downsample is not None]
t0, ds_t = {}, []
hs = []
for i, dm in enumerate(ds_mods):
    hs.append(dm.register_forward_pre_hook(lambda m, inp, i=i: t0.__setitem__(i, time.perf_counter_ns())))
    hs.append(dm.register_forward_hook(lambda m, inp, o, i=i: ds_t.append((time.perf_counter_ns() - t0[i]) / 1e6)))
with torch.inference_mode():
    for _ in range(5):
        model(x)
    ds_t.clear()
    tot = []
    for _ in range(10):
        t = time.perf_counter_ns()
        model(x)
        tot.append((time.perf_counter_ns() - t) / 1e6)
for h in hs:
    h.remove()
ds_per_inf = sum(ds_t) / 10
tot_med = sorted(tot)[len(tot) // 2]


def fork_forward(self, x):
    fut = torch.jit.fork(self.downsample, x) if self.downsample is not None else None
    out = self.relu1(self.bn1(self.conv1(x)))
    out = self.relu2(self.bn2(self.conv2(out)))
    out = self.bn3(self.conv3(out))
    identity = torch.jit.wait(fut) if fut is not None else x
    out = self.add(out, identity)
    return self.relu3(out)


if args.mode != "eager":
    Bottleneck.forward = fork_forward
m = model
if args.mode == "fork_traced":
    with torch.inference_mode(False), torch.no_grad():
        m = torch.jit.trace(model, x, check_trace=False)
    graph_has_fork = "prim::fork" in str(m.inlined_graph) or "aten::fork" in str(m.inlined_graph) \
        or "prim::fork" in str(m.graph)
else:
    graph_has_fork = None
with torch.inference_mode():
    y = m(x)
    diff = float((y - ref).abs().max())
    for _ in range(args.warmup):
        m(x)
    lat = []
    for _ in range(args.iters):
        t = time.perf_counter_ns()
        m(x)
        lat.append((time.perf_counter_ns() - t) / 1e6)
thread_cpus = {}       # allowed CPUs of every thread (OpenMP + inter-op pool) after the runs
for tid in os.listdir("/proc/self/task"):
    try:
        with open(f"/proc/self/task/{tid}/status") as f:
            st = dict(l.split(":", 1) for l in f if ":" in l)
        thread_cpus[f"{tid} {st['Name'].strip()}"] = st["Cpus_allowed_list"].strip()
    except OSError:
        pass
rec = {"mode": args.mode, "intra": args.intra, "inter": args.inter, "affinity": sorted(os.sched_getaffinity(0)),
       "omp_proc_bind": os.environ.get("OMP_PROC_BIND", ""), "thread_cpus": thread_cpus,
       "torch_threads": torch.get_num_threads(), "interop_threads": torch.get_num_interop_threads(),
       "latency_ms": sorted(lat)[len(lat) // 2], "latency_p5": sorted(lat)[int(0.05 * (len(lat) - 1))],
       "latency_p95": sorted(lat)[int(0.95 * (len(lat) - 1))], "max_abs_diff": diff,
       "traced_graph_contains_fork": graph_has_fork,
       "eager_total_ms": tot_med, "downsample_branches_ms": ds_per_inf,
       "dependency_bound_speedup": tot_med / (tot_med - ds_per_inf)}
os.makedirs(os.path.join(args.out, "raw"), exist_ok=True)
json.dump(rec, open(os.path.join(args.out, "raw", f"{args.name}.json"), "w"), indent=1)
print(json.dumps(rec))
