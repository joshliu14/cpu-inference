#!/usr/bin/env python3
"""LEVEL 0 -- wall-clock latency of one complete ResNet-50 inference.

Phases are timed separately so that only steady-state inference is reported
as "inference latency":
  import      importing torch/torchvision
  create      constructing the module tree
  weights     initialising (seeded) or loading (ImageNet) the weights
  input       creating the 1x3x224x224 input tensor
  warmup      first N inferences (allocator, oneDNN primitive cache, caches, ...)
  timed       the measured inferences

Each timed inference also records cycles / instructions / page faults for the
forward call only (in-process perf_event_open), so wall time can be checked
against CPU cycles at the measured frequency.

usage: e2e_latency.py --cpu 6 --iters 200 --warmup 20 --out results/<dir>
"""
import argparse
import csv
import os
import sys
import time

sys.path.insert(0, os.path.join(os.path.dirname(__file__), ".."))
from cpuinf import runtime  # noqa: E402  (sets thread env vars before torch import)

ap = argparse.ArgumentParser()
ap.add_argument("--cpu", type=int, default=None)
ap.add_argument("--iters", type=int, default=200)
ap.add_argument("--warmup", type=int, default=20)
ap.add_argument("--weights", default="random", choices=["random", "imagenet"])
ap.add_argument("--impl", default="explicit", choices=["explicit", "torchvision"])
ap.add_argument("--no-counters", action="store_true")
ap.add_argument("--tag", default="")
ap.add_argument("--threads", type=int, default=1, help="intra-op threads (baseline: 1)")
ap.add_argument("--out", required=True)
args = ap.parse_args()
runtime.pin(args.cpu)

t0 = time.perf_counter()
import torch  # noqa: E402
import torchvision  # noqa: E402
t_import = time.perf_counter() - t0
runtime.configure_torch(args.threads)
from cpuinf.perfcounters import CounterSession  # noqa: E402
from cpuinf.resnet import ResNet50  # noqa: E402

phases = {"import_s": t_import, "process_start_to_import_end_s": time.perf_counter() - runtime.T_PROCESS_START}

t0 = time.perf_counter()
model = ResNet50() if args.impl == "explicit" else torchvision.models.resnet50(weights=None)
phases["create_s"] = time.perf_counter() - t0

t0 = time.perf_counter()
if args.weights == "imagenet":
    sd = torchvision.models.resnet50(weights=torchvision.models.ResNet50_Weights.IMAGENET1K_V1).state_dict()
else:
    torch.manual_seed(0)
    sd = torchvision.models.resnet50(weights=None).state_dict()
model.load_state_dict(sd)
model.eval()
phases["weights_s"] = time.perf_counter() - t0

t0 = time.perf_counter()
x = torch.randn(1, 3, 224, 224, generator=torch.Generator().manual_seed(123))
phases["input_s"] = time.perf_counter() - t0

names = ["cycles", "instructions", "ref-cycles", "page-faults", "context-switches", "cpu-migrations"]
cs = None if args.no_counters else CounterSession(names)
rows = []


def one(phase, i):
    if cs:
        cs.start()
    t = time.perf_counter_ns()
    with torch.inference_mode():
        model(x)
    dt = time.perf_counter_ns() - t
    c = cs.stop() if cs else {}
    rows.append({"phase": phase, "iter": i, "ns": dt, **{k: c.get(k) for k in names},
                 "multiplexed": c.get("_multiplexed")})


t0 = time.perf_counter()
for i in range(args.warmup):
    one("warmup", i)
phases["warmup_s"] = time.perf_counter() - t0
t0 = time.perf_counter()
for i in range(args.iters):
    one("timed", i)
phases["timed_s"] = time.perf_counter() - t0

os.makedirs(os.path.join(args.out, "raw"), exist_ok=True)
os.makedirs(os.path.join(args.out, "processed"), exist_ok=True)
tag = f"_{args.tag}" if args.tag else ""
with open(os.path.join(args.out, "raw", f"e2e_iters{tag}.csv"), "w", newline="") as f:
    w = csv.DictWriter(f, fieldnames=list(rows[0].keys()))
    w.writeheader()
    w.writerows(rows)

timed = [r for r in rows if r["phase"] == "timed"]
ms = [r["ns"] / 1e6 for r in timed]
summary = {
    "config": vars(args), "environment": runtime.environment_record(args.cpu), "phases": phases,
    "latency_ms": runtime.summarize(ms),
    "first_warmup_iteration_ms": rows[0]["ns"] / 1e6,
}
if cs:
    cyc = [r["cycles"] for r in timed]
    ins = [r["instructions"] for r in timed]
    summary["cycles"] = runtime.summarize(cyc)
    summary["instructions"] = runtime.summarize(ins)
    summary["ipc_median"] = summary["instructions"]["median"] / summary["cycles"]["median"]
    summary["freq_ghz_median"] = runtime.summarize([r["cycles"] / r["ref-cycles"] * 2.1 for r in timed])["median"]
    summary["page_faults_per_inference"] = runtime.summarize([r["page-faults"] for r in timed])
    summary["context_switches_total"] = sum(r["context-switches"] for r in timed)
    summary["cpu_migrations_total"] = sum(r["cpu-migrations"] for r in timed)
    summary["any_multiplexing"] = any(r["multiplexed"] for r in timed)
runtime.dump_json(os.path.join(args.out, "processed", f"e2e_summary{tag}.json"), summary)
L = summary["latency_ms"]
print(f"[{args.impl}/{args.weights}{tag}] latency ms: median {L['median']:.3f} mean {L['mean']:.3f} "
      f"sd {L['stddev']:.3f} min {L['min']:.3f} p5 {L['p5']:.3f} p95 {L['p95']:.3f} max {L['max']:.3f}"
      + (f" | IPC {summary['ipc_median']:.2f} | {summary['freq_ghz_median']:.3f} GHz | "
         f"faults/inf {summary['page_faults_per_inference']['median']:.0f}" if cs else ""))
print("phases (s):", {k: round(v, 3) for k, v in phases.items()})
