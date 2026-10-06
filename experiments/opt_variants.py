#!/usr/bin/env python3
"""Optimization experiments: one minimal change per variant, same measurement.

Each variant states a hypothesis grounded in a baseline measurement (see
docs/RESULTS.md). For every variant we check numerical equivalence with the
baseline output, then measure end-to-end latency (with cycles/instructions)
and a per-operator-type time breakdown (forward hooks on leaf modules).

Variants
  baseline              the canonical explicit model (NCHW / contiguous)
  maxpool_chlast        only the max-pool runs on a channels-last copy of its
                        input (convert -> pool -> convert back)
  fold_bn               BatchNorm folded into the preceding conv's weights/bias
                        (exact in inference; removes 53 BN operators)
  channels_last         whole model and input in channels-last memory format
  mkldnn_layout         torch.utils.mkldnn.to_mkldnn: tensors stay in oneDNN's
                        blocked layout between operators (no per-op reorders)
  fold_bn+chlast_pool   fold_bn and maxpool_chlast together
  fold_bn+channels_last fold_bn, then the whole model in channels-last
  jit_freeze            torch.jit.trace -> torch.jit.optimize_for_inference
                        (freezes weights, folds BN, fuses conv+relu, keeps
                        oneDNN-prepacked weights and blocked layouts)
  inductor              torch.compile(backend="inductor") with
                        inductor freezing=True (weights constant-folded and
                        prepacked; elementwise ops fused into generated C++)

Timing is interleaved: every variant is warmed up, then the variants are run
in rotating blocks of --block iterations until each has --iters timed
iterations, so slow drift (frequency, other tenants) affects all variants
equally.

usage: opt_variants.py --cpu 6 --out DIR [--variants a,b,...] [--iters 100]
"""
import argparse
import collections
import copy
import os
import sys
import time

sys.path.insert(0, os.path.join(os.path.dirname(__file__), ".."))
from cpuinf import runtime  # noqa: E402

ap = argparse.ArgumentParser()
ap.add_argument("--cpu", type=int, default=None)
ap.add_argument("--out", required=True)
ap.add_argument("--variants", default="", help="comma list (default: all of cpuinf.variants.VARIANTS)")
ap.add_argument("--iters", type=int, default=100)
ap.add_argument("--block", type=int, default=10)
ap.add_argument("--warmup", type=int, default=15)
ap.add_argument("--op-iters", type=int, default=15)
args = ap.parse_args()
runtime.pin(args.cpu)
torch = runtime.configure_torch()
import torch.nn as nn  # noqa: E402
import torch.nn.functional as F  # noqa: E402

from cpuinf.perfcounters import CounterSession  # noqa: E402
from cpuinf.resnet import build  # noqa: E402
from cpuinf.variants import VARIANTS, ChannelsLastMaxPool, make_variant  # noqa: E402

if not args.variants:
    args.variants = ",".join(VARIANTS)

os.makedirs(os.path.join(args.out, "raw"), exist_ok=True)
os.makedirs(os.path.join(args.out, "processed"), exist_ok=True)


def op_kind(mod):
    n = type(mod).__name__
    if "Conv" in n:
        k = mod.kernel_size[0] if hasattr(mod, "kernel_size") else "?"
        if k == "?" and getattr(mod, "weight", None) is not None:
            w = mod.weight.to_dense() if mod.weight.is_mkldnn else mod.weight
            k = w.shape[-1]
        return f"conv{k}x{k}"
    return {"BatchNorm2d": "batchnorm", "ReLU": "relu", "MaxPool2d": "maxpool", "Add": "add",
            "AdaptiveAvgPool2d": "avgpool", "Linear": "linear", "ChannelsLastMaxPool": "maxpool",
            "Flatten": "flatten", "Identity": "identity", "MkldnnBatchNorm": "batchnorm",
            "MkldnnLinear": "linear"}.get(n, n)


def breakdown(m, xin):
    """Median per-op-type time over --op-iters forward passes (leaf hooks)."""
    leaves = [(n, mod) for n, mod in m.named_modules()
              if len(list(mod.children())) == 0 or isinstance(mod, ChannelsLastMaxPool)]
    leaves = [(n, mod) for n, mod in leaves if not any(n.startswith(p + ".") for p, q in leaves
                                                       if isinstance(q, ChannelsLastMaxPool))]
    t0s, acc = {}, collections.defaultdict(list)
    hs = []
    for n, mod in leaves:
        hs.append(mod.register_forward_pre_hook(lambda md, i, n=n: t0s.__setitem__(n, time.perf_counter_ns())))
        hs.append(mod.register_forward_hook(lambda md, i, o, n=n, k=op_kind(mod):
                                            acc[(k, n)].append(time.perf_counter_ns() - t0s[n])))
    with torch.inference_mode():
        for _ in range(args.op_iters):
            m(xin)
    for h in hs:
        h.remove()
    per_type = collections.defaultdict(float)
    for (k, n), v in acc.items():
        v = sorted(v)
        per_type[k] += v[len(v) // 2] / 1e6
    return dict(per_type)


base = build("random")
x = torch.randn(1, 3, 224, 224, generator=torch.Generator().manual_seed(123))
with torch.inference_mode():
    ref = base(x)
cs = CounterSession(["cycles", "instructions", "page-faults"])
summary = {"environment": runtime.environment_record(args.cpu), "variants": {}}
rows = []
built = {}
for name in args.variants.split(","):
    t = time.perf_counter()
    try:
        m, xin, dense = make_variant(name, base, x)
        with torch.inference_mode():
            for _ in range(args.warmup):
                y = m(xin)
            diff = float((dense(y) - ref).abs().max())
    except Exception as e:  # noqa: BLE001
        print(f"{name}: FAILED to build/run: {e!r}"[:400])
        summary["variants"][name] = {"error": repr(e)[:2000]}
        continue
    built[name] = (m, xin, diff, time.perf_counter() - t)
    print(f"{name:22s} built + {args.warmup} warmup in {built[name][3]:.1f} s, max|diff| {diff:.2e}")

samples = {n: {"ms": [], "cyc": [], "ins": [], "pf": []} for n in built}
with torch.inference_mode():
    while any(len(v["ms"]) < args.iters for v in samples.values()):
        for name, (m, xin, _, _) in built.items():
            sm = samples[name]
            for _ in range(min(args.block, args.iters - len(sm["ms"]))):
                cs.start()
                t = time.perf_counter_ns()
                m(xin)
                dt = time.perf_counter_ns() - t
                c = cs.stop()
                rows.append({"variant": name, "iter": len(sm["ms"]), "ms": dt / 1e6, "cycles": c["cycles"],
                             "instructions": c["instructions"], "page_faults": c["page-faults"]})
                sm["ms"].append(dt / 1e6)
                sm["cyc"].append(c["cycles"])
                sm["ins"].append(c["instructions"])
                sm["pf"].append(c["page-faults"])

for name, (m, xin, diff, build_s) in built.items():
    sm = samples[name]
    try:
        scripted = isinstance(m, torch.jit.ScriptModule) or hasattr(m, "_orig_mod")
        bd = {} if scripted else breakdown(m, xin)   # no leaf modules to hook in jit/compiled graphs
    except Exception as e:  # noqa: BLE001
        bd = {"error": str(e)}
    s = runtime.summarize(sm["ms"])
    med = lambda v: sorted(v)[len(v) // 2]  # noqa: E731
    summary["variants"][name] = {"latency_ms": s, "cycles_median": med(sm["cyc"]),
                                 "instructions_median": med(sm["ins"]),
                                 "ipc": med(sm["ins"]) / med(sm["cyc"]),
                                 "page_faults_median": med(sm["pf"]),
                                 "max_abs_diff_vs_baseline": diff, "build_and_warmup_s": build_s,
                                 "per_op_type_ms": bd}
    print(f"{name:22s} median {s['median']:7.2f} ms  p5 {s['p5']:7.2f}  p95 {s['p95']:7.2f}  "
          f"IPC {summary['variants'][name]['ipc']:.2f}  max|diff| {diff:.2e}  "
          + " ".join(f"{k}={v:.2f}" for k, v in sorted(bd.items(), key=lambda kv: -kv[1] if isinstance(kv[1], float) else 0)
                     if isinstance(v, float))[:200])

import csv  # noqa: E402

with open(os.path.join(args.out, "raw", "opt_iters.csv"), "w", newline="") as f:
    w = csv.DictWriter(f, fieldnames=list(rows[0].keys()))
    w.writeheader()
    w.writerows(rows)
runtime.dump_json(os.path.join(args.out, "processed", "opt_summary.json"), summary)
