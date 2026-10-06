#!/usr/bin/env python3
"""Estimate fixed software overhead: Python call -> nn.Module -> dispatcher -> kernel.

For each callable we time many back-to-back calls (cycles + instructions per
call, in-process counters) across a range of tensor sizes N and fit

    cycles_per_call(N) = fixed + per_element * N

over the sizes where the fit is linear. 'fixed' (the intercept) estimates the
size-independent cost of getting from Python to the kernel and back:
interpreter, argument parsing, dispatcher, output allocation, kernel launch.
It is an ESTIMATE: the fit assumes the kernel's per-element cost is constant,
which stops being true when the data outgrows a cache level, so only sizes
<= 64K elements (256 KiB, L2-resident) are used for the fit.

Reference points measured directly:
  python_noop     an empty Python function call
  module_identity nn.Identity()(x): nn.Module.__call__ machinery only
  ...and tiny-size calls of each op (N = 1), whose cost is almost all overhead.

usage: dispatch_overhead.py --cpu 6 --out DIR
"""
import argparse
import csv
import os
import sys
import time

sys.path.insert(0, os.path.join(os.path.dirname(__file__), ".."))
from cpuinf import runtime  # noqa: E402

ap = argparse.ArgumentParser()
ap.add_argument("--cpu", type=int, default=None)
ap.add_argument("--out", required=True)
ap.add_argument("--min-ms", type=float, default=40.0)
ap.add_argument("--reps", type=int, default=7)
args = ap.parse_args()
runtime.pin(args.cpu)
torch = runtime.configure_torch()
import numpy as np  # noqa: E402
import torch.nn as nn  # noqa: E402
import torch.nn.functional as F  # noqa: E402

from cpuinf.perfcounters import CounterSession  # noqa: E402

os.makedirs(os.path.join(args.out, "raw"), exist_ok=True)
os.makedirs(os.path.join(args.out, "processed"), exist_ok=True)
cs = CounterSession(["cycles", "instructions"])
floor = []
for _ in range(200):
    cs.start()
    floor.append(cs.stop())
floor_c = float(np.median([f["cycles"] for f in floor]))
floor_i = float(np.median([f["instructions"] for f in floor]))


def bench(fn):
    t = time.perf_counter()
    k = 0
    while time.perf_counter() - t < 0.01:
        fn()
        k += 1
    calls = max(10, int(k * args.min_ms / 10))
    out = []
    for _ in range(args.reps):
        cs.start()
        t0 = time.perf_counter_ns()
        for _ in range(calls):
            fn()
        dt = time.perf_counter_ns() - t0
        c = cs.stop()
        out.append(((c["cycles"] - floor_c) / calls, (c["instructions"] - floor_i) / calls, dt / calls))
    return np.median(np.array(out), axis=0)   # cycles, instructions, ns per call


rows = []


def record(name, n, fn):
    cyc, ins, ns = bench(fn)
    rows.append({"callable": name, "N": n, "cycles_per_call": cyc, "instructions_per_call": ins, "ns_per_call": ns})
    print(f"{name:22s} N={n:>9d} {cyc:12.0f} cyc {ins:12.0f} instr {ns / 1e3:10.2f} us")


def noop():
    return None


x1 = torch.ones(1)
ident = nn.Identity()
with torch.inference_mode():
    record("python_noop", 0, noop)
    record("module_identity", 1, lambda: ident(x1))
    sizes = [1, 16, 256, 1024, 4096, 16384, 65536, 262144, 1048576, 4194304]
    for n in sizes:
        a = torch.randn(n)
        b = torch.randn(n)
        relu_m = nn.ReLU()
        record("torch.relu", n, lambda: torch.relu(a))
        record("nn.ReLU module", n, lambda: relu_m(a))
        record("torch.add", n, lambda: torch.add(a, b))
        record("add_ inplace", n, lambda: a.add_(b))
    # BatchNorm (inference) on C=64 channels, varying spatial size.
    for hw in (1, 4, 8, 16, 32, 56, 112):
        bn = nn.BatchNorm2d(64).eval()
        t = torch.randn(1, 64, hw, hw)
        record("nn.BatchNorm2d(64)", 64 * hw * hw, lambda: bn(t))
    # Convolutions: tiny problems show the fixed cost of each backend path.
    for hw in (1, 2, 4, 8, 16, 28, 56):
        c1 = nn.Conv2d(64, 64, 1, bias=False)
        c3 = nn.Conv2d(64, 64, 3, padding=1, bias=False)
        t = torch.randn(1, 64, hw, hw)
        record("conv1x1 64->64", 64 * hw * hw, lambda: c1(t))
        record("conv3x3 64->64", 64 * hw * hw, lambda: c3(t))
    for hw in (2, 4, 8, 16, 32, 56, 112):
        mp = nn.MaxPool2d(3, 2, 1)
        t = torch.randn(1, 64, hw, hw)
        record("nn.MaxPool2d(3,2,1)", 64 * hw * hw, lambda: mp(t))
        record("F.max_pool2d chlast", 64 * hw * hw,
               lambda tt=t.contiguous(memory_format=torch.channels_last): F.max_pool2d(tt, 3, 2, 1))

with open(os.path.join(args.out, "raw", "dispatch_overhead.csv"), "w", newline="") as f:
    w = csv.DictWriter(f, fieldnames=list(rows[0].keys()))
    w.writeheader()
    w.writerows(rows)

# Linear fits over L2-resident sizes.
import pandas as pd  # noqa: E402

df = pd.DataFrame(rows)
fits = []
for name, d in df.groupby("callable"):
    d = d[(d.N >= 1) & (d.N <= 65536)]
    if len(d) < 3:
        continue
    for col in ("cycles_per_call", "instructions_per_call"):
        slope, icpt = np.polyfit(d.N, d[col], 1)
        fits.append({"callable": name, "metric": col, "fixed_intercept": icpt, "per_element": slope,
                     "points": len(d)})
pd.DataFrame(fits).to_csv(os.path.join(args.out, "processed", "dispatch_fits.csv"), index=False)
runtime.dump_json(os.path.join(args.out, "processed", "dispatch_meta.json"),
                  {"environment": runtime.environment_record(args.cpu), "floor_cycles": floor_c,
                   "floor_instructions": floor_i})
print(pd.DataFrame(fits).round(3).to_string())
