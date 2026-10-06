#!/usr/bin/env python3
"""Analyse a scripts/mc_study.py result directory.

Per configuration (variant, K intra-op threads, S streams, batch B):
throughput, latency, speedup/efficiency, IPC, CPU utilisation (unhalted
fraction), FLOP rate, LLC misses and L2 fills per image, DRAM bandwidth and
bytes per image, average L2-miss read latency (Little's law), cycles stalled
on L3 misses, sample shares (OpenMP runtime, kernels, Python, ...), per-CPU
work imbalance, and a rule-based bottleneck label (INFERRED; rules below).
"""
import glob
import json
import os
import sys
from pathlib import Path

import numpy as np
import pandas as pd

sys.path.insert(0, str(Path(__file__).resolve().parent))
import plotstyle as ps  # noqa: E402
from matplotlib import pyplot as plt  # noqa: E402

TSC_GHZ = 2.1
PEAK_FLOP_PER_CYCLE = 63.86
WORK = {"oneDNN JIT kernel", "MKL GEMM", "ATen native kernels", "inductor generated code", "oneDNN host code"}
CATS = ["oneDNN JIT kernel", "MKL GEMM", "inductor generated code", "ATen native kernels", "oneDNN host code",
        "OpenMP runtime (spin/barrier)", "Python interpreter", "PyTorch dispatcher / other", "libc / allocator",
        "OS kernel", "unknown"]
CAT_COL = {"oneDNN JIT kernel": ps.CAT[0], "MKL GEMM": ps.CAT[6], "inductor generated code": ps.CAT[2],
           "ATen native kernels": ps.CAT[3], "oneDNN host code": ps.CAT[4], "OpenMP runtime (spin/barrier)": ps.CAT[7],
           "Python interpreter": ps.CAT[1], "PyTorch dispatcher / other": ps.CAT[5], "libc / allocator": "#b9b8b2",
           "OS kernel": "#8a8984", "unknown": "#d9d8d3"}


def read_stat(path):
    """perf stat -A -x, output -> {event: summed count over CPUs}, {event: {cpu: count}}, min %running."""
    tot, per, minrun = {}, {}, 100.0
    if not os.path.exists(path):
        return tot, per, np.nan
    for line in open(path):
        f = line.strip().split(",")
        if len(f) < 6 or not f[0].startswith("CPU"):
            continue
        try:
            v = float(f[1])
        except ValueError:
            continue
        ev = f[3].replace(" [cpu]", "").strip()
        tot[ev] = tot.get(ev, 0.0) + v
        per.setdefault(ev, {})[int(f[0][3:])] = v
        try:
            minrun = min(minrun, float(f[5]))
        except ValueError:
            pass
    return tot, per, minrun


def read_imc(path, seconds):
    r = w = 0.0
    if not os.path.exists(path):
        return np.nan, np.nan
    for line in open(path):
        f = line.strip().split(",")
        if len(f) > 3 and "cas_count" in line:
            mb = float(f[0]) * 1.048576 if f[1] == "MiB" else float(f[0]) * 64 / 1e6
            if "read" in line:
                r += mb
            else:
                w += mb
    return r / 1000 / seconds, w / 1000 / seconds


def classify_bottleneck(r):
    """Rule-based label from measured indicators (INFERRED). Order matters."""
    if r["dram_frac_of_ceiling"] >= 0.7:
        return "memory bandwidth"
    if r["openmp_share"] >= 0.30:
        return "synchronisation / too little parallel work (threads spin at barriers)"
    if r["cpu_util"] < 0.70:
        return "idle cores (serial sections)"
    if r.get("slowdown_vs_alone", 1.0) >= 1.10 and r["S"] > 1:
        return "shared L3/DRAM contention between streams"
    if r["l3_stall_frac"] >= 0.20:
        return "memory latency (L3-miss stalls)"
    if r["flop_frac_of_peak_busy"] >= 0.55:
        return "compute (FMA throughput)"
    return "kernel inefficiency / mixed"


def main(out_dir):
    out = Path(out_dir)
    raw, proc, plots = out / "raw", out / "processed", out / "plots"
    proc.mkdir(exist_ok=True)
    plots.mkdir(exist_ok=True)
    ceiling = {}
    if (raw / "membw_ceiling.json").exists():
        ceiling = {int(k): v["read"] + v["write"] for k, v in json.load(open(raw / "membw_ceiling.json")).items()}
    max_ceiling = max(ceiling.values()) if ceiling else np.nan

    rows = []
    for cf in sorted(glob.glob(str(raw / "config_*.json"))):
        c = json.load(open(cf))
        if not c.get("clean"):
            continue
        name = c["name"]
        streams = [json.load(open(p)) for p in sorted(glob.glob(str(raw / f"stream_{name}_*.json")))]
        if not streams:
            continue
        wa0, wa1 = c["windows"]["A"]
        w_end = c["windows"]["prof"][1]
        # Throughput = sum over streams of batch / mean batch latency within the counter windows. Counting
        # images completed in the window instead is quantized by whole batches (a batch-64 run on one core
        # finishes only ~6 batches in the window).
        lat, thr = [], 0.0
        for s in streams:
            ls = [L for L, e in zip(s["latency_ms"], s["end_times"]) if wa0 <= e <= w_end]
            lat += ls
            thr += s["batch"] / (np.mean(ls) / 1e3) if ls else np.nan
        A, Aper, runA = read_stat(raw / f"statA_{name}.csv")
        B, _, runB = read_stat(raw / f"statB_{name}.csv")
        wA = wa1 - wa0
        wB = c["windows"]["B"][1] - c["windows"]["B"][0]
        rA, wAw = read_imc(raw / f"imcA_{name}.csv", wA)
        rB, wBw = read_imc(raw / f"imcB_{name}.csv", wB)
        dram_r, dram_w = np.nanmean([rA, rB]), np.nanmean([wAw, wBw])
        n = c["total_cores"]
        cyc, ins = A.get("cycles", np.nan), A.get("instructions", np.nan)
        flops_rate = (16 * A.get("fp_arith_inst_retired.512b_packed_single", 0)
                      + 8 * A.get("fp_arith_inst_retired.256b_packed_single", 0)) / wA \
            + B.get("fp_arith_inst_retired.scalar_single", 0) / wB
        prof = {}
        pj = raw / f"prof_{name}.json"
        if pj.exists():
            prof = {int(k): v for k, v in json.load(open(pj)).items()}
        allc = {}
        for v in prof.values():
            for k, x in v.items():
                allc[k] = allc.get(k, 0) + x
        ns = sum(allc.values()) or np.nan
        work_per_cpu = [sum(x for k, x in prof.get(cpu, {}).items() if k in WORK) for cpu in c["cores"]]
        mean_work = np.mean(work_per_cpu) if work_per_cpu else np.nan
        r = {"name": name, "group": c.get("group"), "variant": c["variant"], "cores": n, "K": c["K"], "S": c["S"],
             "B": c["B"], "latency_ms": float(np.median(lat)) if lat else np.nan,
             "latency_p95_ms": float(np.percentile(lat, 95)) if lat else np.nan,
             "throughput_img_s": thr, "IPC": ins / cyc, "cpu_util": A.get("ref-cycles", np.nan) / (TSC_GHZ * 1e9 * wA * n),
             "GFLOP_s": flops_rate / 1e9, "GFLOP_per_image": flops_rate / thr / 1e9,
             "flop_frac_of_peak_busy": flops_rate * wA / cyc / PEAK_FLOP_PER_CYCLE,
             "llc_miss_per_image_M": A.get("longest_lat_cache.miss", np.nan) / wA / thr / 1e6,
             "l2_fill_MB_per_image": A.get("l2_lines_in.all", np.nan) * 64 / wA / thr / 1e6,
             "l3_stall_frac": A.get("memory_activity.stalls_l3_miss", np.nan) / cyc,
             "stall_frac": B.get("cycle_activity.stalls_total", np.nan) / B.get("cycles", np.nan),
             "l2_miss_latency_ns": B.get("offcore_requests_outstanding.data_rd", np.nan)
             / max(B.get("offcore_requests.data_rd", np.nan), 1) / TSC_GHZ,
             "dram_read_GBps": dram_r, "dram_write_GBps": dram_w, "dram_GBps": dram_r + dram_w,
             "dram_MB_per_image": (dram_r + dram_w) * 1000 / thr,
             "dram_frac_of_ceiling": (dram_r + dram_w) / ceiling.get(n, max_ceiling) if ceiling else np.nan,
             "openmp_share": allc.get("OpenMP runtime (spin/barrier)", 0) / ns,
             "work_share": sum(x for k, x in allc.items() if k in WORK) / ns,
             "python_dispatch_share": (allc.get("Python interpreter", 0) + allc.get("PyTorch dispatcher / other", 0)
                                       + allc.get("libc / allocator", 0)) / ns,
             "work_imbalance_max_over_mean": max(work_per_cpu) / mean_work if work_per_cpu and mean_work else np.nan,
             "counters_min_running_pct": min(runA, runB), "max_other_cpu_pct": c["max_other_cpu_pct"]}
        for k in CATS:
            r[f"share::{k}"] = allc.get(k, 0) / ns
        rows.append(r)
    df = pd.DataFrame(rows)
    if df.empty:
        print("no clean configurations")
        return
    # speedups relative to the same variant on 1 core, 1 stream, batch 1
    base = {v: d[(d.K == 1) & (d.S == 1) & (d.B == 1)] for v, d in df.groupby("variant")}
    df["speedup"] = [r.throughput_img_s / float(base[r.variant].throughput_img_s.iloc[0])
                     if len(base.get(r.variant, [])) else np.nan for r in df.itertuples()]
    df["efficiency"] = df.speedup / df.cores
    alone = {(r.variant, r.K, r.B): r.latency_ms for r in df[df.S == 1].itertuples()}
    df["slowdown_vs_alone"] = [r.latency_ms / alone.get((r.variant, r.K, r.B), np.nan) for r in df.itertuples()]
    df["bottleneck"] = [classify_bottleneck(r) for _, r in df.iterrows()]
    df = df.sort_values(["group", "variant", "cores", "K"])
    df.round(4).to_csv(proc / "mc_configs.csv", index=False)

    # ------------------------------------------------------------- tables
    cols = ["cores", "K", "S", "B", "latency_ms", "throughput_img_s", "speedup", "efficiency", "IPC", "dram_GBps",
            "llc_miss_per_image_M", "cpu_util", "openmp_share", "l2_miss_latency_ns", "GFLOP_s", "bottleneck"]
    nice = {"cores": "Cores", "K": "Intra-op", "S": "Inter-op (streams)", "B": "Batch", "latency_ms": "Latency ms",
            "throughput_img_s": "Throughput img/s", "speedup": "Speedup", "efficiency": "Efficiency", "IPC": "IPC",
            "dram_GBps": "Memory BW GB/s", "llc_miss_per_image_M": "LLC misses / image (M)",
            "cpu_util": "CPU util (unhalted)", "openmp_share": "OpenMP spin share",
            "l2_miss_latency_ns": "L2-miss latency ns", "GFLOP_s": "GFLOP/s", "bottleneck": "Bottleneck (INFERRED)"}
    md = ["# Multi-core study", "",
          "Rules for the bottleneck label (applied in order, INFERRED): DRAM traffic >= 70% of the measured "
          "ceiling for that core count -> memory bandwidth; OpenMP runtime >= 30% of samples -> "
          "synchronisation / too little parallel work; unhalted fraction < 70% -> idle cores; streams slowed "
          ">= 10% vs alone -> shared L3/DRAM contention; cycles stalled on L3 misses >= 20% -> memory latency; "
          "FLOP rate >= 55% of peak per busy cycle -> compute; otherwise kernel inefficiency / mixed.", ""]
    if ceiling:
        md += ["## Memory-system ceiling (n concurrent AVX-512 read streams)", "",
               pd.DataFrame([{"cores": k, "DRAM GB/s (read+write)": v} for k, v in sorted(ceiling.items())])
               .round(1).to_markdown(index=False), ""]
    for g in ["intra", "matrix", "batch"]:
        d = df[df.group == g]
        for v, dv in d.groupby("variant"):
            md += [f"## {g}: {v}", "", dv[cols].rename(columns=nice).round(3).to_markdown(index=False), ""]
    (proc / "MC_STUDY.md").write_text("\n".join(md))

    # ------------------------------------------------------------- plots
    intra = df[df.group == "intra"]
    matrix = df[df.group == "matrix"]
    streams = pd.concat([intra[intra.K == 1], matrix[matrix.K == 1]])
    var_col = {"baseline": ps.CAT[0], "inductor": ps.CAT[2], "fold_bn+channels_last": ps.CAT[1]}

    def line(ax, d, y, label, color, ls="-", mk="o"):
        d = d.sort_values("cores")
        ax.plot(d.cores, d[y], ls, marker=mk, color=color, label=label)

    # 1 speedup
    fig, ax = plt.subplots(figsize=(7.5, 5))
    for v, d in intra.groupby("variant"):
        line(ax, d, "speedup", f"{v}: intra-op (1 inference, N threads)", var_col.get(v, ps.NEUTRAL))
    for v, d in streams.groupby("variant"):
        line(ax, d, "speedup", f"{v}: N streams x 1 thread", var_col.get(v, ps.NEUTRAL), "--", "s")
    mx = df.cores.max()
    ax.plot([1, mx], [1, mx], ":", color=ps.NEUTRAL, linewidth=1, label="linear")
    ax.set_xlabel("cores")
    ax.set_ylabel("throughput speedup vs 1 core")
    ps.titled(ax, "Speedup vs cores", "batch 1; speedup = images/s relative to the same variant on 1 core")
    ax.legend(fontsize=8)
    fig.savefig(plots / "mc_speedup.png")
    plt.close(fig)

    # 2 memory bandwidth, IPC, utilisation, LLC misses (4 panels)
    fig, axes = plt.subplots(2, 2, figsize=(12, 8.5))
    panels = [("dram_GBps", "socket DRAM traffic (GB/s)", "Memory bandwidth vs cores"),
              ("IPC", "instructions per cycle (all cores)", "IPC vs cores"),
              ("cpu_util", "unhalted fraction of the cores used", "CPU utilisation vs cores"),
              ("llc_miss_per_image_M", "LLC misses per image (millions)", "Cache misses vs cores")]
    for ax, (y, yl, t) in zip(axes.flat, panels):
        for v, d in intra.groupby("variant"):
            line(ax, d, y, f"{v}: intra-op", var_col.get(v, ps.NEUTRAL))
        for v, d in streams.groupby("variant"):
            line(ax, d, y, f"{v}: streams", var_col.get(v, ps.NEUTRAL), "--", "s")
        if y == "dram_GBps" and ceiling:
            ks = sorted(ceiling)
            ax.plot(ks, [ceiling[k] for k in ks], ":", color=ps.CAT[7], marker="^", label="measured ceiling")
        if y == "cpu_util":
            for v, d in intra.groupby("variant"):
                d = d.sort_values("cores")
                ax.plot(d.cores, d.work_share * d.cpu_util, "-.", color=var_col.get(v, ps.NEUTRAL),
                        label=f"{v}: intra-op, useful work only")
            ax.set_ylim(0, 1.05)
        ax.set_xlabel("cores")
        ax.set_ylabel(yl)
        ps.titled(ax, t)
        ax.legend(fontsize=7)
    fig.savefig(plots / "mc_counters.png")
    plt.close(fig)

    # 3 bottleneck migration: where the cycles go (sample shares) vs cores, intra-op
    for v, d in intra.groupby("variant"):
        d = d.sort_values("cores")
        fig, ax = plt.subplots(figsize=(9, 4.8))
        xs = np.arange(len(d))
        bottom = np.zeros(len(d))
        for k in CATS:
            vals = d[f"share::{k}"].values * 100
            if vals.max() < 0.5:
                continue
            ax.bar(xs, vals, bottom=bottom, color=CAT_COL[k], label=k, width=0.7)
            bottom += vals
        ax.set_xticks(xs)
        ax.set_xticklabels([f"{c} cores\n{l:.1f} ms" for c, l in zip(d.cores, d.latency_ms)])
        ax.set_ylabel("% of cycle samples on the cores used")
        ps.titled(ax, f"Where the busy cycles go as cores are added ({v}, one inference, N threads)",
                  "perf record on the cores used; idle (halted) time produces no samples, see CPU utilisation")
        ax.legend(ncol=3, fontsize=7.5, loc="upper center", bbox_to_anchor=(0.5, -0.18))
        fig.savefig(plots / f"mc_migration_{v}.png")
        plt.close(fig)

    # 4 matrix: throughput and latency per split
    if len(matrix):
        fig, axes = plt.subplots(1, 2, figsize=(12, 4.8))
        allm = pd.concat([matrix, intra[intra.cores.isin(matrix.cores.unique())]])
        for v, dv in allm.groupby("variant"):
            for tot, d in dv.groupby("cores"):
                d = d.sort_values("K")
                lab = f"{v}, {tot} cores"
                axes[0].plot(d.K, d.throughput_img_s, marker="o", label=lab,
                             color=var_col.get(v, ps.NEUTRAL), alpha=0.35 + 0.65 * tot / 28)
                axes[1].plot(d.K, d.latency_ms, marker="o", label=lab,
                             color=var_col.get(v, ps.NEUTRAL), alpha=0.35 + 0.65 * tot / 28)
        for ax, yl, t in ((axes[0], "images/s (whole machine)", "Throughput by split"),
                          (axes[1], "ms per inference", "Latency by split")):
            ax.set_xscale("log", base=2)
            ax.set_xlabel("intra-op threads per stream (streams = cores / intra-op)")
            ax.set_ylabel(yl)
            ps.titled(ax, t, "same total cores, divided between intra-op threads and concurrent streams")
            ax.legend(fontsize=7)
        axes[1].set_yscale("log")
        fig.savefig(plots / "mc_matrix.png")
        plt.close(fig)

    # 5 batch x cores
    bt = pd.concat([df[df.group == "batch"], intra[(intra.variant == "baseline") & intra.cores.isin([1, 8, 28])]])
    if len(bt):
        fig, axes = plt.subplots(1, 2, figsize=(12, 4.6))
        for k, d in bt.groupby("K"):
            d = d.sort_values("B")
            axes[0].plot(d.B, d.throughput_img_s, marker="o", label=f"{k} cores")
            axes[1].plot(d.B, d.latency_ms, marker="o", label=f"{k} cores")
        for ax, yl, t in ((axes[0], "images/s", "Throughput vs batch size"),
                          (axes[1], "ms per batch", "Latency of one batch vs batch size")):
            ax.set_xscale("log", base=2)
            ax.set_xlabel("batch size")
            ax.set_ylabel(yl)
            ps.titled(ax, t, "baseline, one process, intra-op threads = cores")
            ax.legend(fontsize=8)
        axes[1].set_yscale("log")
        fig.savefig(plots / "mc_batch.png")
        plt.close(fig)
    md += split_by_threads(raw, proc, plots)
    (proc / "MC_STUDY.md").write_text("\n".join(md))
    print("\n".join(md))


SPLIT_PARTS = ["conv kernels", "weight re-layout", "activation re-layout", "framework around convs",
               "BN + ReLU + add", "max-pool", "avgpool"]


def split_by_threads(raw, proc, plots):
    """Per-layer time split (experiments/per_calc.py, library verbose timers) summed by part, per thread count."""
    rows = []
    for f in sorted(glob.glob(str(raw / "per_calc_layers_K*.csv")), key=lambda p: int(p.split("_K")[-1][:-4])):
        K = int(f.split("_K")[-1][:-4])
        d = pd.read_csv(f)
        conv = d.op.str.startswith("conv") | (d.op == "fc")
        r = {"threads": K,
             "conv kernels": d[conv].kernel_ms.sum() + d[conv].other_library_ms.sum(),
             "weight re-layout": d[conv].weight_relayout_ms.sum(),
             "activation re-layout": d[conv].act_relayout_ms.sum(),
             "framework around convs": d[conv].framework_other_ms.sum(),
             "BN + ReLU + add": d[d.op.isin(["batchnorm", "relu", "add"])].time_ms.sum(),
             "max-pool": d[d.op == "maxpool"].time_ms.sum(),
             "avgpool": d[d.op == "avgpool"].time_ms.sum(),
             "sum of operators": d.time_ms.sum()}
        vb = raw / f"verbose_per_op_K{K}.txt"
        if vb.exists():
            txt = vb.read_text()
            r["MKL SGEMM calls / 5 inferences"] = txt.count("MKL_VERBOSE SGEMM")
            r["oneDNN conv calls / 5 inferences"] = txt.count(",exec,cpu,convolution")
        rows.append(r)
    if not rows:
        return []
    s = pd.DataFrame(rows)
    one = s[s.threads == 1].iloc[0]
    for p in SPLIT_PARTS + ["sum of operators"]:
        s[f"{p} speedup"] = one[p] / s[p]
    s.round(3).to_csv(proc / "split_by_threads.csv", index=False)

    fig, ax = plt.subplots(figsize=(9, 4.8))
    xs = np.arange(len(s))
    bottom = np.zeros(len(s))
    for i, p in enumerate(SPLIT_PARTS):
        share = s[p].values / s["sum of operators"].values * 100
        ax.bar(xs, share, bottom=bottom, color=ps.CAT[i % len(ps.CAT)], label=p, width=0.7)
        bottom += share
    ax.set_xticks(xs)
    ax.set_xticklabels([f"{k} threads\n{t:.1f} ms" for k, t in zip(s.threads, s["sum of operators"])])
    ax.set_ylabel("% of operator time")
    ps.titled(ax, "Where one inference's time goes as threads are added (baseline)",
              "per-layer library timers (oneDNN / MKL verbose) + forward hooks; experiments/per_calc.py")
    ax.legend(ncol=4, fontsize=7.5, loc="upper center", bbox_to_anchor=(0.5, -0.18))
    fig.savefig(plots / "mc_split_by_threads.png")
    plt.close(fig)

    cols = ["threads"] + SPLIT_PARTS + ["sum of operators"] + [c for c in s.columns if "calls" in c]
    return ["## Per-layer time split vs threads (baseline, ms per inference)", "",
            s[cols].round(2).to_markdown(index=False), "",
            "Speedup of each part vs 1 thread:", "",
            s[["threads"] + [f"{p} speedup" for p in SPLIT_PARTS + ["sum of operators"]]].round(2)
            .to_markdown(index=False), ""]


if __name__ == "__main__":
    main(sys.argv[1])
