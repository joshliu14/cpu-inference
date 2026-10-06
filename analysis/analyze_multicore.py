#!/usr/bin/env python3
"""Summarise experiments/multicore.sh output: thread scaling and N instances."""
import json
import sys
from pathlib import Path

import numpy as np
import pandas as pd

sys.path.insert(0, str(Path(__file__).resolve().parent))
import plotstyle as ps  # noqa: E402
from matplotlib import pyplot as plt  # noqa: E402


def imc_gbps(path, seconds):
    """perf stat -x, output of the two IMC CAS events -> (read, write) GB/s."""
    if not path.exists():
        return np.nan, np.nan
    vals = {}
    for line in path.read_text().splitlines():
        f = line.split(",")
        if len(f) > 3 and "cas_count" in line:
            # perf scales CAS counts to MiB (unit column) on this kernel
            v, unit = float(f[0]), f[1]
            mb = v * 1.048576 if unit == "MiB" else v * 64 / 1e6
            vals["read" if "read" in line else "write"] = mb / 1000 / seconds
    return vals.get("read", np.nan), vals.get("write", np.nan)


def main(out_dir):
    out = Path(out_dir)
    (out / "plots").mkdir(exist_ok=True)
    md = ["# Multi-core experiments", "",
          "Not part of the single-core baseline. `threads`: one inference at a time split across N intra-op "
          "threads (CPUs 1..N, OMP_PROC_BIND=close). `instances`: N independent single-thread copies, one per "
          "core (CPUs 1..N), started together and measured over the same window. DRAM traffic is socket-wide "
          "(uncore IMC CAS counts).", ""]

    # ---------------------------------------------------------------- threads
    th = [json.loads(p.read_text()) for p in sorted((out / "raw").glob("threads_*.json"))]
    tt = pd.DataFrame([{"variant": r["variant"], "cores": r["threads"], "median_ms": r["latency_ms"]["median"],
                        "p95_ms": r["latency_ms"]["p95"], "dram_read_MB_per_inf": r.get("dram_read_MB_per_inference"),
                        "dram_read_GBps": r.get("dram_read_GBps"), "max_abs_diff": r["max_abs_diff_vs_baseline"]}
                       for r in th]).sort_values(["variant", "cores"]) if th else pd.DataFrame()
    base1 = None
    if len(tt):
        b = tt[(tt.variant == "baseline") & (tt.cores == 1)]
        base1 = float(b.median_ms.iloc[0]) if len(b) else None
        tt["speedup_vs_own_1core"] = tt.groupby("variant").median_ms.transform(lambda s: s.iloc[0] / s)
        tt["parallel_efficiency"] = tt.speedup_vs_own_1core / tt.cores
        if base1:
            tt["speedup_vs_baseline_1core"] = base1 / tt.median_ms
        tt["inferences_per_s"] = 1000 / tt.median_ms
        tt.round(3).to_csv(out / "processed" / "thread_scaling.csv", index=False)
        md += ["## Intra-op thread scaling (latency of one inference)", "", tt.round(3).to_markdown(index=False), ""]

    # -------------------------------------------------------------- instances
    inst = [json.loads(p.read_text()) for p in sorted((out / "raw").glob("instance_*.json"))]
    ti = pd.DataFrame()
    if inst:
        df = pd.DataFrame([{"variant": r["variant"], "N": int(r["tag"].split("_")[-2]) if "tag" in r else None,
                            "cpu": r["cpu"], "inferences": r["inferences"], "window_s": r["window_s"],
                            "median_ms": r["latency_ms"]["median"], "p95_ms": r["latency_ms"]["p95"]}
                           for r in inst])
        rows = []
        for (v, n), d in df.groupby(["variant", "N"]):
            rd, wr = imc_gbps(out / "raw" / f"imc_instances_{v}_{n}.csv", d.window_s.iloc[0] - 2)
            thr = float((d.inferences / d.window_s).sum())
            rows.append({"variant": v, "cores": n, "instances_reporting": len(d), "throughput_inf_per_s": thr,
                         "per_instance_median_ms": float(d.median_ms.median()),
                         "worst_instance_median_ms": float(d.median_ms.max()),
                         "per_instance_p95_ms": float(d.p95_ms.median()),
                         "dram_read_GBps": rd, "dram_write_GBps": wr,
                         "dram_read_MB_per_inf": rd * 1000 / thr if thr else np.nan})
        ti = pd.DataFrame(rows).sort_values(["variant", "cores"])
        ti["slowdown_vs_1_instance"] = ti.groupby("variant").per_instance_median_ms.transform(lambda s: s / s.iloc[0])
        ti["throughput_vs_1_instance"] = ti.groupby("variant").throughput_inf_per_s.transform(lambda s: s / s.iloc[0])
        ti.round(3).to_csv(out / "processed" / "instance_scaling.csv", index=False)
        md += ["## N independent single-thread instances (throughput)", "", ti.round(3).to_markdown(index=False), ""]
        # per-instance detail
        df.sort_values(["variant", "N", "cpu"]).round(3).to_csv(out / "processed" / "instance_detail.csv", index=False)

    # ------------------------------------------------------------------ plots
    variants = sorted(set(tt.variant if len(tt) else []) | set(ti.variant if len(ti) else []),
                      key=lambda v: (v != "baseline", v))
    color = {v: ps.CAT[i] for i, v in enumerate(variants)}
    if len(tt):
        fig, axes = plt.subplots(1, 2, figsize=(12, 4.6))
        ax = axes[0]
        for v in variants:
            d = tt[tt.variant == v]
            ax.plot(d.cores, d.median_ms, marker="o", color=color[v], label=v)
            for r in d.itertuples():
                ax.annotate(f"{r.median_ms:.1f}", (r.cores, r.median_ms), xytext=(3, 4), textcoords="offset points",
                            fontsize=7.5, color=ps.TEXT2)
        if base1:
            n = np.array(sorted(tt.cores.unique()))
            ax.plot(n, base1 / n, linestyle="--", color=ps.NEUTRAL, linewidth=1, label="baseline, perfect scaling")
        ax.set_xscale("log", base=2)
        ax.set_yscale("log")
        ax.set_xticks(sorted(tt.cores.unique()))
        ax.set_xticklabels([str(c) for c in sorted(tt.cores.unique())])
        ax.set_xlabel("cores (intra-op threads)")
        ax.set_ylabel("ms per inference (log)")
        ps.titled(ax, "Latency of one inference vs cores", "median of 60; batch 1")
        ax.legend(loc="lower left")
        ax = axes[1]
        for v in variants:
            d = tt[tt.variant == v]
            ax.plot(d.cores, d.parallel_efficiency * 100, marker="o", color=color[v], label=v)
        ax.set_xscale("log", base=2)
        ax.set_xticks(sorted(tt.cores.unique()))
        ax.set_xticklabels([str(c) for c in sorted(tt.cores.unique())])
        ax.set_ylim(0, 110)
        ax.set_xlabel("cores (intra-op threads)")
        ax.set_ylabel("parallel efficiency (%)")
        ps.titled(ax, "How much of each added core is used", "speedup over the same variant on 1 core / cores")
        fig.savefig(out / "plots" / "thread_scaling.png")
        plt.close(fig)
    if len(ti) or len(tt):
        fig, ax = plt.subplots(figsize=(7.5, 4.8))
        for v in variants:
            d = ti[ti.variant == v] if len(ti) else pd.DataFrame()
            if len(d):
                ax.plot(d.cores, d.throughput_inf_per_s, marker="o", color=color[v], label=f"{v}: N instances")
                for r in d.itertuples():
                    ax.annotate(f"{r.throughput_inf_per_s:.0f}", (r.cores, r.throughput_inf_per_s), xytext=(3, 4),
                                textcoords="offset points", fontsize=7.5, color=ps.TEXT2)
            d = tt[tt.variant == v] if len(tt) else pd.DataFrame()
            if len(d):
                ax.plot(d.cores, d.inferences_per_s, marker="s", linestyle=":", color=color[v],
                        label=f"{v}: 1 inference, N threads")
        ax.set_xlabel("cores used")
        ax.set_ylabel("inferences per second (whole machine)")
        ps.titled(ax, "Throughput: independent copies vs one threaded copy",
                  "solid = N single-thread instances, dotted = one instance with N threads")
        ax.legend(loc="upper left", fontsize=8)
        fig.savefig(out / "plots" / "throughput_scaling.png")
        plt.close(fig)
    (out / "processed" / "MULTICORE.md").write_text("\n".join(md))
    print("\n".join(md))


if __name__ == "__main__":
    main(sys.argv[1])
