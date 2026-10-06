#!/usr/bin/env python3
"""Run inference (or one operator) in a loop for a fixed time -- a target for
perf record / perf mem / perf stat, which observe the whole process.

  infer_loop.py --seconds 15                  full ResNet-50 forward passes
  infer_loop.py --seconds 10 --layer maxpool  one leaf module, standalone, hot

Setup (imports, model build, warm-up) happens before the line
'@@LOOP_START <unix time>' is printed; profilers can use perf's --delay or
the sample timestamps to exclude it. Run under `python -X perf` to make
CPython publish a perf map so Python frames get names in perf report.
"""
import argparse
import copy
import os
import sys
import time

sys.path.insert(0, os.path.join(os.path.dirname(__file__), ".."))
from cpuinf import runtime  # noqa: E402

ap = argparse.ArgumentParser()
ap.add_argument("--cpu", type=int, default=None)
ap.add_argument("--seconds", type=float, default=10.0)
ap.add_argument("--layer", default="")
ap.add_argument("--warmup", type=int, default=5)
args = ap.parse_args()
runtime.pin(args.cpu)
torch = runtime.configure_torch()
from cpuinf.resnet import build, leaf_modules  # noqa: E402

model = build("random")
x = torch.randn(1, 3, 224, 224, generator=torch.Generator().manual_seed(123))

if args.layer:
    leaves = dict(leaf_modules(model))
    caught = {}
    h = leaves[args.layer].register_forward_pre_hook(
        lambda m, inp: caught.setdefault("x", tuple(t.clone() for t in inp)))
    with torch.inference_mode():
        model(x)
    h.remove()
    mod = copy.deepcopy(leaves[args.layer])
    inp = caught["x"]

    def step():
        mod(*inp)
else:
    def step():
        model(x)

with torch.inference_mode():
    for _ in range(args.warmup):
        step()
    print(f"@@LOOP_START {time.time():.6f}", flush=True)
    t0 = time.perf_counter()
    n = 0
    while time.perf_counter() - t0 < args.seconds:
        step()
        n += 1
    dt = time.perf_counter() - t0
print(f"@@LOOP_END iterations={n} seconds={dt:.3f} ms_per_iter={1e3 * dt / n:.4f}", flush=True)
