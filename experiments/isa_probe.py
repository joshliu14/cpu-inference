#!/usr/bin/env python3
"""Which SIMD width do ATen's native kernels actually use, and why?

Part 1 (counters): run ReLU, add, BatchNorm, NCHW max-pool and avgpool once
on ResNet-sized tensors and count retired FP arithmetic instructions by width
(scalar / 256-bit / 512-bit). Repeated by the caller under
ATEN_CPU_CAPABILITY=default (unset), avx512 and avx2. Instruction widths do
not depend on machine load, so this probe needs no quiet machine.

Part 2 (symbols): list which ATen kernels exist in libtorch_cpu.so as an
AVX2 build, an AVX512 build, or both (namespaces at::native::AVX2:: /
AVX512:: / DEFAULT::). A kernel without an AVX512 build runs its AVX2 build
on an AVX-512 CPU.

usage: isa_probe.py --cpu 6 --out DIR [--symbols]
"""
import argparse
import collections
import json
import os
import re
import subprocess
import sys

sys.path.insert(0, os.path.join(os.path.dirname(__file__), ".."))
from cpuinf import runtime  # noqa: E402

ap = argparse.ArgumentParser()
ap.add_argument("--cpu", type=int, default=None)
ap.add_argument("--out", required=True)
ap.add_argument("--symbols", action="store_true")
args = ap.parse_args()
runtime.pin(args.cpu)
torch = runtime.configure_torch()
import torch.nn as nn  # noqa: E402
import torch.nn.functional as F  # noqa: E402

from cpuinf.perfcounters import CounterSession  # noqa: E402

os.makedirs(os.path.join(args.out, "raw"), exist_ok=True)
EV = ["instructions", "fp_arith_inst_retired.scalar_single", "fp_arith_inst_retired.256b_packed_single",
      "fp_arith_inst_retired.512b_packed_single"]
cs = CounterSession(EV)
a = torch.randn(1, 256, 56, 56)
b = torch.randn(1, 256, 56, 56)
bn = nn.BatchNorm2d(256).eval()
t = torch.randn(1, 64, 112, 112)
ops = {"relu_ (1x256x56x56)": lambda: a.clone().relu_(), "add_ (1x256x56x56)": lambda: a.clone().add_(b),
       "batchnorm (1x256x56x56)": lambda: bn(a), "maxpool NCHW (1x64x112x112)": lambda: F.max_pool2d(t, 3, 2, 1),
       "avgpool (1x256x56x56)": lambda: F.adaptive_avg_pool2d(a, 1),
       "exp (1x256x56x56)": lambda: torch.exp(a)}
cap = os.environ.get("ATEN_CPU_CAPABILITY") or "unset"
res = {"ATEN_CPU_CAPABILITY": cap, "cpu_capability": torch.backends.cpu.get_cpu_capability(), "ops": {}}
with torch.inference_mode():
    for k, fn in ops.items():
        fn()
        best = None
        for _ in range(5):                        # min over 5: excludes interrupts
            cs.start()
            fn()
            c = cs.stop()
            best = c if best is None or c["instructions"] < best["instructions"] else best
        res["ops"][k] = {"instructions": best["instructions"],
                         "fp_scalar": best[EV[1]], "fp_256b": best[EV[2]], "fp_512b": best[EV[3]]}
        print(f"[{cap:7s}] {k:30s} " + "  ".join(f"{n} {v}" for n, v in res["ops"][k].items()))
runtime.dump_json(os.path.join(args.out, "raw", f"isa_counters_{cap}.json"), res)

if args.symbols:
    lib = os.path.join(os.path.dirname(torch.__file__), "lib", "libtorch_cpu.so")
    nm = subprocess.run(["nm", "-C", lib], capture_output=True, text=True).stdout
    # The ISA namespace sits on the per-ISA loop templates (e.g.
    # at::native::AVX2::VectorizedLoop2d<... add_kernel ...>), so count symbol
    # lines that mention both the kernel name and each ISA namespace.
    lines = nm.splitlines()
    names = ["add_kernel", "clamp_min_scalar", "mul_kernel", "batch_norm_cpu", "cpu_max_pool<float",
             "vectorized_inner_sum", "exp_kernel", "copy_kernel", "tanh_kernel"]
    per = {}
    for n in names:
        hit = [l for l in lines if n in l]
        per[n] = {ns: sum(1 for l in hit if f"{ns}::" in l) for ns in ("DEFAULT", "AVX2", "AVX512")}
        per[n]["total_symbols"] = len(hit)
    k = collections.defaultdict(set)
    for m in re.finditer(r"at::native::(AVX2|AVX512|DEFAULT)::(?:\(anonymous namespace\)::)?(\w*kernel\w*)", nm):
        k[m.group(2)].add(m.group(1))
    sym = {"library": lib, "resnet_kernels_symbol_lines_by_isa": per,
           "dispatch_kernels_with_avx512_build": sorted(n for n, s in k.items() if "AVX512" in s),
           "dispatch_kernels_avx2_but_no_avx512_build": sorted(n for n, s in k.items()
                                                               if "AVX2" in s and "AVX512" not in s),
           "symbols_in_namespace": {ns: len(re.findall(rf"at::native::{ns}::", nm))
                                    for ns in ("DEFAULT", "AVX2", "AVX512")}}
    for n, v in per.items():
        print(f"{n:22s} " + "  ".join(f"{a}={b}" for a, b in v.items()))
    runtime.dump_json(os.path.join(args.out, "raw", "isa_symbols.json"), sym)
    print(f"dispatch kernels with an AVX512 build: {len(sym['dispatch_kernels_with_avx512_build'])}; "
          f"AVX2-only: {len(sym['dispatch_kernels_avx2_but_no_avx512_build'])}")
