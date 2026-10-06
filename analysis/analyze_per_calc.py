#!/usr/bin/env python3
"""Per-calculation cost of every operator vs the core-level cost of one calculation.

Inputs (one result directory):
  raw/compute.csv          microbench/bin/compute (register-only instruction loops)
  raw/per_calc_layers.csv  experiments/per_calc.py
Outputs: processed/core_single_calc.csv, processed/per_calc_layers.csv,
processed/per_calc_by_op.csv, processed/PER_CALC.md, plots/per_calc_*.png
"""
import sys
from pathlib import Path

import numpy as np
import pandas as pd

sys.path.insert(0, str(Path(__file__).resolve().parent))
import plotstyle as ps  # noqa: E402
from matplotlib import pyplot as plt  # noqa: E402

GHZ = 2.1
OPS = ["conv1x1", "conv3x3", "conv7x7", "fc", "batchnorm", "relu", "add", "maxpool", "avgpool"]
# Which core-level instruction performs one calculation of each operator type.
REF = {"conv1x1": "fp32_avx512_fma", "conv3x3": "fp32_avx512_fma", "conv7x7": "fp32_avx512_fma",
       "fc": "fp32_avx512_fma", "batchnorm": "fp32_avx512_fma", "relu": "fp32_avx512_max",
       "add": "fp32_avx512_add", "maxpool": "fp32_avx512_max", "avgpool": "fp32_avx512_add"}
LANES = {"scalar": 1, "sse": 4, "avx2": 8, "avx512": 16}


def core_table(out):
    c = pd.read_csv(out / "raw" / "compute.csv")
    c = c[c.bench == "compute"]
    c["cyc_per_instr"] = c.cycles / c.work
    g = c.groupby(["variant", "param"]).cyc_per_instr.median().reset_index()
    rows = []
    for v, d in g.groupby("variant"):
        if not v.startswith("fp32"):
            continue
        lanes = LANES[v.split("_")[1]]
        lat = float(d[d.param == 1].cyc_per_instr.iloc[0])
        thr = float(d.cyc_per_instr.min())
        rows.append({"instruction": v, "lanes": lanes, "latency_cycles": lat, "latency_ns": lat / GHZ,
                     "throughput_cycles_per_instr": thr, "instr_per_cycle": 1 / thr,
                     "ns_per_calc_dependent": lat / GHZ,              # each calc waits for the previous
                     "ns_per_calc_scalar_pipelined": thr / GHZ if lanes == 1 else np.nan,
                     "ns_per_calc_peak": thr / lanes / GHZ})           # all lanes, all pipelines busy
    t = pd.DataFrame(rows).set_index("instruction")
    t.round(5).to_csv(out / "processed" / "core_single_calc.csv")
    return t


def main(out_dir):
    out = Path(out_dir)
    (out / "plots").mkdir(exist_ok=True)
    core = core_table(out)
    d = pd.read_csv(out / "raw" / "per_calc_layers.csv")
    d = d[d.calculations > 0].copy()
    d["ns_per_calc"] = d.time_ms * 1e6 / d.calculations
    d["kernel_ns_per_calc"] = np.where(d.kernel_ms > 0, d.kernel_ms * 1e6 / d.calculations, np.nan)
    d["core_peak_ns_per_calc"] = [core.loc[REF[o], "ns_per_calc_peak"] for o in d.op]
    d["x_slower_than_core_peak"] = d.ns_per_calc / d.core_peak_ns_per_calc
    d["kernel_x_slower_than_core_peak"] = d.kernel_ns_per_calc / d.core_peak_ns_per_calc
    parts = ["kernel_ms", "weight_relayout_ms", "act_relayout_ms", "other_library_ms", "framework_other_ms"]
    names = {"kernel_ms": "compute kernel", "weight_relayout_ms": "weight re-layout",
             "act_relayout_ms": "activation re-layout", "other_library_ms": "other oneDNN",
             "framework_other_ms": "framework / ATen-native loop"}
    d["dominant_part"] = [names[max(parts, key=lambda p: r[p])] for _, r in d.iterrows()]
    d["dominant_part_share"] = [max(r[p] for p in parts) / r.time_ms for _, r in d.iterrows()]
    d.round(6).to_csv(out / "processed" / "per_calc_layers.csv", index=False)

    rows = []
    for o in OPS:
        x = d[d.op == o]
        if not len(x):
            continue
        f, s = x.loc[x.ns_per_calc.idxmin()], x.loc[x.ns_per_calc.idxmax()]
        rows.append({"op": o, "layers": len(x), "unit": x.unit.iloc[0],
                     "core_peak_ns_per_calc": x.core_peak_ns_per_calc.iloc[0],
                     "avg_ns_per_calc": x.time_ms.sum() * 1e6 / x.calculations.sum(),
                     "fastest_ns_per_calc": f.ns_per_calc, "fastest_layer": f.layer,
                     "slowest_ns_per_calc": s.ns_per_calc, "slowest_layer": s.layer,
                     "avg_x_core_peak": x.time_ms.sum() * 1e6 / x.calculations.sum() / x.core_peak_ns_per_calc.iloc[0],
                     "fastest_x_core_peak": f.x_slower_than_core_peak,
                     "slowest_x_core_peak": s.x_slower_than_core_peak,
                     "slowest_layer_dominant_part": f"{s.dominant_part} ({100 * s.dominant_part_share:.0f}%)",
                     "total_ms": x.time_ms.sum()})
    by = pd.DataFrame(rows)
    by.round(5).to_csv(out / "processed" / "per_calc_by_op.csv", index=False)

    # ---- plot 1: ns per calculation, every layer, vs core-level single-calculation costs
    fig, ax = plt.subplots(figsize=(12, 5.2))
    xs = np.arange(len(d))
    for i, o in enumerate(OPS):
        m = (d.op == o).values
        if m.any():
            ax.scatter(xs[m], d.ns_per_calc.values[m], s=16, color=ps.CAT[i % 8] if i < 8 else ps.NEUTRAL,
                       label=f"{o} (per {d[d.op == o].unit.iloc[0]})", zorder=3)
    fma = core.loc["fp32_avx512_fma"]
    for y, lab in ((fma.ns_per_calc_dependent, f"one FMA, waiting on the previous: {fma.ns_per_calc_dependent:.2f} ns"),
                   (core.loc["fp32_scalar_fma", "ns_per_calc_scalar_pipelined"],
                    f"scalar FMAs, pipelined: {core.loc['fp32_scalar_fma', 'ns_per_calc_scalar_pipelined']:.2f} ns"),
                   (fma.ns_per_calc_peak, f"AVX-512 peak, one MAC: {fma.ns_per_calc_peak * 1000:.1f} ps")):
        ax.axhline(y, color=ps.NEUTRAL, linestyle="--", linewidth=0.9, zorder=1)
        ax.text(len(d) - 1, y * 1.12, lab, fontsize=8, color=ps.TEXT2, ha="right")
    ax.set_yscale("log")
    ax.set_xlabel("operator, in execution order")
    ax.set_ylabel("nanoseconds per calculation (log)")
    ps.titled(ax, "Time per single calculation inside every operator vs the core's own cost of one calculation",
              "in-model time / calculations (MACs for convs and fc, elements or comparisons otherwise); dashed = "
              "measured core-level costs")
    ax.legend(ncol=5, loc="upper center", bbox_to_anchor=(0.5, -0.13), fontsize=8)
    fig.savefig(out / "plots" / "per_calc_by_layer.png")
    plt.close(fig)

    # ---- plot 2: where the time goes inside each conv / fc layer
    cv = d[d.op.str.startswith("conv") | (d.op == "fc")]
    fig, ax = plt.subplots(figsize=(12, 4.8))
    bottom = np.zeros(len(cv))
    cols = {"kernel_ms": ps.CAT[0], "weight_relayout_ms": ps.CAT[1], "act_relayout_ms": ps.CAT[3],
            "other_library_ms": ps.CAT[4], "framework_other_ms": ps.NEUTRAL}
    xs = np.arange(len(cv))
    for p in parts:
        ax.bar(xs, cv[p].values, bottom=bottom, color=cols[p], label=names[p], width=0.8)
        bottom += cv[p].values
    ax.set_xticks(xs[::4])
    ax.set_xticklabels(cv.layer.values[::4], rotation=60, ha="right", fontsize=7)
    ax.set_ylabel("ms per call")
    ps.titled(ax, "Inside each convolution: compute kernel vs re-layout vs framework",
              "oneDNN / MKL verbose timers per call (median of the verbose passes); framework = hook time - library time")
    ax.legend(ncol=5, loc="upper left", fontsize=8)
    fig.savefig(out / "plots" / "per_calc_conv_parts.png")
    plt.close(fig)

    md = ["# Cost of one calculation: core level vs inside each operator", "",
          "## Core level (microbench/bin/compute, register-only loops, cycles at 2.1 GHz)", "",
          core.round(4).to_markdown(), "",
          "## Per operator type (in-model, one core)", "",
          "avg = total time / total calculations of that type; fastest/slowest = layer with the lowest/highest "
          "ns per calculation; x core peak = how many times longer than the AVX-512 peak cost of the same "
          "calculation.", "", by.round(4).to_markdown(index=False), "",
          "## Slowest 15 layers relative to core peak", "",
          d.sort_values("x_slower_than_core_peak", ascending=False).head(15)[
              ["layer", "op", "input_shape", "calculations", "time_ms", "ns_per_calc", "x_slower_than_core_peak",
               "kernel_ms", "weight_relayout_ms", "act_relayout_ms", "framework_other_ms", "dominant_part"]
          ].round(4).to_markdown(index=False), ""]
    (out / "processed" / "PER_CALC.md").write_text("\n".join(md))
    print("\n".join(md))


if __name__ == "__main__":
    main(sys.argv[1])
