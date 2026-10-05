#!/usr/bin/env python3
"""Analyse a results/<date>_microbench directory.

Produces processed/*.csv summaries (median over repetitions), plots/*.png and
processed/machine_model.json -- the empirical compute and memory ceilings
that the ResNet roofline is built on.

Plateau values per cache level use working sets that sit well inside each
level's nominal capacity (from sysfs), so they are robust to where exactly the
transition happens. Transitions themselves are reported as *apparent*
(latency jumps), not as proof of a level boundary.
"""
import json
import sys
from pathlib import Path

import numpy as np
import pandas as pd

sys.path.insert(0, str(Path(__file__).resolve().parent))
import plotstyle as ps  # noqa: E402
from matplotlib import pyplot as plt  # noqa: E402
from matplotlib.ticker import FuncFormatter  # noqa: E402

TSC_GHZ = 2.1
KiB, MiB = 1 << 10, 1 << 20
NOMINAL = {"L1d 48 KiB": 48 * KiB, "L2 2 MiB": 2 * MiB, "L3 52.5 MiB": 52.5 * MiB}
PLATEAU = {  # working-set windows used to read each level's plateau
    "L1": (4 * KiB, 32 * KiB), "L2": (256 * KiB, 1 * MiB),
    "L3": (8 * MiB, 24 * MiB), "DRAM": (512 * MiB, 4096 * MiB),
}


def load(raw: Path, pattern: str) -> pd.DataFrame:
    frames = [pd.read_csv(f).assign(file=f.stem) for f in sorted(raw.glob(pattern))]
    df = pd.concat(frames, ignore_index=True)
    df["freq_ghz"] = df["cycles"] / df["ref_cycles"] * TSC_GHZ
    return df


def med(df, keys, cols):
    g = df.groupby(keys)[cols]
    out = g.median().add_suffix("_median")
    out = out.join(g.min().add_suffix("_min")).join(g.max().add_suffix("_max")).join(g.std().add_suffix("_std"))
    out["n_reps"] = g.size()
    return out.reset_index()


def analyze_compute(raw, proc, plots, model):
    df = load(raw, "compute.csv")
    df["cyc_per_op"] = df["cycles"] / df["work"]
    df["ops_per_cycle"] = df["work"] / df["cycles"]
    s = med(df, ["variant", "param"], ["cyc_per_op", "ops_per_cycle", "freq_ghz"])
    s.rename(columns={"param": "chains_K"}, inplace=True)
    width = {"int_add": 1, "int_imul": 1, "fp32_scalar_add": 1, "fp32_scalar_mul": 1, "fp32_scalar_fma": 1,
             "fp32_sse_fma": 4, "fp32_avx2_fma": 8, "fp32_avx512_add": 16, "fp32_avx512_mul": 16,
             "fp32_avx512_fma": 16}
    fpo = {"fp32_scalar_add": 1, "fp32_scalar_mul": 1, "fp32_scalar_fma": 2, "fp32_sse_fma": 2,
           "fp32_avx2_fma": 2, "fp32_avx512_add": 1, "fp32_avx512_mul": 1, "fp32_avx512_fma": 2}
    s["flops_per_cycle_median"] = [r.ops_per_cycle_median * width[r.variant] * fpo.get(r.variant, 0)
                                   for r in s.itertuples()]
    s.to_csv(proc / "compute_summary.csv", index=False)

    lat = s[s.chains_K == 1].set_index("variant")["cyc_per_op_median"].round(2).to_dict()
    tput = s.groupby("variant")["ops_per_cycle_median"].max().round(2).to_dict()
    peak = s.groupby("variant")["flops_per_cycle_median"].max().round(2).to_dict()
    model["compute"] = {
        "latency_cycles_K1": lat, "max_ops_per_cycle": tput, "peak_fp32_flops_per_cycle": peak,
        "freq_ghz_during_avx512": round(float(s[s.variant == "fp32_avx512_fma"]["freq_ghz_median"].median()), 3),
        "peak_fp32_gflops_avx512": round(peak["fp32_avx512_fma"] * TSC_GHZ, 1),
    }

    # Plot: latency -> throughput transition.
    fig, ax = plt.subplots(figsize=(7.5, 4.4))
    show = ["fp32_scalar_fma", "fp32_avx2_fma", "fp32_avx512_fma", "fp32_scalar_add", "int_add", "int_imul"]
    for i, v in enumerate(show):
        d = s[s.variant == v]
        ax.plot(d.chains_K, d.ops_per_cycle_median, marker="o", color=ps.CAT[i], label=v)
    ax.set_xlabel("independent dependency chains (K)")
    ax.set_ylabel("instructions completed per cycle")
    ps.titled(ax, "Independent work turns latency into throughput",
              "One chain exposes latency (FMA: 4 cycles); ~8 chains saturate the two FMA pipes")
    ax.legend(ncol=2, loc="upper left")
    ax.set_xticks([1, 2, 4, 6, 8, 10, 12, 16])
    fig.savefig(plots / "compute_chains.png")
    plt.close(fig)

    # Plot 14: scalar vs SSE vs AVX2 vs AVX-512 peak FLOP/cycle.
    order = ["fp32_scalar_fma", "fp32_sse_fma", "fp32_avx2_fma", "fp32_avx512_fma"]
    labels = ["scalar FMA\n(1 lane)", "SSE FMA\n(4 lanes)", "AVX2 FMA\n(8 lanes)", "AVX-512 FMA\n(16 lanes)"]
    vals = [peak[o] for o in order]
    fig, ax = plt.subplots(figsize=(6.5, 4))
    bars = ax.bar(labels, vals, color=ps.CAT[0], width=0.6)
    for b, v in zip(bars, vals):
        ax.text(b.get_x() + b.get_width() / 2, v, f"{v:.1f}", ha="center", va="bottom", fontsize=9, color=ps.TEXT)
    ax.set_ylabel("peak FP32 FLOP / cycle (one core)")
    ps.titled(ax, "Vector width multiplies peak arithmetic throughput",
              f"2 FMA instr/cycle at every width; AVX-512 peak = {peak['fp32_avx512_fma']:.1f} FLOP/cycle "
              f"= {peak['fp32_avx512_fma'] * TSC_GHZ:.0f} GFLOP/s at 2.1 GHz")
    fig.savefig(plots / "compute_simd_peak.png")
    plt.close(fig)


def plateau(df, col, level):
    lo, hi = PLATEAU[level]
    d = df[(df.ws_bytes >= lo) & (df.ws_bytes <= hi)]
    return float(d[col].median()) if len(d) else None


def analyze_memlat(raw, proc, plots, model):
    df = load(raw, "memlat_*.csv")
    df["cyc_per_load"] = df["cycles"] / df["work"]
    df["ns_per_load"] = df["ns"] / df["work"]
    s = med(df, ["variant", "ws_bytes"], ["cyc_per_load", "ns_per_load"])
    s.to_csv(proc / "memlat_summary.csv", index=False)
    model["latency"] = {}
    for v in s.variant.unique():
        d = s[s.variant == v]
        model["latency"][v] = {lvl: {"cycles": round(plateau(d, "cyc_per_load_median", lvl) or float("nan"), 1),
                                     "ns": round(plateau(d, "ns_per_load_median", lvl) or float("nan"), 1)}
                               for lvl in PLATEAU}
        # Apparent transitions: first ws where latency exceeds 1.5x the running plateau.
        trans, base = [], None
        for r in d.sort_values("ws_bytes").itertuples():
            if base is None:
                base = r.cyc_per_load_median
            elif r.cyc_per_load_median > 1.5 * base:
                trans.append({"ws_bytes": int(r.ws_bytes), "from_cycles": round(base, 1),
                              "to_cycles": round(r.cyc_per_load_median, 1)})
                base = r.cyc_per_load_median
        model["latency"][v]["apparent_transitions"] = trans

    fig, ax = plt.subplots(figsize=(8, 4.6))
    names = {"random_4k": "random, 4 KiB pages", "random_thp": "random, 2 MiB pages (THP)",
             "sequential_4k": "sequential, 4 KiB pages"}
    for i, v in enumerate(["random_4k", "random_thp", "sequential_4k"]):
        d = s[s.variant == v]
        if len(d):
            ax.plot(d.ws_bytes, d.ns_per_load_median, marker="o", markersize=3, color=ps.CAT[i], label=names[v])
    ax.set_xscale("log", base=2)
    ax.set_yscale("log")
    ax.xaxis.set_major_formatter(FuncFormatter(ps.fmt_bytes))
    ax.yaxis.set_major_formatter(FuncFormatter(lambda y, _: f"{y:g}"))
    ps.cache_lines(ax, NOMINAL)
    ax.set_xlabel("working set (bytes)")
    ax.set_ylabel("ns per dependent load (log)")
    ps.titled(ax, "Load latency steps up at each cache level",
              "Pointer chase, one load in flight; dashed lines = nominal capacities (sysfs)")
    ax.legend(loc="upper center", bbox_to_anchor=(0.5, -0.16), ncol=3)
    fig.savefig(plots / "memory_latency_vs_ws.png")
    plt.close(fig)


def analyze_membw(raw, proc, plots, model):
    df = load(raw, "membw_*.csv")
    df["gbps"] = df["work"] / df["ns"]
    df["bytes_per_cycle"] = df["work"] / df["cycles"]
    s = med(df, ["variant", "ws_bytes"], ["gbps", "bytes_per_cycle"])
    s.to_csv(proc / "membw_summary.csv", index=False)
    model["bandwidth"] = {}
    for v in s.variant.unique():
        d = s[s.variant == v]
        model["bandwidth"][v] = {lvl: {"GBps": round(plateau(d, "gbps_median", lvl) or float("nan"), 1),
                                       "bytes_per_cycle": round(plateau(d, "bytes_per_cycle_median", lvl) or float("nan"), 2)}
                                 for lvl in PLATEAU}
    fig, ax = plt.subplots(figsize=(8, 4.6))
    order = ["read_4k", "write_4k", "copy_4k", "triad_4k", "write_nt_4k", "rand_read_4k"]
    for i, v in enumerate(order):
        d = s[s.variant == v]
        if len(d):
            ax.plot(d.ws_bytes, d.gbps_median, marker="o", markersize=3, color=ps.CAT[i], label=v.replace("_4k", ""))
    ax.set_xscale("log", base=2)
    ax.set_yscale("log")
    ax.xaxis.set_major_formatter(FuncFormatter(ps.fmt_bytes))
    ax.yaxis.set_major_formatter(FuncFormatter(lambda y, _: f"{y:g}"))
    ps.cache_lines(ax, NOMINAL)
    ax.set_xlabel("working set, all arrays (bytes)")
    ax.set_ylabel("GB/s requested by the program (log)")
    ps.titled(ax, "One core's bandwidth collapses once data leaves the private L2",
              "AVX-512 kernels, 4 KiB pages; rand_read counts 64 B per random line touched")
    ax.legend(ncol=3, loc="lower left")
    fig.savefig(plots / "memory_bandwidth_vs_ws.png")
    plt.close(fig)


def analyze_intensity(raw, proc, plots, model):
    df = load(raw, "intensity*.csv")
    df["ai"] = (2 * df["param"] + 1) / 4
    df["flops_per_cycle"] = df["work"] / df["cycles"]
    df["gflops"] = df["work"] / df["ns"]
    df["level"] = df["ws_bytes"].map(lambda b: "L1" if b <= 48 * KiB else "L2" if b <= 2 * MiB
                                     else "L3" if b <= 52 * MiB else "DRAM")
    df.loc[df.file.str.endswith("_thp"), "level"] = "DRAM (2 MiB pages)"
    s = med(df, ["level", "ws_bytes", "param", "ai"], ["flops_per_cycle", "gflops"])
    s.to_csv(proc / "intensity_summary.csv", index=False)
    peak = float(s["flops_per_cycle_median"].max())
    model["intensity_peak_flops_per_cycle"] = round(peak, 2)

    fig, ax = plt.subplots(figsize=(7.5, 4.6))
    for i, lvl in enumerate(["L1", "L2", "L3", "DRAM", "DRAM (2 MiB pages)"]):
        d = s[s.level == lvl].sort_values("ai")
        if not len(d):
            continue
        lab = (f"{lvl} ({ps.fmt_bytes(d.ws_bytes.iloc[0])})" if "(" not in lvl
               else f"DRAM ({ps.fmt_bytes(d.ws_bytes.iloc[0])}, 2 MiB pages)")
        ax.plot(d.ai, d.flops_per_cycle_median, marker="o", color=ps.CAT[i], label=lab)
        bw = model["bandwidth"].get("read_4k", {}).get(lvl, {}).get("bytes_per_cycle")
        if lvl.startswith("DRAM ("):
            bw = None
        if bw:
            x = np.logspace(-1, 2, 50)
            ax.plot(x, np.minimum(peak, bw * x), color=ps.CAT[i], linestyle=":", linewidth=1)
    ax.axhline(peak, color=ps.NEUTRAL, linestyle="--", linewidth=0.9)
    ax.text(0.11, peak * 1.04, f"measured FMA peak {peak:.1f} FLOP/cycle", fontsize=8, color=ps.TEXT2)
    ax.set_xscale("log")
    ax.set_yscale("log")
    ax.set_xlabel("arithmetic intensity (FLOP per byte loaded)")
    ax.set_ylabel("achieved FLOP / cycle (log)")
    ps.titled(ax, "Empirical roofline of one core",
              "Solid: measured kernel; dotted: min(peak, read bandwidth x AI) per level")
    ax.legend(loc="lower right")
    fig.savefig(plots / "roofline_microbench.png")
    plt.close(fig)


def analyze_flags(raw, proc, plots, model, asm_dir):
    df = load(raw, "flags_*.csv")
    df[["flagset", "kernel"]] = df["variant"].str.split(":", expand=True)
    df["cyc_per_elem"] = df["cycles"] / df["work"]
    s = med(df, ["flagset", "kernel"], ["cyc_per_elem"])
    # Instruction-set evidence from the disassembly of each kernel function.
    evid = []
    for r in s.itertuples():
        f = asm_dir / f"flags_{r.flagset}.asm"
        body = []
        if f.exists():
            on = False
            for line in f.read_text().splitlines():
                if line.endswith(f"<{r.kernel}>:"):
                    on = True
                    continue
                if on and (line.strip() == "" or (line and not line.startswith(" "))):
                    break
                if on:
                    body.append(line)
        txt = "\n".join(body)
        evid.append({"zmm": txt.count("zmm"), "ymm": txt.count("ymm"),
                     "packed_ps": sum(txt.count(k) for k in ("mulps", "addps", "fmadd", "maxps")),
                     "scalar_ss": sum(txt.count(k) for k in ("mulss", "addss", "maxss", "fmadd231ss", "comiss")),
                     "fma": txt.count("vfmadd"), "instructions_in_function": len(body)})
    s = pd.concat([s, pd.DataFrame(evid)], axis=1)
    s.to_csv(proc / "flags_summary.csv", index=False)
    model["compiler_flags"] = s[["flagset", "kernel", "cyc_per_elem_median", "zmm", "ymm", "scalar_ss",
                                 "packed_ps"]].round(3).to_dict(orient="records")

    order = ["O2", "O3", "O3_native", "O3_native_zmm", "O3_native_fast"]
    kernels = ["saxpy", "dot", "relu"]
    fig, ax = plt.subplots(figsize=(8, 4.4))
    # Dot plot (not bars): on a log axis bar length has no meaning.
    for i, fl in enumerate(order):
        d = s[s.flagset == fl].set_index("kernel").reindex(kernels)
        x = np.arange(len(kernels)) + (i - 2) * 0.15
        ax.scatter(x, d.cyc_per_elem_median, s=46, color=ps.CAT[i], label=fl, zorder=3,
                   edgecolor=ps.SURFACE, linewidth=1.5)
        for xi, v in zip(x, d.cyc_per_elem_median):
            ax.text(xi, v * 1.13, f"{v:.2f}", ha="center", va="bottom", fontsize=7, color=ps.TEXT2)
    ax.set_xticks(np.arange(len(kernels)))
    ax.set_xticklabels(kernels)
    ax.set_xlim(-0.6, len(kernels) - 0.4)
    ax.set_yscale("log")
    ax.yaxis.set_major_formatter(FuncFormatter(lambda y, _: f"{y:g}"))
    ax.set_ylabel("cycles per element (log, lower is better)")
    ps.titled(ax, "Same C source, different machine code",
              "8 KiB arrays (L1-resident), GCC 13.3. Colors = compiler flag set (left to right as listed)")
    ax.legend(ncol=5, loc="upper center", bbox_to_anchor=(0.5, -0.1))
    fig.savefig(plots / "compiler_flags.png")
    plt.close(fig)


def main(out_dir):
    out = Path(out_dir)
    raw, proc, plots = out / "raw", out / "processed", out / "plots"
    proc.mkdir(exist_ok=True)
    plots.mkdir(exist_ok=True)
    model = {"source": str(out.name), "tsc_ghz": TSC_GHZ, "plateau_windows_bytes": PLATEAU}
    analyze_compute(raw, proc, plots, model)
    analyze_memlat(raw, proc, plots, model)
    analyze_membw(raw, proc, plots, model)
    analyze_intensity(raw, proc, plots, model)
    analyze_flags(raw, proc, plots, model, out / "asm")
    (proc / "machine_model.json").write_text(json.dumps(model, indent=2) + "\n")
    print(json.dumps({k: model[k] for k in ("compute", "latency", "bandwidth")}, indent=1)[:6000])


if __name__ == "__main__":
    main(sys.argv[1])
