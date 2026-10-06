#!/usr/bin/env python3
"""Analyse scripts/run_vtune.sh output (VTune CSV reports in <dir>/processed).

* Per operator (ITT tasks; one core and 28 single-thread copies): the full
  top-down (TMA) hierarchy from uarch-exploration, and LLC misses and average
  load latency from memory-access. Tasks are inclusive (aten::conv2d contains
  aten::convolution ...), so only leaf tasks are compared.
* 28 threads: ITT tasks exist only on the main thread, so the cycles of all
  28 threads are grouped by function into categories (OpenMP runtime, oneDNN
  conv JIT, oneDNN re-layout JIT, MKL GEMM, ATen kernels, Python, other),
  with Clockticks-weighted TMA metrics per category.
* Cross-check: VTune's one-core TMA level 1 per operator type against the
  non-multiplexed perf measurement (results/2026-10-06_resnet_baseline/
  processed/topdown_by_operation.csv).

VTune's driverless collection multiplexes the TMA events in one run, so
deep-level metrics are estimates; the cross-check shows how far level 1 moves.

usage: analyze_vtune.py results/2026-10-06_vtune
"""
import sys
from pathlib import Path

import numpy as np
import pandas as pd

TMA = "Top-down Microarchitecture Analysis (TMA):"
BE, MEM = "Back-End Bound:", "Back-End Bound:Memory Bound:"
METRICS = {   # short name -> column (after the TMA prefix); VTune's own units (% of slots or clockticks)
    "Retiring": "Retiring(%)",
    "Front-End": "Front-End Bound(%)",
    "Bad Spec": "Bad Speculation(%)",
    "Back-End": "Back-End Bound(%)",
    "Memory Bound": BE + "Memory Bound(%)",
    "L1 Bound": MEM + "L1 Bound(%)",
    "  FB Full": MEM + "L1 Bound:FB Full(%)",
    "L2 Bound": MEM + "L2 Bound(%)",
    "L3 Bound": MEM + "L3 Bound(%)",
    "  L3 Data Sharing": MEM + "L3 Bound:Data Sharing(%)",
    "  L3 Contested": MEM + "L3 Bound:Contested Accesses(%)",
    "  SQ Full": MEM + "L3 Bound:SQ Full(%)",
    "DRAM Bound": MEM + "DRAM Bound(%)",
    "  DRAM Bandwidth": MEM + "DRAM Bound:Memory Bandwidth(%)",
    "  DRAM Latency": MEM + "DRAM Bound:Memory Latency(%)",
    "Store Bound": MEM + "Store Bound(%)",
    "Core Bound": BE + "Core Bound(%)",
    "  Port Utilization": BE + "Core Bound:Port Utilization(%)",
    "  Serializing": BE + "Core Bound:Serializing Operations(%)",
    "  Slow Pause": BE + "Core Bound:Serializing Operations:Slow Pause(%)",
    "Vector Capacity (FPU)": BE + "Core Bound:Port Utilization:Vector Capacity Usage (FPU)(%)",
    "FP 512-bit": "Retiring:Light Operations:FP Arithmetic:FP Vector:512-bit FP Vector(%)",
    "FP 256-bit": "Retiring:Light Operations:FP Arithmetic:FP Vector:256-bit FP Vector(%)",
    "FP scalar": "Retiring:Light Operations:FP Arithmetic:FP Scalar(%)",
}
LEAF_OPS = [("inference", "whole inference"),
            ("aten::_slow_conv2d_forward", "conv, MKL GEMM path (33 1x1)"),
            ("convolution", "conv, oneDNN kernel (20)"),
            ("reorder", "oneDNN re-layout"),
            ("aten::max_pool2d_with_indices", "max-pool"),
            ("aten::native_batch_norm", "batchnorm (53)"),
            ("aten::add_", "residual add (16)"),
            ("aten::clamp_min_", "ReLU (49)"),
            ("aten::addmm", "fc")]


def read(path):
    p = Path(path)
    if not p.exists() or p.stat().st_size == 0:
        return None
    d = pd.read_csv(p, on_bad_lines="skip")
    d.columns = [str(c).replace(TMA, "").replace("\n", "").strip() for c in d.columns]
    return d


def wavg(d, cols, w):
    """Weighted average of each column over rows (weights w), ignoring NaN."""
    out = {}
    for c in cols:
        if c not in d:
            out[c] = np.nan
            continue
        v = pd.to_numeric(d[c], errors="coerce")
        m = v.notna() & (w > 0)
        out[c] = float((v[m] * w[m]).sum() / w[m].sum()) if m.any() else np.nan
    return out


def per_op_tma(task):
    rows = []
    for key, label in LEAF_OPS:
        d = task[task["Task Type"] == key]
        if d.empty:
            continue
        w = pd.to_numeric(d["Clockticks"], errors="coerce").fillna(0)
        r = {"operator": label, "CPU s": pd.to_numeric(d["CPU Time"], errors="coerce").sum(),
             "task count": pd.to_numeric(d.get("Task Count"), errors="coerce").sum()}
        r.update({k: v for k, v in zip(METRICS, wavg(d, list(METRICS.values()), w).values())})
        rows.append(r)
    return pd.DataFrame(rows)


def per_op_memory(task, inferences):
    rows = []
    for key, label in LEAF_OPS:
        d = task[task["Task Type"] == key]
        if d.empty:
            continue
        cpu = pd.to_numeric(d["CPU Time"], errors="coerce").fillna(0)
        miss = pd.to_numeric(d.get("LLC Miss Count"), errors="coerce").fillna(0).sum()
        r = {"operator": label, "CPU s": cpu.sum(),
             "LLC misses per inference (K)": miss / inferences / 1e3}
        r.update(wavg(d, ["Memory Bound(%)", "Memory Bound:L1 Bound(%)", "Memory Bound:L2 Bound(%)",
                          "Memory Bound:L3 Bound(%)", "Memory Bound:DRAM Bound(%)",
                          "Memory Bound:Store Bound(%)", "Average Latency (cycles)"], cpu))
        rows.append(r)
    d = pd.DataFrame(rows)
    d.columns = [c.replace("Memory Bound:", "").replace("(%)", " %") for c in d.columns]
    return d


def category(fn, mod):
    f, m = str(fn), str(mod).lower()
    if "ittnotify" in m:
        return "VTune ITT collector (instrumentation overhead)"
    if "gomp" in m or "iomp" in m or f.startswith(("gomp_", "GOMP_", "__kmp")):
        return "OpenMP runtime (spin/barrier)"
    if f.startswith("jit_") and "reorder" in f:
        return "oneDNN re-layout (JIT)"
    if f.startswith("jit_") or m == "[dynamic code]":
        return "oneDNN conv (JIT)"
    if "[MKL" in f or "mkl" in m:
        return "MKL GEMM"
    if "max_pool" in f:
        return "max-pool (ATen)"
    if "batch_norm" in f:
        return "batchnorm (ATen)"
    if "libtorch" in m or "libc10" in m:
        return "other PyTorch (ATen elementwise, dispatch, copies)"
    if "python" in m:
        return "Python interpreter"
    if "libc" in m:
        return "libc / allocator"
    return "other"


def per_category(fn):
    fn = fn.copy()
    fn["cat"] = [category(f, m) for f, m in zip(fn["Function"], fn.get("Module", ""))]
    w = pd.to_numeric(fn["Clockticks"], errors="coerce").fillna(0)
    fn["_w"] = w
    rows = []
    for cat, d in fn.groupby("cat"):
        r = {"category": cat, "share of clockticks %": d["_w"].sum() / w.sum() * 100}
        r.update({k: v for k, v in zip(METRICS, wavg(d, list(METRICS.values()), d["_w"]).values())})
        rows.append(r)
    return pd.DataFrame(rows).sort_values("share of clockticks %", ascending=False)


def summary_value(path, name):
    d = read(path)
    if d is None:
        return np.nan
    for _, r in d.iterrows():
        if str(r.iloc[1]).strip() == name:
            return pd.to_numeric(r.iloc[2], errors="coerce")
    return np.nan


def bandwidth(path):
    """(average, observed max) DRAM GB/s from a memory-access summary CSV
    (row: 0,"DRAM, GB/sec",<platform max>,<observed max>,<average>,<% high>)."""
    p = Path(path)
    if not p.exists():
        return np.nan, np.nan
    for line in p.read_text().splitlines():
        if line.startswith('0,"DRAM, GB/sec"'):
            f = line.split(",")
            return float(f[5]), float(f[4])
    return np.nan, np.nan


def md(df, digits=1):
    return df.round(digits).to_markdown(index=False)


def main(out_dir):
    out = Path(out_dir)
    proc = out / "processed"
    lines = ["# VTune results (`scripts/run_vtune.sh`)", "",
             "Driverless collection (perf-based): TMA events are multiplexed in one run, so deep-level "
             "metrics are estimates. Percentages are VTune's own (level-1 = % of pipeline slots; "
             "memory sub-levels = % of clockticks). Per-operator rows are ITT tasks "
             "(`experiments/vtune_run.py`), CPU-time-weighted when a task appears more than once.", ""]
    iters = {"1t": 300, "28cp": 28 * 250}

    for cfg, title in (("1t", "one core"), ("28cp", "28 single-thread copies")):
        t = read(proc / f"uarch_{cfg}_by_task.csv")
        if t is not None:
            d = per_op_tma(t)
            d.to_csv(proc / f"tma_by_operator_{cfg}.csv", index=False)
            lines += [f"## Top-down per operator, {title}", "", md(d), ""]
        m = read(proc / f"memory_{cfg}_by_task.csv")
        if m is not None:
            d = per_op_memory(m, iters[cfg])
            d.to_csv(proc / f"memory_by_operator_{cfg}.csv", index=False)
            lines += [f"## Memory per operator, {title}", "", md(d), ""]

    f = read(proc / "uarch_28t_by_function.csv")
    if f is not None and "Function" in f:
        d = per_category(f)
        d.to_csv(proc / "tma_by_category_28t.csv", index=False)
        lines += ["## 28 threads: cycles by function category (all threads)", "", md(d), ""]
    f1 = read(proc / "uarch_1t_by_function.csv")
    if f1 is not None and "Function" in f1:
        d = per_category(f1)
        d.to_csv(proc / "tma_by_category_1t.csv", index=False)
        lines += ["## One core: cycles by function category (same grouping, for comparison)", "", md(d), ""]

    bw = []
    for cfg, label in (("1t", "one core"), ("28t", "28 threads"), ("28cp", "28 copies")):
        avg, mx = bandwidth(proc / f"memory_{cfg}_summary.csv")
        bw.append({"configuration": label, "DRAM GB/s average": avg, "DRAM GB/s observed max": mx,
                   "average load latency (cycles)": summary_value(proc / f"memory_{cfg}_summary.csv",
                                                                   "Average Latency (cycles)"),
                   "Memory Bound %": summary_value(proc / f"memory_{cfg}_summary.csv", "Memory Bound"),
                   "DRAM Bound %": summary_value(proc / f"memory_{cfg}_summary.csv", "DRAM Bound")})
    bw = pd.DataFrame(bw)
    bw.to_csv(proc / "memory_summary.csv", index=False)
    lines += ["## Memory summary per configuration (whole run, incl. model build)", "", md(bw), ""]

    perf = Path("results/2026-10-06_resnet_baseline/processed/topdown_by_operation.csv")
    t = read(proc / "uarch_1t_by_task.csv")
    if perf.exists() and t is not None:
        p = pd.read_csv(perf).set_index("op_group")
        v = per_op_tma(t).set_index("operator")
        pairs = [("conv1x1", "conv, MKL GEMM path (33 1x1)"), ("conv3x3", "conv, oneDNN kernel (20)"),
                 ("maxpool", "max-pool"), ("batchnorm", "batchnorm (53)"), ("add", "residual add (16)"),
                 ("relu", "ReLU (49)")]
        rows = []
        for po, vo in pairs:
            if po in p.index and vo in v.index:
                rows.append({"operator (perf group / VTune task)": f"{po} / {vo}",
                             "Retiring perf": p.loc[po, "tma_retiring"] * 100, "Retiring VTune": v.loc[vo, "Retiring"],
                             "Bad Spec perf": p.loc[po, "tma_bad_spec"] * 100, "Bad Spec VTune": v.loc[vo, "Bad Spec"],
                             "Front-End perf": p.loc[po, "tma_frontend_bound"] * 100,
                             "Front-End VTune": v.loc[vo, "Front-End"],
                             "Memory perf": p.loc[po, "tma_memory_bound"] * 100, "Memory VTune": v.loc[vo, "Memory Bound"],
                             "Core perf": p.loc[po, "tma_core_bound"] * 100, "Core VTune": v.loc[vo, "Core Bound"]})
        if rows:
            c = pd.DataFrame(rows)
            c.to_csv(proc / "crosscheck_tma_level1.csv", index=False)
            lines += ["## Cross-check: TMA level 1, VTune (multiplexed) vs perf (exact, `tdgp` pass)", "",
                      "conv3x3 in perf = all 16 3x3 convs; VTune's oneDNN task also holds conv1/7x7 and the 3 "
                      "strided 1x1 convs.", "", md(c), ""]
    (proc / "VTUNE.md").write_text("\n".join(lines))
    print("\n".join(lines))


if __name__ == "__main__":
    main(sys.argv[1])
