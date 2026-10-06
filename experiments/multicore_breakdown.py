#!/usr/bin/env python3
"""Which operators stop scaling with more intra-op threads?

Per-operator-type time (forward hooks on leaf modules, median over iterations)
of an eager variant at N threads. Run once per N (the caller sets
OMP_NUM_THREADS=N and pins with taskset -c 1-N before Python starts);
compare N=1 with large N to see which operator types do not parallelise.

usage: multicore_breakdown.py --variant baseline --threads 26 --out DIR
"""
import argparse
import collections
import json
import os
import sys
import time

sys.path.insert(0, os.path.join(os.path.dirname(__file__), ".."))
from cpuinf import runtime  # noqa: E402

ap = argparse.ArgumentParser()
ap.add_argument("--variant", default="baseline")
ap.add_argument("--threads", type=int, default=1)
ap.add_argument("--iters", type=int, default=30)
ap.add_argument("--warmup", type=int, default=10)
ap.add_argument("--out", required=True)
args = ap.parse_args()
torch = runtime.configure_torch(args.threads)

from cpuinf.resnet import build  # noqa: E402
from cpuinf.variants import ChannelsLastMaxPool, make_variant  # noqa: E402

base = build("random")
x = torch.randn(1, 3, 224, 224, generator=torch.Generator().manual_seed(123))
m, xin, _ = make_variant(args.variant, base, x)


def kind(mod):
    n = type(mod).__name__
    if "Conv" in n:
        return f"conv{mod.kernel_size[0]}x{mod.kernel_size[0]}"
    return {"BatchNorm2d": "batchnorm", "ReLU": "relu", "MaxPool2d": "maxpool", "Add": "add",
            "ChannelsLastMaxPool": "maxpool"}.get(n, "other")


leaves = [(n, md) for n, md in m.named_modules()
          if (len(list(md.children())) == 0 or isinstance(md, ChannelsLastMaxPool))
          and type(md).__name__ not in ("Identity",)]
t0, acc = {}, collections.defaultdict(list)
for n, md in leaves:
    md.register_forward_pre_hook(lambda _m, _i, n=n: t0.__setitem__(n, time.perf_counter_ns()))
    md.register_forward_hook(lambda _m, _i, _o, n=n: acc[n].append(time.perf_counter_ns() - t0[n]))
e2e = []
with torch.inference_mode():
    for _ in range(args.warmup):
        m(xin)
    acc.clear()
    for _ in range(args.iters):
        t = time.perf_counter_ns()
        m(xin)
        e2e.append((time.perf_counter_ns() - t) / 1e6)
per_kind = collections.defaultdict(float)
per_layer = {}
kinds = {n: kind(md) for n, md in leaves}
for n, v in acc.items():
    v = sorted(v)
    per_layer[n] = v[len(v) // 2] / 1e6
    per_kind[kinds[n]] += per_layer[n]
rec = {"variant": args.variant, "threads": args.threads, "affinity": sorted(os.sched_getaffinity(0)),
       "e2e_ms_median": sorted(e2e)[len(e2e) // 2], "sum_of_ops_ms": sum(per_layer.values()),
       "per_kind_ms": dict(per_kind), "per_layer_ms": per_layer, "layer_kind": kinds}
os.makedirs(os.path.join(args.out, "raw"), exist_ok=True)
with open(os.path.join(args.out, "raw", f"breakdown_{args.variant}_{args.threads}.json"), "w") as f:
    json.dump(rec, f, indent=1)
print(f"{args.variant} N={args.threads}: e2e {rec['e2e_ms_median']:.2f} ms  "
      + "  ".join(f"{k}={v:.2f}" for k, v in sorted(per_kind.items(), key=lambda kv: -kv[1])))
