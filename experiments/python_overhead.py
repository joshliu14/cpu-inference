#!/usr/bin/env python3
"""How much of one inference is Python itself?

Three ways of running the SAME ATen operators, timed in interleaved blocks:
  eager            the canonical baseline (Python nn.Module calls per op)
  eager_gc_off     the same, with Python's cyclic garbage collector disabled
                   during the timed calls (gc.disable())
  jit_trace        torch.jit.trace of the baseline: the identical ATen op
                   sequence, run by the C++ TorchScript interpreter, so no
                   Python frames or nn.Module.__call__ per operator
Differences estimate the cost of the Python layer (eager - jit_trace) and of
GC pauses (eager - eager_gc_off). Garbage collections per inference are
counted with gc.callbacks.

usage: python_overhead.py --cpu 6 --out DIR [--iters 200 --block 10]
"""
import argparse
import gc
import os
import sys
import time

sys.path.insert(0, os.path.join(os.path.dirname(__file__), ".."))
from cpuinf import runtime  # noqa: E402

ap = argparse.ArgumentParser()
ap.add_argument("--cpu", type=int, default=None)
ap.add_argument("--out", required=True)
ap.add_argument("--iters", type=int, default=200)
ap.add_argument("--block", type=int, default=10)
ap.add_argument("--warmup", type=int, default=15)
args = ap.parse_args()
runtime.pin(args.cpu)
torch = runtime.configure_torch()

from cpuinf.perfcounters import CounterSession  # noqa: E402
from cpuinf.resnet import build  # noqa: E402
from cpuinf.variants import make_variant  # noqa: E402

os.makedirs(os.path.join(args.out, "raw"), exist_ok=True)
os.makedirs(os.path.join(args.out, "processed"), exist_ok=True)
base = build("random")
x = torch.randn(1, 3, 224, 224, generator=torch.Generator().manual_seed(123))
traced, _, _ = make_variant("jit_trace", base, x)
with torch.inference_mode():
    ref = base(x)
    diff = float((traced(x) - ref).abs().max())
runs = {"eager": (base, False), "eager_gc_off": (base, True), "jit_trace": (traced, False)}
collections_seen = {"n": 0}
gc.callbacks.append(lambda phase, info: collections_seen.__setitem__("n", collections_seen["n"] + (phase == "start")))
cs = CounterSession(["cycles", "instructions"])
data = {k: {"ms": [], "cyc": [], "ins": [], "gcs": 0} for k in runs}
with torch.inference_mode():
    for m, _ in runs.values():
        for _ in range(args.warmup):
            m(x)
    while any(len(d["ms"]) < args.iters for d in data.values()):
        for name, (m, gc_off) in runs.items():
            d = data[name]
            if gc_off:
                gc.disable()
            c0 = collections_seen["n"]
            for _ in range(min(args.block, args.iters - len(d["ms"]))):
                cs.start()
                t = time.perf_counter_ns()
                m(x)
                dt = time.perf_counter_ns() - t
                c = cs.stop()
                d["ms"].append(dt / 1e6)
                d["cyc"].append(c["cycles"])
                d["ins"].append(c["instructions"])
            d["gcs"] += collections_seen["n"] - c0
            if gc_off:
                gc.enable()

med = lambda v: sorted(v)[len(v) // 2]  # noqa: E731
out = {"environment": runtime.environment_record(args.cpu), "jit_trace_max_abs_diff": diff, "runs": {}}
for name, d in data.items():
    out["runs"][name] = {"latency_ms": runtime.summarize(d["ms"]), "cycles_median": med(d["cyc"]),
                         "instructions_median": med(d["ins"]),
                         "gc_collections_per_inference": d["gcs"] / len(d["ms"])}
    print(f"{name:13s} median {out['runs'][name]['latency_ms']['median']:7.2f} ms  "
          f"instr {med(d['ins']) / 1e6:7.2f} M  gc/inf {d['gcs'] / len(d['ms']):.3f}")
e, j, g = (out["runs"][k]["latency_ms"]["median"] for k in ("eager", "jit_trace", "eager_gc_off"))
ie, ij = out["runs"]["eager"]["instructions_median"], out["runs"]["jit_trace"]["instructions_median"]
out["python_layer_ms_estimate"] = e - j
out["python_layer_instructions_estimate"] = ie - ij
out["gc_ms_estimate"] = e - g
print(f"Python layer (eager - jit_trace): {e - j:.2f} ms, {(ie - ij) / 1e6:.2f} M instructions; "
      f"GC (eager - gc_off): {e - g:.2f} ms")
runtime.dump_json(os.path.join(args.out, "processed", "python_overhead.json"), out)
