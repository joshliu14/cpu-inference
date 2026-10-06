#!/usr/bin/env python3
"""perf annotate the N hottest symbols of a perf.data file.

usage: annotate_top.py <perf.data> <out_prefix> [N]
writes <out_prefix>_symbols.txt and <out_prefix>_<k>.annotate.txt (Intel syntax)
"""
import re
import subprocess
import sys

data, prefix = sys.argv[1], sys.argv[2]
n = int(sys.argv[3]) if len(sys.argv) > 3 else 3
rep = subprocess.run(["perf", "report", "-i", data, "--stdio", "--no-children", "--sort", "dso,sym", "-q",
                      "--percent-limit", "0.5", "-g", "none"], capture_output=True, text=True).stdout
open(f"{prefix}_symbols.txt", "w").write(rep)
syms = []
for line in rep.splitlines():
    m = re.match(r"^\s*([\d.]+)%\s+(\S+)\s+\[[.k]\]\s+(.+?)\s*$", line)
    if m:
        syms.append((float(m.group(1)), m.group(2), m.group(3)))
for k, (pct, dso, sym) in enumerate(syms[:n]):
    out = subprocess.run(["perf", "annotate", "-i", data, "--stdio", "-M", "intel", "--no-source",
                          "--percent-type", "local-period", "--dsos", dso, sym],
                         capture_output=True, text=True).stdout
    with open(f"{prefix}_{k}.annotate.txt", "w") as f:
        f.write(f"# symbol: {sym}\n# dso: {dso}\n# share of operator samples: {pct}%\n")
        f.write(out)
    print(f"annotated {sym[:80]} ({pct}%) -> {prefix}_{k}.annotate.txt ({len(out.splitlines())} lines)")
