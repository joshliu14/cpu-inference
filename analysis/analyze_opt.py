#!/usr/bin/env python3
"""Compare optimization variants against the baseline (opt_variants.py output,
plus optional thread-scaling e2e summaries in the same directory)."""
import json
import sys
from pathlib import Path

import numpy as np
import pandas as pd

sys.path.insert(0, str(Path(__file__).resolve().parent))
import plotstyle as ps  # noqa: E402
from matplotlib import pyplot as plt  # noqa: E402

ORDER = ["conv1x1", "conv3x3", "conv7x7", "batchnorm", "relu", "add", "maxpool", "other"]


def main(out_dir):
    out = Path(out_dir)
    (out / "plots").mkdir(exist_ok=True)
    s = json.loads((out / "processed" / "opt_summary.json").read_text())["variants"]
    base = s["baseline"]["latency_ms"]["median"]
    rows = []
    s = {k: v for k, v in s.items() if "error" not in v}
    for name, v in s.items():
        L = v["latency_ms"]
        rows.append({"variant": name, "median_ms": L["median"], "p5_ms": L["p5"], "p95_ms": L["p95"],
                     "stddev_ms": L["stddev"], "speedup_vs_baseline": base / L["median"],
                     "saved_ms": base - L["median"], "ipc": v["ipc"],
                     "instructions_M": v["instructions_median"] / 1e6, "cycles_M": v["cycles_median"] / 1e6,
                     "max_abs_diff": v["max_abs_diff_vs_baseline"],
                     "build_s": v.get("build_and_warmup_s", float("nan"))})
    tab = pd.DataFrame(rows)
    tab.round(4).to_csv(out / "processed" / "opt_comparison.csv", index=False)

    # Per-op-type breakdown table
    bd = {}
    for name, v in s.items():
        d = v["per_op_type_ms"]
        if "error" in d or not d:
            continue
        g = {}
        for k, ms in d.items():
            key = k if k in ORDER else ("other" if k not in ("identity", "flatten") else None)
            if key is None:
                continue
            g[key] = g.get(key, 0) + ms
        bd[name] = g
    bdf = pd.DataFrame(bd).T.reindex(columns=[c for c in ORDER if any(c in g for g in bd.values())]).fillna(0)
    bdf.round(3).to_csv(out / "processed" / "opt_breakdown_ms.csv")

    fig, ax = plt.subplots(figsize=(9, 0.6 * len(bdf) + 1.8))
    y = np.arange(len(bdf))[::-1]
    left = np.zeros(len(bdf))
    for i, c in enumerate(bdf.columns):
        ax.barh(y, bdf[c].values, left=left, color=ps.CAT[ORDER.index(c)], label=c, height=0.62,
                edgecolor=ps.SURFACE, linewidth=1)
        left += bdf[c].values
    for yi, name in zip(y, bdf.index):
        med = s[name]["latency_ms"]["median"]
        ax.text(left[list(bdf.index).index(name)] + 0.8, yi, f"{med:.1f} ms end-to-end", va="center",
                fontsize=8, color=ps.TEXT2)
    ax.set_yticks(y)
    ax.set_yticklabels(bdf.index)
    ax.set_xlabel("milliseconds (sum of per-operator medians)")
    ax.set_xlim(0, left.max() * 1.25)
    ps.titled(ax, "What each optimization removes",
              "Per-operator-type time inside the model; label = measured end-to-end median")
    ax.legend(ncol=4, loc="upper center", bbox_to_anchor=(0.5, -0.15))
    fig.savefig(out / "plots" / "opt_breakdown.png")
    plt.close(fig)

    md = ["# Optimization experiments", "", "Baseline = canonical explicit model. Speedup = baseline median / "
          "variant median (same process, same CPU, interleaved order). max_abs_diff = largest output "
          "difference vs baseline (numerical equivalence check).", "",
          tab.round(3).assign(max_abs_diff=tab.max_abs_diff.map(lambda v: f"{v:.1e}")).to_markdown(index=False),
          "", "## Per-operator-type time (ms, in-model hooks)", "", bdf.round(2).to_markdown(), ""]

    th = sorted(out.glob("processed/e2e_summary_threads_*.json"), key=lambda p: int(p.stem.split("_")[-1]))
    if th:
        trows = []
        for p in th:
            d = json.loads(p.read_text())
            n = int(p.stem.split("_")[-1])
            trows.append({"threads": n, "median_ms": d["latency_ms"]["median"], "p95_ms": d["latency_ms"]["p95"]})
        tt = pd.DataFrame(trows)
        t1 = tt[tt.threads == 1].median_ms.iloc[0]
        tt["speedup"] = t1 / tt.median_ms
        tt["parallel_efficiency"] = tt.speedup / tt.threads
        tt.round(3).to_csv(out / "processed" / "thread_scaling.csv", index=False)
        md += ["## Thread scaling (not part of the single-core baseline)", "", tt.round(3).to_markdown(index=False), ""]
        fig, ax = plt.subplots(figsize=(6.5, 4.2))
        ax.plot(tt.threads, tt.speedup, marker="o", color=ps.CAT[0], label="measured")
        ax.plot(tt.threads, tt.threads, linestyle="--", color=ps.NEUTRAL, linewidth=1, label="ideal (linear)")
        for r in tt.itertuples():
            ax.annotate(f"{r.median_ms:.1f} ms", (r.threads, r.speedup), xytext=(4, -10),
                        textcoords="offset points", fontsize=7.5, color=ps.TEXT2)
        ax.set_xlabel("intra-op threads (one per core)")
        ax.set_ylabel("speedup vs 1 thread")
        ps.titled(ax, "Thread scaling of batch-1 inference", "oneDNN/MKL/ATen OpenMP threads; median latency")
        ax.legend(loc="upper left")
        fig.savefig(out / "plots" / "thread_scaling.png")
        plt.close(fig)
    (out / "processed" / "OPTIMIZATIONS.md").write_text("\n".join(md))
    print("\n".join(md))


if __name__ == "__main__":
    main(sys.argv[1])
