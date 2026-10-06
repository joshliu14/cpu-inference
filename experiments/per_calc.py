#!/usr/bin/env python3
"""Cost of ONE calculation inside every ResNet-50 operator, and where it goes.

For each of the 175 leaf operators of the canonical baseline (one core):

  calculations   the operator's unit of work:
                   conv / fc        multiply-accumulates (MACs)
                   batchnorm        elements (one multiply-add each)
                   relu, add        elements (one max / one add each)
                   maxpool          comparisons (valid 3x3 window elements)
                   avgpool          elements summed
  time           in-model time (forward hooks), median of --iters inferences
  parts          library-level split, from oneDNN and MKL verbose timers for
                 the same operator (one marker line per operator is written to
                 stdout between the libraries' own lines):
                   kernel             oneDNN convolution / MKL SGEMM, SGEMV
                   weight re-layout   oneDNN reorder of conv weights
                   act. re-layout     oneDNN reorder of activations
                   framework/other    time - sum of the above (Python,
                                      dispatcher, allocation, bias copies; for
                                      ATen-native ops this is the whole op)
Per-calculation time = time / calculations. analysis/analyze_per_calc.py
compares it with the core-level cost of one calculation measured by
microbench/bin/compute (register-only loops).

usage: per_calc.py --cpu 6 --out DIR [--iters 30 --verbose-iters 5]
"""
import argparse
import collections
import json
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
ap.add_argument("--iters", type=int, default=30)
ap.add_argument("--warmup", type=int, default=10)
ap.add_argument("--verbose-iters", type=int, default=5)
ap.add_argument("--threads", type=int, default=1, help="intra-op threads (caller sets OMP_NUM_THREADS)")
ap.add_argument("--cpus", default="", help="CPU list for multi-thread runs, e.g. 1-8 (overrides --cpu)")
ap.add_argument("--tag", default="", help="suffix for output files (multi-thread runs)")
args = ap.parse_args()
if args.cpus:
    cl = []
    for part in args.cpus.split(","):
        a_, _, b_ = part.partition("-")
        cl += list(range(int(a_), int(b_ or a_) + 1))
    os.sched_setaffinity(0, set(cl))
else:
    runtime.pin(args.cpu)
torch = runtime.configure_torch(args.threads)
import torch.nn.functional as F  # noqa: E402

from cpuinf.resnet import build, leaf_modules  # noqa: E402

os.makedirs(os.path.join(args.out, "raw"), exist_ok=True)
os.makedirs(os.path.join(args.out, "processed"), exist_ok=True)
model = build("random")
x = torch.randn(1, 3, 224, 224, generator=torch.Generator().manual_seed(123))
leaves = [(n, m) for n, m in leaf_modules(model)]


def kind(m):
    t = type(m).__name__
    if t == "Conv2d":
        return f"conv{m.kernel_size[0]}x{m.kernel_size[0]}"
    return {"BatchNorm2d": "batchnorm", "ReLU": "relu", "MaxPool2d": "maxpool", "Add": "add",
            "AdaptiveAvgPool2d": "avgpool", "Linear": "fc", "Flatten": "flatten"}.get(t, t)


# ---- shapes and calculation counts (one recording forward pass)
shapes = {}
hs = [m.register_forward_hook(lambda m, i, o, n=n: shapes.__setitem__(n, (tuple(i[0].shape), tuple(o.shape))))
      for n, m in leaves]
with torch.inference_mode():
    model(x)
for h in hs:
    h.remove()


def calcs(n, m):
    (ish, osh), k = shapes[n], kind(m)
    out_el = 1
    for d in osh:
        out_el *= d
    if k.startswith("conv"):
        return out_el * (m.in_channels // m.groups) * m.kernel_size[0] * m.kernel_size[1], "MAC"
    if k == "fc":
        return m.in_features * m.out_features, "MAC"
    if k in ("batchnorm", "relu", "add"):
        return out_el, "element"
    if k == "maxpool":
        ones = torch.ones(1, 1, ish[2], ish[3])
        valid = F.avg_pool2d(ones, m.kernel_size, m.stride, m.padding, count_include_pad=False)
        frac = F.avg_pool2d(ones, m.kernel_size, m.stride, m.padding, count_include_pad=True) / valid
        per_ch = float((frac * m.kernel_size * m.kernel_size).sum())   # valid window elements
        return int(round(per_ch)) * ish[1], "comparison"
    if k == "avgpool":
        n_in = 1
        for d in ish:
            n_in *= d
        return n_in, "element"
    return 0, "-"


# ---- timing pass (no verbose)
t0, acc = {}, collections.defaultdict(list)
hs = []
for n, m in leaves:
    hs.append(m.register_forward_pre_hook(lambda m, i, n=n: t0.__setitem__(n, time.perf_counter_ns())))
    hs.append(m.register_forward_hook(lambda m, i, o, n=n: acc[n].append(time.perf_counter_ns() - t0[n])))
e2e = []
with torch.inference_mode():
    for _ in range(args.warmup):
        model(x)
    acc.clear()
    for _ in range(args.iters):
        t = time.perf_counter_ns()
        model(x)
        e2e.append(time.perf_counter_ns() - t)
for h in hs:
    h.remove()

# ---- verbose pass: library timers per operator, attributed with stdout markers
def marker(text):
    os.write(1, text.encode())   # hooks must return None (a returned value replaces the input/output)


hs = []
for n, m in leaves:
    hs.append(m.register_forward_pre_hook(lambda m, i, n=n: marker(f"@@OP {n}\n")))
    hs.append(m.register_forward_hook(lambda m, i, o, n=n: marker(f"@@END {n}\n")))
sys.stdout.flush()
tmp = tempfile.TemporaryFile(mode="w+")
saved = os.dup(1)
os.dup2(tmp.fileno(), 1)
try:
    with torch.inference_mode():
        for it in range(args.verbose_iters):
            marker(f"@@ITER {it}\n")
            with torch.backends.mkldnn.verbose(torch.backends.mkldnn.VERBOSE_ON), \
                    torch.backends.mkl.verbose(torch.backends.mkl.VERBOSE_ON):
                model(x)
finally:
    sys.stdout.flush()
    os.dup2(saved, 1)
    os.close(saved)
tmp.seek(0)
vtext = tmp.read()
open(os.path.join(args.out, "raw", f"verbose_per_op{args.tag}.txt"), "w").write(vtext)
for h in hs:
    h.remove()

parts = collections.defaultdict(lambda: collections.defaultdict(list))   # layer -> part -> [ms per iter]
cur, it_parts = None, None
mkl_ms = re.compile(r"MKL_VERBOSE\s+(\w+)\(.*?\)\s+([\d.]+)(us|ms|s)\b")
for line in vtext.splitlines():
    if line.startswith("@@OP "):
        cur, it_parts = line[5:].strip(), collections.defaultdict(float)
    elif line.startswith("@@END "):
        if cur is not None:
            for k, v in it_parts.items():
                parts[cur][k].append(v)
            parts[cur]["_seen"].append(1)
        cur = None
    elif cur is not None and ",exec," in line and "verbose" in line:
        p = line.split(",")
        i = p.index("exec")
        prim, ms = p[i + 2], float(p[-1])
        if prim == "reorder":
            dims = [int(d) for d in p[-2].split("x") if d.isdigit()]
            it_parts["act. re-layout" if dims and dims[0] == 1 else "weight re-layout"] += ms
        elif prim in ("convolution", "inner_product"):
            it_parts["kernel"] += ms
        else:
            it_parts[f"onednn {prim}"] += ms
    elif cur is not None and line.startswith("MKL_VERBOSE") and "Intel(R)" not in line:
        m = mkl_ms.search(line)
        if m:
            v = float(m.group(2)) * {"us": 1e-3, "ms": 1.0, "s": 1e3}[m.group(3)]
            it_parts["kernel"] += v

rows = []
for n, m in leaves:
    k = kind(m)
    if k == "flatten":
        continue
    c, unit = calcs(n, m)
    v = sorted(acc[n])
    t_ms = v[len(v) // 2] / 1e6
    seen = len(parts[n]["_seen"]) or 1
    med = lambda L: sorted(L + [0.0] * (seen - len(L)))[seen // 2] if L else 0.0  # noqa: E731
    kern, wre, are = med(parts[n]["kernel"]), med(parts[n]["weight re-layout"]), med(parts[n]["act. re-layout"])
    other_lib = sum(med(L) for p_, L in parts[n].items() if p_.startswith("onednn "))
    rows.append({"layer": n, "op": k, "input_shape": "x".join(map(str, shapes[n][0])),
                 "output_shape": "x".join(map(str, shapes[n][1])), "calculations": c, "unit": unit,
                 "time_ms": t_ms, "time_ms_p5": v[int(0.05 * (len(v) - 1))] / 1e6,
                 "time_ms_p95": v[int(0.95 * (len(v) - 1))] / 1e6,
                 "kernel_ms": kern, "weight_relayout_ms": wre, "act_relayout_ms": are,
                 "other_library_ms": other_lib,
                 "framework_other_ms": max(t_ms - kern - wre - are - other_lib, 0.0)})

import csv  # noqa: E402

with open(os.path.join(args.out, "raw", f"per_calc_layers{args.tag}.csv"), "w", newline="") as f:
    w = csv.DictWriter(f, fieldnames=list(rows[0].keys()))
    w.writeheader()
    w.writerows(rows)
meta = {"environment": runtime.environment_record(args.cpu), "threads": args.threads, "cpus": args.cpus,
        "e2e_ms_median": sorted(e2e)[len(e2e) // 2] / 1e6, "iters": args.iters,
        "verbose_iters": args.verbose_iters, "sum_of_ops_ms": sum(r["time_ms"] for r in rows)}
json.dump(meta, open(os.path.join(args.out, "processed", f"per_calc_meta{args.tag}.json"), "w"), indent=1)
print(f"e2e {meta['e2e_ms_median']:.2f} ms, sum of ops {meta['sum_of_ops_ms']:.2f} ms, {len(rows)} operators")
