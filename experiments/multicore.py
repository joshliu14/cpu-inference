#!/usr/bin/env python3
"""Multi-core experiments (separate from the single-core baseline).

Two ways of using N cores:

  --mode threads    ONE inference at a time, split across N intra-op threads
                    (OpenMP in ATen / oneDNN / MKL). Answers: how much faster
                    is a single batch-1 inference with N cores (latency)?
                    The caller pins the process to N cores (taskset) and sets
                    OMP_NUM_THREADS=N, OMP_PROC_BIND=close, OMP_PLACES=cores
                    before Python starts. Socket DRAM traffic (uncore IMC CAS)
                    is read around the timed loop -> DRAM bytes per inference.

  --mode instance   one single-threaded inference loop pinned to --cpu; the
                    launcher (experiments/multicore.sh) starts N of these on N
                    different cores. Each instance builds + warms up, writes
                    a 'ready' file, waits for a common 'go' file, then runs for
                    --seconds and records every latency. Answers: how much
                    total throughput do N independent copies get, and how much
                    does each copy slow down from sharing L3 and DRAM?

usage:
  multicore.py --mode threads  --variant baseline --threads 8 --out DIR
  multicore.py --mode instance --variant baseline --cpu 3 --sync DIR/sync/x --seconds 20 --out DIR --tag x_3
"""
import argparse
import json
import os
import sys
import time

sys.path.insert(0, os.path.join(os.path.dirname(__file__), ".."))
from cpuinf import runtime  # noqa: E402

ap = argparse.ArgumentParser()
ap.add_argument("--mode", choices=["threads", "instance"], required=True)
ap.add_argument("--variant", default="baseline")
ap.add_argument("--threads", type=int, default=1)
ap.add_argument("--cpu", type=int, default=None)
ap.add_argument("--iters", type=int, default=60)
ap.add_argument("--warmup", type=int, default=10)
ap.add_argument("--seconds", type=float, default=20.0)
ap.add_argument("--sync", default=None, help="instance mode: directory for ready/go files")
ap.add_argument("--tag", default="")
ap.add_argument("--out", required=True)
args = ap.parse_args()
if args.mode == "instance":
    runtime.pin(args.cpu)
torch = runtime.configure_torch(args.threads)

from cpuinf.resnet import build  # noqa: E402
from cpuinf.variants import make_variant  # noqa: E402

os.makedirs(os.path.join(args.out, "raw"), exist_ok=True)
os.makedirs(os.path.join(args.out, "processed"), exist_ok=True)

base = build("random")
x = torch.randn(1, 3, 224, 224, generator=torch.Generator().manual_seed(123))
t0 = time.perf_counter()
m, xin, dense = make_variant(args.variant, base, x)
with torch.inference_mode():
    ref = base(x)
    for _ in range(args.warmup):
        y = m(xin)
    diff = float((dense(y) - ref).abs().max())
build_s = time.perf_counter() - t0
del base  # only the variant's weights stay in memory

rec = {"mode": args.mode, "variant": args.variant, "tag": args.tag, "threads": args.threads, "cpu": args.cpu,
       "affinity": sorted(os.sched_getaffinity(0)), "torch_threads": torch.get_num_threads(),
       "env": {k: os.environ.get(k) for k in ("OMP_NUM_THREADS", "MKL_NUM_THREADS", "OMP_PROC_BIND", "OMP_PLACES")},
       "build_and_warmup_s": build_s, "max_abs_diff_vs_baseline": diff,
       "loadavg_start": open("/proc/loadavg").read().strip()}

if args.mode == "threads":
    from cpuinf.perfcounters import UncoreCounters
    try:
        imc = [UncoreCounters("uncore_imc/cas_count_read/"), UncoreCounters("uncore_imc/cas_count_write/")]
    except Exception as e:  # noqa: BLE001
        imc, rec["imc_error"] = None, repr(e)
    ms = []
    with torch.inference_mode():
        r0 = [c.read_raw() for c in imc] if imc else None
        tl = time.perf_counter()
        for _ in range(args.iters):
            t = time.perf_counter_ns()
            m(xin)
            ms.append((time.perf_counter_ns() - t) / 1e6)
        wall = time.perf_counter() - tl
        r1 = [c.read_raw() for c in imc] if imc else None
    rec["latency_ms"] = runtime.summarize(ms)
    rec["latency_ms_all"] = ms
    if imc:
        rd, wr = (r1[0] - r0[0]) * 64, (r1[1] - r0[1]) * 64       # one CAS = one 64 B line
        rec.update({"dram_read_MB_per_inference": rd / args.iters / 1e6,
                    "dram_write_MB_per_inference": wr / args.iters / 1e6,
                    "dram_read_GBps": rd / wall / 1e9, "dram_write_GBps": wr / wall / 1e9,
                    "dram_note": "socket-wide (includes any other process on the socket)"})
    name = f"threads_{args.variant}_{args.threads}.json"
    print(f"threads {args.variant:22s} N={args.threads:2d} median {rec['latency_ms']['median']:7.2f} ms  "
          f"DRAM rd {rec.get('dram_read_MB_per_inference', float('nan')):6.1f} MB/inf  "
          f"({rec.get('dram_read_GBps', float('nan')):5.2f} GB/s)")
else:
    sync = args.sync
    open(os.path.join(sync, f"ready_{args.cpu}"), "w").write(str(time.time()))
    go = os.path.join(sync, "go")
    while not os.path.exists(go):
        time.sleep(0.01)
    start_at = float(open(go).read().strip() or 0)
    while time.time() < start_at:
        time.sleep(0.001)
    ms, stamps = [], []
    end = time.time() + args.seconds
    with torch.inference_mode():
        while time.time() < end:
            t = time.perf_counter_ns()
            m(xin)
            ms.append((time.perf_counter_ns() - t) / 1e6)
            stamps.append(time.time())
    rec["window_s"] = args.seconds
    rec["inferences"] = len(ms)
    rec["latency_ms"] = runtime.summarize(ms)
    rec["latency_ms_all"] = ms
    rec["t_start"], rec["t_end"] = start_at, stamps[-1] if stamps else start_at
    name = f"instance_{args.tag}.json"
rec["loadavg_end"] = open("/proc/loadavg").read().strip()
with open(os.path.join(args.out, "raw", name), "w") as f:
    json.dump(rec, f, indent=1)
