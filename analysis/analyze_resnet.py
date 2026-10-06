#!/usr/bin/env python3
"""Analyse a results/<date>_resnet_baseline directory.

Inputs (from experiments/op_profile.py and e2e_latency.py):
  processed/manifest.csv            calculated shapes / FLOPs / bytes per layer
  raw/inmodel_<pass>.csv            per-iteration per-layer counts inside the model
  raw/standalone_{hot,cold}_<pass>.csv
  processed/op_profile_meta.json    floors (empty start/stop cost), DRAM background
  processed/e2e_summary_*.json      whole-inference latency
  ../<date>_microbench/processed/machine_model.json   empirical roofs

Outputs:
  processed/layer_table.csv         one row per layer: manifest + all metrics
  processed/by_operation.csv, by_stage.csv, by_block.csv
  processed/REPORT.md               tables + classification
  plots/*.png                       one question per plot

Conventions: counter values are medians over iterations after subtracting
the pass's measured floor (clipped at 0). FLOPs/cycle uses CALCULATED
(manifest) FLOPs over MEASURED cycles; 'flops_measured' comes from
FP_ARITH_INST_RETIRED and is reported separately.
"""
import json
import sys
from pathlib import Path

import numpy as np
import pandas as pd

sys.path.insert(0, str(Path(__file__).resolve().parent))
sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import plotstyle as ps  # noqa: E402
from matplotlib import pyplot as plt  # noqa: E402
from matplotlib.ticker import FuncFormatter  # noqa: E402

from cpuinf.metrics import derive  # noqa: E402

GHZ = 2.1
OP_ORDER = ["conv1x1", "conv3x3", "conv7x7", "batchnorm", "relu", "add", "maxpool", "other"]
OP_COLOR = dict(zip(OP_ORDER, ps.CAT))


def op_group(op):
    return op if op in OP_ORDER[:-1] else "other"


def find_machine_model(out: Path):
    cands = sorted(out.parent.glob("*_microbench*/processed/machine_model.json"))
    if not cands:
        return None
    return json.loads(cands[-1].read_text())


def load_pass(raw: Path, meta: dict, name: str, per_call: bool):
    f = raw / f"{name}.csv"
    if not f.exists():
        return None
    df = pd.read_csv(f)
    info = meta["passes"].get(name, {})
    ev = info.get("events", {})
    floor = info.get("floor", {})
    for key, perf_name in ev.items():
        if key in df and perf_name in floor:
            df[key] = (df[key] - floor[perf_name]).clip(lower=0)
    if per_call and "calls" in df:
        num = [c for c in df.columns if c not in ("rep", "layer", "calls", "multiplexed")]
        df[num] = df[num].div(df["calls"], axis=0)
    return df


def per_layer(df, cols):
    g = df.groupby("layer")[cols]
    return g.median()


def merged_pass(raw, meta, mode, p, per_call):
    subs = [k for k in meta["passes"] if k == f"{mode}_{p}" or k.startswith(f"{mode}_{p}.")]
    merged = None
    for name in sorted(subs):
        df = load_pass(raw, meta, name, per_call)
        if df is None:
            continue
        med = per_layer(df, list(meta["passes"][name]["events"].keys()))
        merged = med if merged is None else merged.join(med[[c for c in med if c not in merged]])
    return merged


def build_tables(out: Path):
    raw, proc = out / "raw", out / "processed"
    meta = json.loads((proc / "op_profile_meta.json").read_text())
    man = pd.read_csv(proc / "manifest.csv")
    man["op_group"] = man["operation"].map(op_group)
    t = man.set_index("layer_name")

    # ---- in-model time
    tp = load_pass(raw, meta, "inmodel_time", False)
    stats = tp.groupby("layer")["ns"].agg(time_ns="median", time_ns_p5=lambda s: s.quantile(0.05),
                                          time_ns_p95=lambda s: s.quantile(0.95), time_ns_std="std")
    t = t.join(stats)
    t["time_ms"] = t["time_ns"] / 1e6

    # ---- in-model counter passes (a logical pass may be split into verified
    # sub-passes p.0, p.1, ... that ran separately; their per-layer medians are
    # merged, keeping the first sub-pass's cycles)
    for p in ("core", "sw", "tdgp", "flops", "loads", "traffic", "stalls", "ports", "frontend"):
        med = merged_pass(raw, meta, "inmodel", p, False)
        if med is None:
            continue
        derived = pd.DataFrame([derive(r.to_dict()) for _, r in med.iterrows()], index=med.index)
        derived = derived.dropna(axis=1, how="all")
        if p != "core":
            med = med.rename(columns={k: f"{k}__{p}" for k in med.columns if k in t.columns or k == "cycles"})
            derived = derived.drop(columns=[c for c in ("ipc", "cpi") if c in derived], errors="ignore")
        t = t.join(med).join(derived.drop(columns=[c for c in derived if c in t.columns], errors="ignore"))

    # ---- DRAM (socket-wide; subtract idle background rate x op duration)
    dp = load_pass(raw, meta, "inmodel_dram", False)
    if dp is not None:
        bg = meta["passes"]["inmodel_dram"]["dram_background"]
        dp["dram_read_net"] = (dp["dram_read_bytes"] - bg["read_Bps"] * dp["ns"] / 1e9).clip(lower=0)
        dp["dram_write_net"] = (dp["dram_write_bytes"] - bg["write_Bps"] * dp["ns"] / 1e9).clip(lower=0)
        t = t.join(per_layer(dp, ["dram_read_bytes", "dram_write_bytes", "dram_read_net", "dram_write_net"]))

    # ---- standalone
    for mode in ("standalone_hot", "standalone_cold"):
        df = load_pass(raw, meta, f"{mode}_time", True)
        if df is not None:
            t[f"{mode}_ms"] = per_layer(df, ["ns"])["ns"] / 1e6
        for p in ("core", "tdgp", "flops", "loads", "traffic", "stalls"):
            med = merged_pass(raw, meta, mode, p, True)
            if med is None:
                continue
            if p == "core":
                t[f"{mode}_cycles"] = med["cycles"]
                t[f"{mode}_ipc"] = med["instructions"] / med["cycles"]
            if p == "tdgp":
                d = pd.DataFrame([derive(r.to_dict()) for _, r in med.iterrows()], index=med.index)
                for c in ("tma_retiring", "tma_backend_bound", "tma_memory_bound", "tma_core_bound",
                          "tma_frontend_bound", "tma_bad_spec"):
                    t[f"{mode}_{c}"] = d[c]
            if p == "traffic":
                t[f"{mode}_bytes_into_l2"] = med["l2_lines_in"] * 64
                t[f"{mode}_ocr_reads_dram_bytes"] = med["ocr_reads_dram"] * 64

    # ---- derived per-layer quantities
    t["flops_per_cycle"] = t["flops"] / t["cycles"]
    t["gflops"] = t["flops"] / t["time_ns"]
    t["cycles_from_time"] = t["time_ns"] * GHZ
    t["min_traffic_bytes_per_cycle"] = t["min_traffic_bytes"] / t["cycles"]
    if "bytes_into_l2" in t:
        t["l2_fill_bytes_per_cycle"] = t["bytes_into_l2"] / t["cycles"]
        t["ai_l2_fill"] = t["flops"] / t["bytes_into_l2"].replace(0, np.nan)
    if "dram_read_net" in t:
        t["dram_bytes_net"] = t["dram_read_net"] + t["dram_write_net"]
        t["dram_bytes_per_cycle"] = t["dram_bytes_net"] / t["cycles"]
        t["ai_dram"] = t["flops"] / t["dram_bytes_net"].replace(0, np.nan)
    if "flops_measured" in t:
        t["flops_measured_over_calculated"] = t["flops_measured"] / t["flops"].replace(0, np.nan)
    if "cache_misses" in t:
        t["llc_misses_per_kflop"] = t["cache_misses"] / (t["flops"] / 1e3).replace(0, np.nan)
    t["pct_of_total_time"] = 100 * t["time_ns"] / t["time_ns"].sum()
    t = t.reset_index().rename(columns={"index": "layer_name"}).sort_values("exec_index")
    return t, meta


def classify(t: pd.DataFrame, mm: dict):
    """Empirical roofline classification (an approximation, documented in REPORT)."""
    peak = mm["compute"]["peak_fp32_flops_per_cycle"]["fp32_avx512_fma"]
    bw = {lvl: mm["bandwidth"]["read_4k"][lvl]["bytes_per_cycle"] for lvl in ("L1", "L2", "L3", "DRAM")}
    out = []
    for r in t.itertuples():
        if not r.flops or r.operation == "flatten":
            out.append(("n/a", np.nan, np.nan, ""))
            continue
        comp_util = r.flops_per_cycle / peak
        # Where can the working set live? (input + weights + output vs L2 capacity)
        lvl = "L2" if r.working_set_bytes <= 2 * 2**20 else "L3"
        bw_util = r.min_traffic_bytes_per_cycle / bw[lvl]
        if comp_util >= 0.5:
            c = "compute-bound"
        elif bw_util >= 0.5:
            c = f"bandwidth-bound ({lvl})"
        else:
            c = "below both roofs (latency/overhead)"
        out.append((c, comp_util, bw_util, lvl))
    t["bound_class"], t["compute_util"], t["bw_util"], t["assumed_level"] = zip(*out)
    t["peak_flops_per_cycle"] = peak
    return t


# ------------------------------------------------------------------- plots
def bar_by_layer(t, col, ylabel, title, sub, fname, plots, logy=False, refs=None):
    fig, ax = plt.subplots(figsize=(11, 4.2))
    x = t["exec_index"].values
    colors = [OP_COLOR[g] for g in t["op_group"]]
    ax.bar(x, t[col].values, color=colors, width=0.85, linewidth=0)
    if logy:
        ax.set_yscale("log")
    for label, y in (refs or {}).items():
        ax.axhline(y, color=ps.NEUTRAL, linestyle="--", linewidth=0.9)
        ax.text(x.max(), y, f" {label}", fontsize=8, color=ps.TEXT2, va="bottom", ha="right")
    # stage separators
    for stage, d in t.groupby("stage", sort=False):
        ax.axvline(d.exec_index.min() - 0.5, color=ps.GRID, linewidth=1)
        ax.text(d.exec_index.mean(), 0.97, stage, transform=ax.get_xaxis_transform(), fontsize=8,
                color=ps.TEXT2, ha="center", va="top")
    ax.set_xlim(-1, x.max() + 1)
    if not logy and col == "time_ms":
        top = t.sort_values(col, ascending=False).iloc[0]
        ax.annotate(f"{top.layer_name}: {top[col]:.1f} ms", (top.exec_index, top[col]), xytext=(10, -10),
                    textcoords="offset points", fontsize=8, color=ps.TEXT2, va="top")
    ax.set_xlabel("operator, in execution order")
    ax.set_ylabel(ylabel)
    ps.titled(ax, title, sub)
    present = [g for g in OP_ORDER if g in set(t["op_group"])]
    handles = [plt.Rectangle((0, 0), 1, 1, color=OP_COLOR[g]) for g in present]
    ax.legend(handles, present, ncol=len(present), loc="upper center", bbox_to_anchor=(0.5, -0.15))
    fig.savefig(plots / fname)
    plt.close(fig)


def make_plots(t, meta, mm, plots: Path, proc: Path):
    total_ms = t["time_ms"].sum()
    bar_by_layer(t, "time_ms", "milliseconds (median)",
                 "Where the time goes: per-operator latency inside ResNet-50",
                 f"In-model forward hooks, batch 1, one core; operators sum to {total_ms:.1f} ms",
                 "01_layer_runtime.png", plots)

    # 02: share of runtime by operation type (and by stage)
    by_op = t.groupby("op_group").agg(time_ms=("time_ms", "sum"), flops=("flops", "sum")).reindex(
        [g for g in OP_ORDER if g in set(t.op_group)])
    by_op["pct_time"] = 100 * by_op.time_ms / by_op.time_ms.sum()
    by_op["pct_flops"] = 100 * by_op.flops / by_op.flops.sum()
    fig, ax = plt.subplots(figsize=(8, 4.2))
    order = by_op.sort_values("pct_time").index
    y = np.arange(len(order))
    ax.barh(y + 0.2, by_op.loc[order, "pct_time"], height=0.38, color=ps.CAT[0], label="% of runtime")
    ax.barh(y - 0.2, by_op.loc[order, "pct_flops"], height=0.38, color=ps.CAT[1], label="% of FLOPs")
    for yi, g in zip(y, order):
        ax.text(by_op.loc[g, "pct_time"] + 0.5, yi + 0.2, f"{by_op.loc[g, 'pct_time']:.1f}%", va="center",
                fontsize=8, color=ps.TEXT2)
        ax.text(by_op.loc[g, "pct_flops"] + 0.5, yi - 0.2, f"{by_op.loc[g, 'pct_flops']:.1f}%", va="center",
                fontsize=8, color=ps.TEXT2)
    ax.set_yticks(y)
    ax.set_yticklabels(order)
    ax.set_xlabel("percent of total")
    ps.titled(ax, "Runtime share vs. arithmetic share by operator type",
              "An operator whose runtime share far exceeds its FLOP share is inefficient")
    ax.legend(loc="lower right")
    fig.savefig(plots / "02_runtime_share.png")
    plt.close(fig)

    bar_by_layer(t, "flops", "FLOPs (log)", "Arithmetic work per operator (calculated)",
                 "2 FLOPs per multiply-accumulate; elementwise ops ~1-2 per element", "03_layer_flops.png",
                 plots, logy=True)
    if "instructions" in t:
        bar_by_layer(t, "instructions", "retired instructions (log)", "Instructions executed per operator",
                     "In-model, floor-corrected, median of iterations", "04_layer_instructions.png", plots,
                     logy=True)
        bar_by_layer(t, "cycles", "core cycles (log)", "Core cycles per operator",
                     "In-model, floor-corrected; 2.1 GHz fixed frequency", "05_layer_cycles.png", plots, logy=True)
        bar_by_layer(t, "ipc", "instructions per cycle", "IPC per operator",
                     "Golden-Cove-class core can retire up to 6 uops/cycle (6 slots); 2 FMA/cycle",
                     "06_layer_ipc.png", plots)
        bar_by_layer(t, "cpi", "cycles per instruction (log)", "CPI per operator",
                     "CPI = 1/IPC; high CPI = each instruction waits longer", "07_layer_cpi.png", plots, logy=True)
    if "cache_misses" in t:
        fig, axes = plt.subplots(3, 1, figsize=(11, 7.5), sharex=True)
        specs = [("l1d_replacement", "L1D line fills"), ("l2_lines_in", "L2 line fills"),
                 ("cache_misses", "LLC misses")]
        for ax, (col, lab) in zip(axes, specs):
            if col not in t:
                continue
            ax.bar(t.exec_index, t[col].clip(lower=1), color=[OP_COLOR[g] for g in t.op_group], width=0.85)
            ax.set_yscale("log")
            ax.set_ylabel(lab + " (log)")
        axes[-1].set_xlabel("operator, in execution order")
        ps.titled(axes[0], "Cache misses per operator, by level",
                  "Fills include hardware prefetches; LLC misses = LONGEST_LAT_CACHE.MISS")
        present = [g for g in OP_ORDER if g in set(t["op_group"])]
        axes[-1].legend([plt.Rectangle((0, 0), 1, 1, color=OP_COLOR[g]) for g in present], present,
                        ncol=len(present), loc="upper center", bbox_to_anchor=(0.5, -0.3))
        fig.savefig(plots / "08_layer_cache_misses.png")
        plt.close(fig)
    bar_by_layer(t[t.flops > 0], "arithmetic_intensity", "FLOP per byte of compulsory traffic (log)",
                 "Arithmetic intensity per operator (calculated)",
                 "Compulsory traffic = input + weights + output, each moved once", "09_layer_arithmetic_intensity.png",
                 plots, logy=True,
                 refs={"DRAM ridge": mm["compute"]["peak_fp32_flops_per_cycle"]["fp32_avx512_fma"]
                       / mm["bandwidth"]["read_4k"]["DRAM"]["bytes_per_cycle"]} if mm else None)

    # 10: memory bandwidth used per operator vs machine limits
    if mm and "l2_fill_bytes_per_cycle" in t:
        fig, ax = plt.subplots(figsize=(11, 4.2))
        series = [("min_traffic_bytes_per_cycle", "compulsory traffic / cycle"),
                  ("l2_fill_bytes_per_cycle", "measured L2 fills / cycle"),
                  ("dram_bytes_per_cycle", "measured DRAM traffic / cycle (socket, net)")]
        for i, (col, lab) in enumerate(series):
            if col in t:
                # zero / negative (after background subtraction) values are omitted, not clipped
                ax.plot(t.exec_index, t[col].where(t[col] > 0), marker="o", markersize=2.5, linewidth=1,
                        color=ps.CAT[i], label=lab)
        for lvl, va in (("L2", "bottom"), ("L3", "bottom"), ("DRAM", "top")):
            v = mm["bandwidth"]["read_4k"][lvl]["bytes_per_cycle"]
            ax.axhline(v, color=ps.NEUTRAL, linestyle="--", linewidth=0.9)
            ax.text(t.exec_index.max(), v, f" {lvl} read BW {v:.1f} B/cyc", fontsize=8, color=ps.TEXT2,
                    va=va, ha="right")
        ax.set_yscale("log")
        ax.set_xlabel("operator, in execution order")
        ax.set_ylabel("bytes per cycle (log)")
        ps.titled(ax, "Data movement rate per operator vs. what one core can sustain",
                  "Dashed: single-core read bandwidth measured by microbenchmarks")
        ax.legend(loc="upper center", bbox_to_anchor=(0.5, -0.15), ncol=3)
        fig.savefig(plots / "10_layer_bandwidth.png")
        plt.close(fig)

    # 11: roofline
    if mm:
        peak = mm["compute"]["peak_fp32_flops_per_cycle"]["fp32_avx512_fma"]
        fig, ax = plt.subplots(figsize=(8.5, 5.4))
        xs = np.logspace(-2, 3, 100)
        for i, lvl in enumerate(("L1", "L2", "L3", "DRAM")):
            bwv = mm["bandwidth"]["read_4k"][lvl]["bytes_per_cycle"]
            ax.plot(xs, np.minimum(peak, bwv * xs), color=ps.NEUTRAL, linewidth=1, linestyle="--")
            xi = peak / bwv
            ax.text(xi * 0.9, peak * 0.03 * (1.9 ** i) * bwv / bwv, "", fontsize=7)
            ax.text(0.012, bwv * 0.012 * 1.15, f"{lvl} {bwv:.0f} B/cyc", fontsize=7.5, color=ps.TEXT2,
                    rotation=0)
        ax.axhline(peak, color=ps.NEUTRAL, linewidth=1)
        ax.text(0.012, peak * 1.06, f"AVX-512 FMA peak {peak:.1f} FLOP/cycle", fontsize=8, color=ps.TEXT2)
        d = t[(t.flops > 0) & t.flops_per_cycle.notna()]
        for g in OP_ORDER:
            s = d[d.op_group == g]
            if len(s):
                ax.scatter(s.arithmetic_intensity, s.flops_per_cycle, s=28, color=OP_COLOR[g], label=g,
                           edgecolor=ps.SURFACE, linewidth=1, zorder=3)
        mp = d[d.operation == "maxpool"]
        for r in mp.itertuples():
            ax.annotate("maxpool", (r.arithmetic_intensity, r.flops_per_cycle), xytext=(8, -4),
                        textcoords="offset points", fontsize=8, color=ps.TEXT2)
        ax.set_xscale("log")
        ax.set_yscale("log")
        ax.set_xlim(0.01, 1000)
        ax.set_xlabel("arithmetic intensity (FLOP / compulsory byte)")
        ax.set_ylabel("achieved FLOP / cycle (log)")
        ps.titled(ax, "ResNet-50 operators on the measured roofline of one core",
                  "Roofs from microbenchmarks (read BW per level, FMA peak); points = in-model operators")
        ax.legend(loc="lower right", ncol=2)
        fig.savefig(plots / "11_roofline.png")
        plt.close(fig)

    # 15: top-down by operation type (time-weighted) -- stacked horizontal bars
    if "tma_retiring" in t:
        cols = ["tma_retiring", "tma_bad_spec", "tma_frontend_bound", "tma_core_bound", "tma_memory_bound"]
        labels = ["Retiring", "Bad speculation", "Frontend bound", "Backend: core bound", "Backend: memory bound"]
        S = "tdg_slots"
        w = t.assign(**{c: t[c] * t[S] for c in cols})
        agg = w.groupby("op_group")[cols + [S]].sum()
        frac = agg[cols].div(agg[S], axis=0).reindex([g for g in OP_ORDER if g in agg.index])
        total = w[cols].sum() / w[S].sum()
        frac.loc["ALL (time-weighted)"] = total
        frac.to_csv(proc / "topdown_by_operation.csv")
        fig, ax = plt.subplots(figsize=(9, 4.6))
        y = np.arange(len(frac))[::-1]
        left = np.zeros(len(frac))
        for i, (c, lab) in enumerate(zip(cols, labels)):
            ax.barh(y, frac[c].values, left=left, color=ps.CAT[i], label=lab, height=0.62,
                    edgecolor=ps.SURFACE, linewidth=1)
            for yi, l0, v in zip(y, left, frac[c].values):
                if v > 0.07:
                    ax.text(l0 + v / 2, yi, f"{100 * v:.0f}%", ha="center", va="center", fontsize=8,
                            color="white" if i in (0, 1) else ps.TEXT)
            left += frac[c].values
        ax.set_yticks(y)
        ax.set_yticklabels(frac.index)
        ax.set_xlim(0, 1)
        ax.xaxis.set_major_formatter(FuncFormatter(lambda v, _: f"{100 * v:.0f}%"))
        ax.set_xlabel("share of pipeline slots")
        ps.titled(ax, "Top-down: what limits the pipeline, by operator type",
                  "General-purpose TMA events (topdown.*_slots, uops_retired.slots, idq_bubbles.core); "
                  "slot-weighted")
        ax.legend(ncol=3, loc="upper center", bbox_to_anchor=(0.5, -0.15))
        fig.savefig(plots / "15_topdown_by_operation.png")
        plt.close(fig)

    # 16: in-model vs standalone
    if "standalone_hot_ms" in t:
        fig, ax = plt.subplots(figsize=(7, 5.4))
        for i, (col, lab) in enumerate((("standalone_hot_ms", "standalone, hot caches"),
                                        ("standalone_cold_ms", "standalone, cold caches"))):
            if col in t:
                ax.scatter(t.time_ms, t[col], s=18, color=ps.CAT[i], label=lab, zorder=3,
                           edgecolor=ps.SURFACE, linewidth=0.8)
        lim = [t.time_ms.min() * 0.7, max(t.time_ms.max(), t.get("standalone_cold_ms", t.time_ms).max()) * 1.3]
        ax.plot(lim, lim, color=ps.NEUTRAL, linestyle="--", linewidth=1)
        ax.set_xscale("log")
        ax.set_yscale("log")
        ax.set_xlabel("in-model time (ms, log)")
        ax.set_ylabel("standalone time (ms, log)")
        ps.titled(ax, "Same operator, different context",
                  "Above the diagonal: slower when caches are cold; below: faster in isolation")
        ax.legend(loc="upper left")
        fig.savefig(plots / "16_inmodel_vs_standalone.png")
        plt.close(fig)


def report(t, meta, mm, out: Path):
    proc = out / "processed"
    e2e = {}
    for f in sorted(proc.glob("e2e_summary_*.json")):
        d = json.loads(f.read_text())
        e2e[f.stem.replace("e2e_summary_", "")] = d
    L = []
    L.append("# ResNet-50 baseline report\n")
    L.append("Generated by `analysis/analyze_resnet.py`. OBSERVED = measured here; CALCULATED = derived "
             "from shapes or arithmetic on measurements; classifications are empirical approximations.\n")
    L.append("## Level 0: end-to-end latency (OBSERVED)\n")
    L.append("| run | median ms | mean | stddev | min | p5 | p95 | max | IPC | GHz |")
    L.append("|---|---|---|---|---|---|---|---|---|---|")
    for k, d in e2e.items():
        s = d["latency_ms"]
        L.append(f"| {k} | {s['median']:.2f} | {s['mean']:.2f} | {s['stddev']:.3f} | {s['min']:.2f} | "
                 f"{s['p5']:.2f} | {s['p95']:.2f} | {s['max']:.2f} | {d.get('ipc_median', float('nan')):.2f} | "
                 f"{d.get('freq_ghz_median', float('nan')):.3f} |")
    L.append("")
    tot_ops = t["time_ms"].sum()
    fwd = np.median(meta["passes"]["inmodel_time"]["forward_total_ns"]) / 1e6
    L.append(f"Sum of per-operator times (time pass): **{tot_ops:.2f} ms**; forward() with hooks: "
             f"{fwd:.2f} ms; unattributed (Python glue between modules + hook cost): "
             f"{fwd - tot_ops:.2f} ms ({100 * (fwd - tot_ops) / fwd:.1f}%).\n")
    if mm:
        peak = mm["compute"]["peak_fp32_flops_per_cycle"]["fp32_avx512_fma"]
        floor_ms = t["flops"].sum() / peak / GHZ / 1e6
        L.append(f"CALCULATED compute floor at the measured FMA peak ({peak:.1f} FLOP/cycle): "
                 f"**{floor_ms:.1f} ms** for {t['flops'].sum() / 1e9:.2f} GFLOP.\n")

    L.append("## Level 1: time by operator type\n")
    g = t.groupby("op_group").agg(count=("layer_name", "size"), time_ms=("time_ms", "sum"),
                                  gflop=("flops", lambda s: s.sum() / 1e9),
                                  cycles=("cycles", "sum"), instructions=("instructions", "sum"))
    g["pct_time"] = 100 * g.time_ms / g.time_ms.sum()
    g["flop_per_cycle"] = g.gflop * 1e9 / g.cycles
    g["ipc"] = g.instructions / g.cycles
    g = g.sort_values("time_ms", ascending=False)
    g.to_csv(proc / "by_operation.csv")
    L.append(g.round(3).to_markdown())
    L.append("")
    s = t.groupby("stage", sort=False).agg(time_ms=("time_ms", "sum"), gflop=("flops", lambda x: x.sum() / 1e9),
                                           cycles=("cycles", "sum"))
    s["pct_time"] = 100 * s.time_ms / s.time_ms.sum()
    s["flop_per_cycle"] = s.gflop * 1e9 / s.cycles
    s.to_csv(proc / "by_stage.csv")
    L.append("### By stage\n")
    L.append(s.round(3).to_markdown())
    L.append("")
    b = t.groupby("block", sort=False).agg(time_ms=("time_ms", "sum"), gflop=("flops", lambda x: x.sum() / 1e9),
                                           cycles=("cycles", "sum"))
    b["flop_per_cycle"] = b.gflop * 1e9 / b.cycles
    b.to_csv(proc / "by_block.csv")

    L.append("## Top 20 operators by time\n")
    cols = ["layer_name", "operation", "input_shape", "output_shape", "time_ms", "pct_of_total_time", "ipc",
            "flops_per_cycle", "arithmetic_intensity", "tma_retiring", "tma_memory_bound", "tma_core_bound",
            "bound_class"]
    cols = [c for c in cols if c in t]
    L.append(t.sort_values("time_ms", ascending=False)[cols].head(20).round(3).to_markdown(index=False))
    L.append("")
    L.append("## Sorted views\n")
    for key, label in (("cycles", "cycles"), ("flops", "FLOPs"), ("instructions", "instructions"),
                       ("cache_misses", "LLC misses"), ("arithmetic_intensity", "arithmetic intensity (lowest)"),
                       ("min_traffic_bytes", "compulsory traffic"), ("ipc", "IPC (lowest)")):
        if key not in t:
            continue
        asc = "lowest" in label
        top = t[t.flops > 0].sort_values(key, ascending=asc).head(8)
        L.append(f"**Top 8 by {label}:** " + ", ".join(f"{r.layer_name} ({getattr(r, key):.3g})"
                                                       for r in top.itertuples()) + "\n")
    L.append("## Roofline classification (empirical approximation)\n")
    L.append("Rule: compute-bound if achieved FLOP/cycle >= 50% of the measured FMA peak; else bandwidth-bound "
             "if compulsory bytes/cycle >= 50% of the single-core read bandwidth of the level the working set "
             "fits in (L2 if <= 2 MiB, else L3); otherwise 'below both roofs', meaning neither arithmetic nor "
             "bandwidth explains the time (latency, overhead, poor vectorization).\n")
    c = t.groupby("bound_class").agg(n=("layer_name", "size"), time_ms=("time_ms", "sum"))
    c["pct_time"] = 100 * c.time_ms / c.time_ms.sum()
    L.append(c.round(2).to_markdown())
    L.append("")
    flags = [k for k, v in meta["passes"].items() if v.get("any_multiplexing")]
    L.append("## Measurement notes\n")
    L.append(f"- Passes with counter multiplexing: {flags or 'none'}.")
    L.append(f"- Floors subtracted (cycles of an empty start/stop): " + ", ".join(
        f"{k}={v['floor'].get('cycles', 0):.0f}" for k, v in meta["passes"].items() if v.get("floor")))
    bg = meta["passes"].get("inmodel_dram", {}).get("dram_background")
    if bg:
        L.append(f"- DRAM background (socket, idle): read {bg['read_Bps'] / 1e6:.0f} MB/s, write "
                 f"{bg['write_Bps'] / 1e6:.0f} MB/s; subtracted per operator as rate x duration.")
    (proc / "REPORT.md").write_text("\n".join(L) + "\n")
    print("\n".join(L[:40]))


def main(out_dir):
    out = Path(out_dir)
    (out / "plots").mkdir(exist_ok=True)
    t, meta = build_tables(out)
    mm = find_machine_model(out)
    if mm:
        t = classify(t, mm)
    t.to_csv(out / "processed" / "layer_table.csv", index=False)
    make_plots(t, meta, mm, out / "plots", out / "processed")
    report(t, meta, mm, out)


if __name__ == "__main__":
    main(sys.argv[1])
