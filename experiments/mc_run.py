#!/usr/bin/env python3
"""One inference stream for the multi-core study (scripts/mc_study.py).

A stream = one process pinned to its own set of cores, running one variant
at batch size B with K intra-op threads (OpenMP), back to back. The
orchestrator starts S streams on disjoint core sets (S > 1 = concurrent
independent inferences, i.e. task-level inter-op parallelism).

Protocol: build + warm up -> write sync/ready_<id> (JSON with the warm-up
latency) -> wait for sync/go ("<start> <end>" unix times) -> run inferences
from start until end -> write raw/stream_<tag>_<id>.json (every latency and
its end timestamp).

The caller sets OMP_NUM_THREADS=K, OMP_PROC_BIND=close, OMP_PLACES=cores.

usage: mc_run.py --variant baseline --threads 4 --batch 1 --cpus 1-4 --id 0
                 --sync DIR --seconds 20 --out DIR --tag NAME
"""
import argparse
import json
import os
import sys
import time

sys.path.insert(0, os.path.join(os.path.dirname(__file__), ".."))
from cpuinf import runtime  # noqa: E402

ap = argparse.ArgumentParser()
ap.add_argument("--variant", default="baseline")
ap.add_argument("--threads", type=int, default=1)
ap.add_argument("--batch", type=int, default=1)
ap.add_argument("--cpus", required=True, help="e.g. 1-4 or 1,3,5")
ap.add_argument("--id", type=int, default=0)
ap.add_argument("--sync", required=True)
ap.add_argument("--seconds", type=float, default=20.0)
ap.add_argument("--out", required=True)
ap.add_argument("--tag", required=True)
args = ap.parse_args()


def parse_cpus(s):
    out = []
    for part in s.split(","):
        a, _, b = part.partition("-")
        out += list(range(int(a), int(b or a) + 1))
    return out


cpus = parse_cpus(args.cpus)
os.sched_setaffinity(0, set(cpus))
torch = runtime.configure_torch(args.threads)
from cpuinf.resnet import build  # noqa: E402
from cpuinf.variants import make_variant  # noqa: E402

base = build("random")
x = torch.randn(args.batch, 3, 224, 224, generator=torch.Generator().manual_seed(123))
t0 = time.perf_counter()
m, xin, _ = make_variant(args.variant, base, x)
del base
warm = []
with torch.inference_mode():
    tw = time.perf_counter()
    while len(warm) < 3 or (time.perf_counter() - tw < 2.0 and len(warm) < 20):
        t = time.perf_counter_ns()
        m(xin)
        warm.append((time.perf_counter_ns() - t) / 1e6)
build_s = time.perf_counter() - t0
with open(os.path.join(args.sync, f"ready_{args.id}"), "w") as f:
    json.dump({"warm_latency_ms": sorted(warm)[len(warm) // 2], "build_s": build_s}, f)
go = os.path.join(args.sync, "go")
while not os.path.exists(go):
    time.sleep(0.01)
time.sleep(0.05)
fields = open(go).read().split()           # "<start> <end>" (unix time) from the orchestrator
start = float(fields[0])
end = float(fields[1]) if len(fields) > 1 else start + args.seconds
while time.time() < start:
    time.sleep(0.0005)
lat, ends = [], []
with torch.inference_mode():
    while time.time() < end:
        t = time.perf_counter_ns()
        m(xin)
        lat.append((time.perf_counter_ns() - t) / 1e6)
        ends.append(time.time())
rec = {"tag": args.tag, "id": args.id, "variant": args.variant, "threads": args.threads, "batch": args.batch,
       "cpus": cpus, "torch_threads": torch.get_num_threads(), "build_and_warmup_s": build_s,
       "window_start": start, "window_s": end - start, "latency_ms": lat, "end_times": ends,
       "env": {k: os.environ.get(k) for k in ("OMP_NUM_THREADS", "OMP_PROC_BIND", "OMP_PLACES", "MKL_NUM_THREADS")}}
os.makedirs(os.path.join(args.out, "raw"), exist_ok=True)
with open(os.path.join(args.out, "raw", f"stream_{args.tag}_{args.id}.json"), "w") as f:
    json.dump(rec, f)
