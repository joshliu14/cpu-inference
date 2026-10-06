#!/usr/bin/env python3
"""Check that each optimization removes the bottleneck it was aimed at.

opt_variants.py says how much faster each variant is; this script records
WHY, with three independent measurements:

A. MaxPool kernel counters (in-process perf_event_open, per call)
   The real max-pool input (relu(bn1(conv1(x))), 1x64x112x112) through:
     nchw            F.max_pool2d on the NCHW tensor (baseline path)
     channels_last   F.max_pool2d on a channels-last tensor (pool only)
     mkldnn          F.max_pool2d on a oneDNN (blocked layout) tensor
     to_cl / to_nchw the two layout conversions maxpool_chlast adds
   Counters: cycles, instructions, branches, branch misses, loads, stores,
   FP arithmetic instructions by width. Normalised per pooled output element.

B. oneDNN primitive census per model variant (ONEDNN verbose, one inference)
   Number and total execution time of every oneDNN primitive kind
   (convolution, reorder, pooling, ...), parsed from verbose 'exec' lines.
   Shows whether a variant removes the per-call layout reorders.

C. ATen operator census per model variant (torch.profiler, one inference)
   Calls and self CPU time per aten:: operator: which kernels each variant
   actually dispatches (thnn_conv2d/MKL vs mkldnn_convolution, batch_norm,
   max_pool2d_with_indices, copies/contiguous, ...).

usage: opt_mechanisms.py --cpu 6 --out DIR [--variants a,b,...]
"""
import argparse
import collections
import contextlib
import csv
import os
import re
import sys
import tempfile
import time

sys.path.insert(0, os.path.join(os.path.dirname(__file__), ".."))
from cpuinf import runtime  # noqa: E402

ap = argparse.ArgumentParser()
ap.add_argument("--cpu", type=int, default=None)
ap.add_argument("--out", required=True)
ap.add_argument("--variants", default="baseline,maxpool_chlast,fold_bn,channels_last,mkldnn_layout,"
                "fold_bn+channels_last,jit_freeze,inductor")
ap.add_argument("--min-ms", type=float, default=200.0, help="min duration per counter sample")
ap.add_argument("--reps", type=int, default=7)
args = ap.parse_args()
runtime.pin(args.cpu)
torch = runtime.configure_torch()
import numpy as np  # noqa: E402
import torch.nn.functional as F  # noqa: E402

from cpuinf.perfcounters import CounterSession  # noqa: E402
from cpuinf.resnet import build  # noqa: E402
from cpuinf.variants import make_variant  # noqa: E402

RAW = os.path.join(args.out, "raw")
PROC = os.path.join(args.out, "processed")
os.makedirs(RAW, exist_ok=True)
os.makedirs(PROC, exist_ok=True)

base = build("random")
x = torch.randn(1, 3, 224, 224, generator=torch.Generator().manual_seed(123))
summary = {"environment": runtime.environment_record(args.cpu)}

# ------------------------------------------------------------------ A
PASSES = {
    "core": ["cycles", "instructions", "branches", "branch-misses",
             "mem_inst_retired.all_loads", "mem_inst_retired.all_stores"],
    "fp": ["cycles", "fp_arith_inst_retired.scalar_single", "fp_arith_inst_retired.128b_packed_single",
           "fp_arith_inst_retired.256b_packed_single", "fp_arith_inst_retired.512b_packed_single"],
}
with torch.inference_mode():
    t_in = base.relu(base.bn1(base.conv1(x)))           # NCHW, 1x64x112x112
t_cl = t_in.contiguous(memory_format=torch.channels_last)
t_mk = t_in.to_mkldnn()
y_cl = F.max_pool2d(t_cl, 3, 2, 1)
n_out = y_cl.numel()
callables = {
    "nchw": lambda: F.max_pool2d(t_in, 3, 2, 1),
    "channels_last": lambda: F.max_pool2d(t_cl, 3, 2, 1),
    "mkldnn": lambda: F.max_pool2d(t_mk, 3, 2, 1),
    "to_cl": lambda: t_in.contiguous(memory_format=torch.channels_last),
    "to_nchw": lambda: y_cl.contiguous(),
}
# Numerical identity of the pooled results.
with torch.inference_mode():
    ref = F.max_pool2d(t_in, 3, 2, 1)
    summary["maxpool_equal"] = {
        "channels_last": bool(torch.equal(F.max_pool2d(t_cl, 3, 2, 1).contiguous(), ref)),
        "mkldnn": bool(torch.equal(F.max_pool2d(t_mk, 3, 2, 1).to_dense(), ref))}

rows_a = []
with torch.inference_mode():
    for pname, evs in PASSES.items():
        cs = CounterSession(evs)
        floor = []
        for _ in range(100):
            cs.start()
            floor.append(cs.stop())
        fl = {k: float(np.median([f[k] for f in floor])) for k in floor[0]}
        for cname, fn in callables.items():
            for _ in range(5):
                fn()
            t = time.perf_counter()
            k = 0
            while time.perf_counter() - t < 0.05:
                fn()
                k += 1
            calls = max(5, int(k * args.min_ms / 50))
            for rep in range(args.reps):
                cs.start()
                t0 = time.perf_counter_ns()
                for _ in range(calls):
                    fn()
                dt = time.perf_counter_ns() - t0
                c = cs.stop()
                row = {"pass": pname, "callable": cname, "rep": rep, "calls": calls, "ns_per_call": dt / calls}
                row.update({k: (v - fl[k]) / calls for k, v in c.items() if not k.startswith("_")})
                rows_a.append(row)
        cs.close()
        print(f"maxpool counters: pass {pname} done")

with open(os.path.join(RAW, "maxpool_counters.csv"), "w", newline="") as f:
    keys = sorted({k for r in rows_a for k in r}, key=lambda k: (k not in ("pass", "callable", "rep"), k))
    w = csv.DictWriter(f, fieldnames=keys)
    w.writeheader()
    w.writerows(rows_a)

import pandas as pd  # noqa: E402

da = pd.DataFrame(rows_a)
med = da.groupby(["callable", "pass"]).median(numeric_only=True)
mp = {}
for cname in callables:
    core = med.loc[(cname, "core")]
    fp = med.loc[(cname, "fp")]
    mp[cname] = {
        "us_per_call": core["ns_per_call"] / 1e3,
        "cycles_per_call": core["cycles"],
        "instructions_per_call": core["instructions"],
        "ipc": core["instructions"] / core["cycles"],
        "cycles_per_output": core["cycles"] / n_out,
        "instructions_per_output": core["instructions"] / n_out,
        "branches_per_output": core["branches"] / n_out,
        "branch_misses_per_output": core["branch-misses"] / n_out,
        "loads_per_output": core["mem_inst_retired.all_loads"] / n_out,
        "stores_per_output": core["mem_inst_retired.all_stores"] / n_out,
        "fp_scalar_per_output": fp["fp_arith_inst_retired.scalar_single"] / n_out,
        "fp_128b_per_output": fp["fp_arith_inst_retired.128b_packed_single"] / n_out,
        "fp_256b_per_output": fp["fp_arith_inst_retired.256b_packed_single"] / n_out,
        "fp_512b_per_output": fp["fp_arith_inst_retired.512b_packed_single"] / n_out,
    }
summary["maxpool"] = {"input_shape": list(t_in.shape), "outputs": n_out, "per_callable": mp}
print(pd.DataFrame(mp).T.round(3).to_string())


# ------------------------------------------------------------------ B + C
@contextlib.contextmanager
def capture_fd1():
    """Redirect the process-level stdout (fd 1) to a temp file: oneDNN's
    verbose output is written with printf, bypassing sys.stdout."""
    sys.stdout.flush()
    tmp = tempfile.TemporaryFile(mode="w+")
    saved = os.dup(1)
    os.dup2(tmp.fileno(), 1)
    box = {}
    try:
        yield box
    finally:
        sys.stdout.flush()
        os.dup2(saved, 1)
        os.close(saved)
        tmp.seek(0)
        box["text"] = tmp.read()
        tmp.close()


def onednn_census(text):
    """Parse 'onednn_verbose,...,primitive,exec,cpu,<kind>,<impl>,...,<ms>' lines."""
    agg = collections.defaultdict(lambda: [0, 0.0])
    impls = collections.Counter()
    for line in text.splitlines():
        if ",exec," not in line or "verbose" not in line:
            continue
        parts = line.split(",")
        try:
            i = parts.index("exec")
            kind, impl = parts[i + 2], parts[i + 3]
            ms = float(parts[-1])
        except (ValueError, IndexError):
            continue
        agg[kind][0] += 1
        agg[kind][1] += ms
        impls[(kind, impl)] += 1
    return agg, impls


rows_b, rows_c, census = [], [], {}
for name in args.variants.split(","):
    try:
        m, xin, _ = make_variant(name, base, x)
        with torch.inference_mode():
            for _ in range(5):
                m(xin)
            with capture_fd1() as cap:
                with torch.backends.mkldnn.verbose(torch.backends.mkldnn.VERBOSE_ON):
                    m(xin)
            from torch.profiler import ProfilerActivity, profile
            with profile(activities=[ProfilerActivity.CPU]) as prof:
                m(xin)
    except Exception as e:  # noqa: BLE001
        print(f"{name}: FAILED {e!r}"[:300])
        census[name] = {"error": repr(e)[:1000]}
        continue
    open(os.path.join(RAW, f"onednn_verbose_{name}.txt"), "w").write(cap["text"])
    agg, impls = onednn_census(cap["text"])
    for kind, (n, ms) in sorted(agg.items()):
        rows_b.append({"variant": name, "primitive": kind, "calls": n, "total_ms": ms})
    ops = {}
    for ev in prof.key_averages():
        if ev.key.startswith("aten::") or ev.key.startswith("mkldnn") or ev.key.startswith("prim::") \
                or ev.key.startswith("ipex") or ev.key.startswith("inductor") or ev.key.startswith("Torch-Compiled"):
            ops[ev.key] = (ev.count, ev.self_cpu_time_total / 1e3)
            rows_c.append({"variant": name, "op": ev.key, "calls": ev.count,
                           "self_cpu_ms": ev.self_cpu_time_total / 1e3})
    census[name] = {
        "onednn": {k: {"calls": v[0], "total_ms": v[1]} for k, v in agg.items()},
        "onednn_impls": {f"{k}|{i}": n for (k, i), n in impls.items()},
        "aten_top": dict(sorted(ops.items(), key=lambda kv: -kv[1][1])[:25]),
    }
    print(f"{name:22s} oneDNN: " + ", ".join(f"{k} {v[0]}x {v[1]:.2f} ms" for k, v in sorted(agg.items())))

pd.DataFrame(rows_b).to_csv(os.path.join(PROC, "onednn_census.csv"), index=False)
pd.DataFrame(rows_c).to_csv(os.path.join(PROC, "aten_census.csv"), index=False)
summary["census"] = census
runtime.dump_json(os.path.join(PROC, "mechanisms.json"), summary)
print("done")
