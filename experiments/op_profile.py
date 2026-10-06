#!/usr/bin/env python3
"""LEVELS 1-3, 5 -- per-operator time and hardware counters for ResNet-50.

Three ways of running every operator, so their differences can be compared:

  inmodel           the operator inside a real forward pass. Forward hooks on
                    each leaf module start/stop timing or counting right
                    around that module's call. Cache contents are whatever the
                    previous operators left behind (the realistic case).
  standalone_hot    the same module (same weights) on a copy of the same input
                    tensor, called back-to-back in a loop. Input and weights
                    stay cache-resident if they fit: a best case.
  standalone_cold   one call at a time, after streaming a 256 MiB buffer to
                    evict caches: a worst case for data movement.

Measurement passes (one counter group set per pass so nothing multiplexes):
  time, core, sw, topdown, flops, loads, traffic, stalls, ports, frontend
  (see cpuinf/events.PASSES), plus 'dram' (socket-wide uncore IMC CAS
  counts read around each operator) and 'blocktime' (bottleneck/stage timing).

Raw per-iteration values are written in long format; the empty start/stop
"floor" of each pass is recorded separately so analysis can subtract it.

usage: op_profile.py --cpu 6 --out DIR [--modes inmodel,standalone_hot,standalone_cold]
                     [--passes time,core,...] [--iters 30] [--warmup 10]
"""
import argparse
import copy
import csv
import os
import statistics
import sys
import time

sys.path.insert(0, os.path.join(os.path.dirname(__file__), ".."))
from cpuinf import runtime  # noqa: E402

ap = argparse.ArgumentParser()
ap.add_argument("--cpu", type=int, default=None)
ap.add_argument("--out", required=True)
ap.add_argument("--modes", default="inmodel,standalone_hot,standalone_cold")
ap.add_argument("--passes", default="time,blocktime,core,sw,tdgp,flops,loads,traffic,stalls,ports,frontend,dram")
ap.add_argument("--standalone-passes", default="time,core,tdgp,flops,loads,traffic,stalls")
ap.add_argument("--append", action="store_true",
                help="add passes to an existing result directory (merge op_profile_meta.json)")
ap.add_argument("--iters", type=int, default=30)
ap.add_argument("--warmup", type=int, default=10)
ap.add_argument("--hot-min-ms", type=float, default=30.0, help="min loop duration per standalone_hot sample")
ap.add_argument("--reps", type=int, default=7, help="samples per op in standalone modes")
ap.add_argument("--layers", default="", help="comma list of layer names to restrict standalone runs")
args = ap.parse_args()
runtime.pin(args.cpu)
torch = runtime.configure_torch()

import json  # noqa: E402

from cpuinf.events import PASSES  # noqa: E402
from cpuinf.manifest import build_manifest  # noqa: E402
from cpuinf.perfcounters import CounterSession, UncoreCounters, plan_groups  # noqa: E402
from cpuinf.resnet import Bottleneck, build, leaf_modules  # noqa: E402

RAW = os.path.join(args.out, "raw")
PROC = os.path.join(args.out, "processed")
os.makedirs(RAW, exist_ok=True)
os.makedirs(PROC, exist_ok=True)

SUPPORTED = {e["key"]: e["event"] for e in json.load(open(os.path.join(
    os.path.dirname(__file__), "..", "results", "perf_events.json")))["events"] if e["supported"]}


NAME2KEY = {v: k for k, v in SUPPORTED.items()}


def expand_pass(p):
    """A logical pass -> verified sub-passes [(name, keys, events, missing)].
    Each sub-pass fits on the PMU without multiplexing (plan_groups)."""
    if p in ("time", "blocktime", "dram"):
        return [(p, [], [], [])]
    keys = [k for k in PASSES[p] if k in SUPPORTED]
    missing = [k for k in PASSES[p] if k not in SUPPORTED]
    runs = plan_groups([SUPPORTED[k] for k in keys])
    if len(runs) == 1:
        return [(p, [NAME2KEY[n] for n in runs[0]], runs[0], missing)]
    return [(f"{p}.{i}", [NAME2KEY[n] for n in r], r, missing) for i, r in enumerate(runs)]


def measure_floor(cs, n=300):
    vals = []
    for _ in range(n):
        cs.start()
        vals.append(cs.stop())
    keys = [k for k in vals[0] if not k.startswith("_")]
    return {k: statistics.median(v[k] for v in vals) for k in keys}


model = build("random")
x = torch.randn(1, 3, 224, 224, generator=torch.Generator().manual_seed(123))
leaves = leaf_modules(model)
manifest = build_manifest(model)
with open(os.path.join(PROC, "manifest.csv"), "w", newline="") as f:
    cols = sorted({k for r in manifest for k in r}, key=lambda k: list(manifest[0].keys()).index(k)
                  if k in manifest[0] else 999)
    w = csv.DictWriter(f, fieldnames=cols)
    w.writeheader()
    w.writerows(manifest)

meta = {"config": vars(args), "environment": runtime.environment_record(args.cpu), "passes": {}}
META_PATH = os.path.join(PROC, "op_profile_meta.json")
if args.append and os.path.exists(META_PATH):
    old_meta = json.load(open(META_PATH))
    meta["passes"] = old_meta["passes"]
    meta["appended_runs"] = old_meta.get("appended_runs", []) + [
        {"config": vars(args), "environment": meta["environment"]}]
    meta["config"], meta["environment"] = old_meta["config"], old_meta["environment"]


def forward():
    with torch.inference_mode():
        return model(x)


for _ in range(args.warmup):
    forward()


# ----------------------------------------------------------------- inmodel
def run_inmodel(pass_name, keys, names, missing):
    rows = []
    handles = []
    state = {"iter": 0}
    if pass_name == "blocktime":
        targets = [(n, m) for n, m in model.named_modules()
                   if isinstance(m, Bottleneck) or n in ("layer1", "layer2", "layer3", "layer4")]
    else:
        targets = leaves
    cs = CounterSession(names) if names else None
    unc = None
    floor = {}
    bg = {}
    if pass_name == "dram":
        unc = [UncoreCounters("uncore_imc/cas_count_read/"), UncoreCounters("uncore_imc/cas_count_write/")]
        scale_bytes = unc[0].scale * (1 << 20)   # perf scale is MiB per CAS -> bytes per CAS (=64)
        r0 = [u.read_raw() for u in unc]
        t0 = time.perf_counter()
        time.sleep(2.0)
        r1 = [u.read_raw() for u in unc]
        dt = time.perf_counter() - t0
        bg = {"read_Bps": (r1[0] - r0[0]) * scale_bytes / dt, "write_Bps": (r1[1] - r0[1]) * scale_bytes / dt,
              "bytes_per_cas": scale_bytes}
    if cs:
        floor = measure_floor(cs)
    ctx = {}

    def pre(mod, inp, name=None):
        if unc:
            ctx[name] = ([u.read_raw() for u in unc], time.perf_counter_ns())
        elif cs:
            cs.start()
            ctx[name] = time.perf_counter_ns()
        else:
            ctx[name] = time.perf_counter_ns()

    def post(mod, inp, out, name=None):
        t1 = time.perf_counter_ns()
        if unc:
            v1 = [u.read_raw() for u in unc]
            v0, t0 = ctx.pop(name)
            rows.append({"iter": state["iter"], "layer": name, "ns": t1 - t0,
                         "dram_read_bytes": (v1[0] - v0[0]) * scale_bytes,
                         "dram_write_bytes": (v1[1] - v0[1]) * scale_bytes})
            return
        if cs:
            c = cs.stop()
            t0 = ctx.pop(name)
            row = {"iter": state["iter"], "layer": name, "ns": t1 - t0,
                   "multiplexed": c["_multiplexed"]}
            row.update({k: c[n] for k, n in zip(keys, names)})
            rows.append(row)
        else:
            rows.append({"iter": state["iter"], "layer": name, "ns": t1 - ctx.pop(name)})

    for n, m in targets:
        handles.append(m.register_forward_pre_hook(lambda mod, inp, n=n: pre(mod, inp, n)))
        handles.append(m.register_forward_hook(lambda mod, inp, out, n=n: post(mod, inp, out, n)))
    totals = []
    try:
        for _ in range(3):
            forward()          # warm the hook path itself
        rows.clear()
        for i in range(args.iters):
            state["iter"] = i
            t = time.perf_counter_ns()
            forward()
            totals.append(time.perf_counter_ns() - t)
    finally:
        for h in handles:
            h.remove()
        if cs:
            cs.close()
        # Uncore events must be closed: prctl() toggles every event this thread
        # owns, and toggling socket-wide events bound to another CPU costs IPIs.
        for u in unc or []:
            u.close()
    with open(os.path.join(RAW, f"inmodel_{pass_name}.csv"), "w", newline="") as f:
        w = csv.DictWriter(f, fieldnames=list(rows[0].keys()))
        w.writeheader()
        w.writerows(rows)
    meta["passes"][f"inmodel_{pass_name}"] = {
        "events": dict(zip(keys, names)), "unavailable": missing, "floor": floor,
        "dram_background": bg, "forward_total_ns": totals,
        "any_multiplexing": any(r.get("multiplexed") for r in rows)}
    print(f"inmodel {pass_name:10s} forward median {statistics.median(totals) / 1e6:.2f} ms "
          f"({len(rows)} rows){' MULTIPLEXED' if meta['passes'][f'inmodel_{pass_name}']['any_multiplexing'] else ''}")


# -------------------------------------------------------------- standalone
def capture_inputs():
    """Real input tensors of every leaf from one forward pass (cloned)."""
    caught = {}
    hs = [m.register_forward_pre_hook(lambda mod, inp, n=n: caught.setdefault(n, tuple(t.clone() for t in inp)))
          for n, m in leaves]
    forward()
    for h in hs:
        h.remove()
    return caught


FLUSH = None


def flush_caches():
    global FLUSH
    if FLUSH is None:
        FLUSH = torch.empty(64 << 20, dtype=torch.float32)   # 256 MiB > 52.5 MiB L3
    FLUSH.add_(1.0)


def run_standalone(mode, pass_name, keys, names, missing, inputs, only):
    cs = CounterSession(names) if names else None
    floor = measure_floor(cs) if cs else {}
    rows = []
    for n, m in leaves:
        if only and n not in only:
            continue
        mod = copy.deepcopy(m)
        inp = inputs[n]
        work = [tuple(t.clone() for t in inp)]

        def call():
            with torch.inference_mode():
                mod(*work[0])

        call()
        if mode == "standalone_hot":
            t = time.perf_counter_ns()
            k = 0
            while time.perf_counter_ns() - t < 5e6:
                call()
                k += 1
            per = (time.perf_counter_ns() - t) / k
            calls = max(1, int(args.hot_min_ms * 1e6 / per))
        else:
            calls = 1
        for r in range(args.reps):
            if mode == "standalone_cold":
                flush_caches()
            if cs:
                cs.start()
            t = time.perf_counter_ns()
            for _ in range(calls):
                call()
            dt = time.perf_counter_ns() - t
            row = {"rep": r, "layer": n, "calls": calls, "ns": dt}
            if cs:
                c = cs.stop()
                row["multiplexed"] = c["_multiplexed"]
                row.update({kk: c[nn] for kk, nn in zip(keys, names)})
            rows.append(row)
    if cs:
        cs.close()
    with open(os.path.join(RAW, f"{mode}_{pass_name}.csv"), "w", newline="") as f:
        w = csv.DictWriter(f, fieldnames=list(rows[0].keys()))
        w.writeheader()
        w.writerows(rows)
    meta["passes"][f"{mode}_{pass_name}"] = {"events": dict(zip(keys, names)), "unavailable": missing,
                                             "floor": floor,
                                             "any_multiplexing": any(r.get("multiplexed") for r in rows)}
    print(f"{mode} {pass_name:10s} done ({len(rows)} rows)")


modes = args.modes.split(",")
if "inmodel" in modes:
    for p in args.passes.split(","):
        for sub in expand_pass(p):
            run_inmodel(*sub)
standalone = [m for m in modes if m.startswith("standalone")]
if standalone:
    inputs = capture_inputs()
    only = set(args.layers.split(",")) if args.layers else set()
    for mode in standalone:
        for p in args.standalone_passes.split(","):
            for sub in expand_pass(p):
                run_standalone(mode, *sub, inputs, only)

runtime.dump_json(META_PATH, meta)
print("done", args.out)
