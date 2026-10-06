#!/usr/bin/env python3
"""Which code does PyTorch actually run for each ResNet-50 operator?

Three independent sources of evidence:

1. ATen dispatch chain (torch.profiler). Each leaf module call is wrapped in
   record_function("LEAF::<name>"); the ATen ops recorded underneath it show
   the path through the dispatcher, e.g.
   aten::conv2d -> aten::convolution -> aten::_convolution -> aten::mkldnn_convolution
2. oneDNN verbose log (ONEDNN_VERBOSE=1, run in a child process): every
   oneDNN primitive execution with its implementation name (e.g.
   jit:avx512_core = JIT-generated AVX-512 code), memory formats and time.
3. MKL verbose log (MKL_VERBOSE=1): every MKL BLAS call with sizes and time.

Shared-library symbols (nm) for the kernels involved are collected by
scripts/run_backend_probe.sh, and perf sampling (instruction_profile) shows
which of them is hot.

usage: backend_probe.py --cpu 6 --out DIR             (parent: runs everything)
       backend_probe.py --child verbose --cpu 6       (internal)
"""
import argparse
import collections
import csv
import os
import re
import subprocess
import sys

sys.path.insert(0, os.path.join(os.path.dirname(__file__), ".."))
from cpuinf import runtime  # noqa: E402

ap = argparse.ArgumentParser()
ap.add_argument("--cpu", type=int, default=None)
ap.add_argument("--out", default=None)
ap.add_argument("--child", default=None)
args = ap.parse_args()
runtime.pin(args.cpu)
torch = runtime.configure_torch()
from cpuinf.resnet import build, leaf_modules  # noqa: E402


def make():
    model = build("random")
    x = torch.randn(1, 3, 224, 224, generator=torch.Generator().manual_seed(123))
    with torch.inference_mode():
        for _ in range(3):
            model(x)
    return model, x


if args.child == "verbose":
    # One marked inference; the parent parses stdout (oneDNN/MKL write there).
    model, x = make()
    leaves = leaf_modules(model)
    hs = []
    for n, m in leaves:
        hs.append(m.register_forward_pre_hook(lambda mod, inp, n=n: print(f"@@LEAF_BEGIN {n}", flush=True)))
        hs.append(m.register_forward_hook(lambda mod, inp, out, n=n: print(f"@@LEAF_END {n}", flush=True)))
    print("@@INFERENCE_BEGIN", flush=True)
    with torch.inference_mode():
        model(x)
    print("@@INFERENCE_END", flush=True)
    sys.exit(0)

out = args.out
os.makedirs(os.path.join(out, "raw"), exist_ok=True)
os.makedirs(os.path.join(out, "processed"), exist_ok=True)

# ---------------------------------------------------------- 1. ATen chain
from torch.profiler import ProfilerActivity, profile, record_function  # noqa: E402

model, x = make()
leaves = leaf_modules(model)
ctxs = {}


def pre(mod, inp, n):
    ctxs[n] = record_function(f"LEAF::{n}")
    ctxs[n].__enter__()


def post(mod, inp, outp, n):
    ctxs.pop(n).__exit__(None, None, None)


hs = []
for n, m in leaves:
    hs.append(m.register_forward_pre_hook(lambda mod, inp, n=n: pre(mod, inp, n)))
    hs.append(m.register_forward_hook(lambda mod, inp, outp, n=n: post(mod, inp, outp, n)))
with profile(activities=[ProfilerActivity.CPU], record_shapes=True) as prof, torch.inference_mode():
    model(x)
for h in hs:
    h.remove()


def chain(ev, depth=0):
    """Depth-first list of (depth, name, self_us) under an event."""
    rows = [(depth, ev.name, ev.self_cpu_time_total)]
    for c in sorted(ev.cpu_children, key=lambda e: e.time_range.start):
        rows += chain(c, depth + 1)
    return rows


from cpuinf.manifest import _op_kind  # noqa: E402

kind = {n: _op_kind(m) for n, m in leaves}
per_leaf = {}
for ev in prof.events():
    if ev.name.startswith("LEAF::"):
        per_leaf[ev.name[6:]] = chain(ev)[1:]

signatures = collections.OrderedDict()
with open(os.path.join(out, "raw", "aten_chain_per_layer.csv"), "w", newline="") as f:
    w = csv.writer(f)
    w.writerow(["layer", "operation", "depth", "aten_op", "self_us"])
    for n, _ in leaves:
        rows = per_leaf.get(n, [])
        for d, name, us in rows:
            w.writerow([n, kind[n], d, name, f"{us:.1f}"])
        sig = " -> ".join(name for d, name, _ in rows if d <= 6)
        signatures.setdefault((kind[n], sig), []).append(n)

# --------------------------------------------- 2+3. oneDNN and MKL verbose
env = dict(os.environ, ONEDNN_VERBOSE="1", MKL_VERBOSE="1", OMP_NUM_THREADS="1", MKL_NUM_THREADS="1")
cmd = [sys.executable, __file__, "--child", "verbose"] + (["--cpu", str(args.cpu)] if args.cpu is not None else [])
log = subprocess.run(cmd, env=env, capture_output=True, text=True).stdout
open(os.path.join(out, "raw", "verbose_onednn_mkl.log"), "w").write(log)

inside, current = False, None
prims = collections.defaultdict(list)       # layer -> [(kind, impl, desc, ms)]
mkl = collections.defaultdict(list)
mkl_header = ""
for line in log.splitlines():
    if line.startswith("MKL_VERBOSE Intel(R) MKL") or line.startswith("MKL_VERBOSE oneMKL"):
        mkl_header = line
    if line == "@@INFERENCE_BEGIN":
        inside = True
        continue
    if line == "@@INFERENCE_END":
        inside = False
    if not inside:
        continue
    if line.startswith("@@LEAF_BEGIN"):
        current = line.split()[1]
    elif line.startswith("@@LEAF_END"):
        current = None
    elif line.startswith("onednn_verbose") and ",exec," in line and current:
        p = line.split(",")
        # onednn_verbose,v1,primitive,exec,cpu,<kind>,<impl>,<prop>,<mds>,<attr>,<aux>,<desc>,<ms>
        prims[current].append((p[5], p[6], p[11] if len(p) > 12 else "", float(p[-1])))
    elif line.startswith("MKL_VERBOSE") and current and "(" in line:
        m = re.match(r"MKL_VERBOSE (\w+)\((.*?)\) ([\d.]+)(us|ms|s)", line)
        if m:
            t = float(m.group(3)) * {"us": 1e-3, "ms": 1, "s": 1e3}[m.group(4)]
            mkl[current].append((m.group(1), m.group(2), t))

with open(os.path.join(out, "raw", "backend_per_layer.csv"), "w", newline="") as f:
    w = csv.writer(f)
    w.writerow(["layer", "operation", "source", "kind_or_function", "implementation_or_args", "problem", "ms"])
    for n, _ in leaves:
        for k, impl, desc, ms in prims.get(n, []):
            w.writerow([n, kind[n], "onednn", k, impl, desc, ms])
        for fn, a, ms in mkl.get(n, []):
            w.writerow([n, kind[n], "mkl", fn, a, "", ms])

# ------------------------------------------------------------- summary
L = ["# Backend path per operator type", "",
     "Generated by `experiments/backend_probe.py`. Evidence: torch.profiler ATen chain, "
     "ONEDNN_VERBOSE and MKL_VERBOSE logs of one inference (single thread).", ""]
if mkl_header:
    L += ["MKL runtime: `" + mkl_header.replace("MKL_VERBOSE ", "") + "`", ""]
L += ["## ATen dispatch chains (unique per operator type)", "",
      "| operation | ATen chain (depth-first) | layers |", "|---|---|---|"]
for (k, sig), layers in signatures.items():
    L.append(f"| {k} | `{sig}` | {len(layers)}: {', '.join(layers[:4])}{' ...' if len(layers) > 4 else ''} |")
L += ["", "## Library calls per operator type (one inference)", "",
      "| operation | library | primitive / function | implementation | calls | total ms |", "|---|---|---|---|---|---|"]
agg = collections.OrderedDict()
for n, _ in leaves:
    for k, impl, desc, ms in prims.get(n, []):
        key = (kind[n], "oneDNN", k, impl)
        a = agg.setdefault(key, [0, 0.0])
        a[0] += 1
        a[1] += ms
    for fn, a_, ms in mkl.get(n, []):
        key = (kind[n], "MKL", fn, "")
        a = agg.setdefault(key, [0, 0.0])
        a[0] += 1
        a[1] += ms
for (k, lib, fn, impl), (c, ms) in agg.items():
    L.append(f"| {k} | {lib} | {fn} | {impl} | {c} | {ms:.2f} |")
none = [k for k in sorted(set(kind.values())) if not any(kk[0] == k for kk in agg)]
L += ["", f"Operator types with **no** oneDNN/MKL calls (pure ATen native kernels): {', '.join(none)}", ""]
open(os.path.join(out, "processed", "BACKEND.md"), "w").write("\n".join(L) + "\n")
print("\n".join(L))
