#!/usr/bin/env python3
"""ResNet-50 inference loop to run under Intel VTune Profiler.

Every PyTorch operator is labelled as an ITT task
(torch.autograd.profiler.emit_itt), and each inference as an ITT range named
"inference", so VTune can group samples by operator (Grouping:
"Task Type / Function / Call Stack"). oneDNN registers its JIT kernels with
VTune when ONEDNN_JIT_PROFILE includes bit 1 (set below), so JIT code shows
by kernel name instead of as [Dynamic code].

The warm-up runs before ITT labelling starts; use `-resume-after` or the
"inference" ranges to exclude it in VTune.

usage:
  source /opt/intel/oneapi/vtune/latest/env/vars.sh
  vtune -collect hotspots -knob sampling-mode=hw -r results/<date>_vtune/hotspots_1t \
        -- taskset -c 6 .venv/bin/python experiments/vtune_run.py --threads 1 --iters 100
"""
import argparse
import contextlib
import os
import sys
import time

os.environ.setdefault("ONEDNN_JIT_PROFILE", "1")      # 1 = VTune JIT API (must precede the import of torch)
sys.path.insert(0, os.path.join(os.path.dirname(__file__), ".."))
from cpuinf import runtime  # noqa: E402

ap = argparse.ArgumentParser()
ap.add_argument("--variant", default="baseline")
ap.add_argument("--threads", type=int, default=1)
ap.add_argument("--batch", type=int, default=1)
ap.add_argument("--warmup", type=int, default=10)
ap.add_argument("--iters", type=int, default=100)
ap.add_argument("--no-itt", action="store_true", help="no per-operator ITT labels (removes their small overhead)")
args = ap.parse_args()

torch = runtime.configure_torch(args.threads)
from cpuinf.resnet import build  # noqa: E402
from cpuinf.variants import make_variant  # noqa: E402

base = build("random")
x = torch.randn(args.batch, 3, 224, 224, generator=torch.Generator().manual_seed(123))
m, xin, _ = make_variant(args.variant, base, x)
del base
itt = torch.profiler.itt
label = contextlib.nullcontext() if args.no_itt else torch.autograd.profiler.emit_itt()
with torch.inference_mode():
    for _ in range(args.warmup):
        m(xin)
    lat = []
    with label:
        for _ in range(args.iters):
            itt.range_push("inference")
            t = time.perf_counter_ns()
            m(xin)
            lat.append((time.perf_counter_ns() - t) / 1e6)
            itt.range_pop()
lat.sort()
print(f"{args.variant} threads={args.threads} batch={args.batch} iters={args.iters} "
      f"median {lat[len(lat) // 2]:.2f} ms (ITT labels {'off' if args.no_itt else 'on'})")
