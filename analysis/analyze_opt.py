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


def onednn_split(path):
    """oneDNN verbose exec lines -> {class: [calls, ms, MB]}; reorders are split
    into weights (shape OxIxKxK, first dim > 1) and activations (1xCxHxW)."""
    agg = {}
    for line in path.read_text(errors="replace").splitlines():
        p = line.strip().split(",")
        if len(p) < 6 or p[3] != "exec":
            continue
        kind, shape, ms = p[5], p[-2], float(p[-1])
        mb = 0.0
        if kind == "reorder":
            dims = [int(d) for d in shape.split("x") if d.isdigit()]
            kind = "reorder_activation" if dims and dims[0] == 1 else "reorder_weight"
            mb = float(np.prod(dims)) * 4 / 1e6 if dims else 0.0
        a = agg.setdefault(kind, [0, 0.0, 0.0])
        a[0] += 1
        a[1] += ms
        a[2] += mb
    return agg


def mechanisms_md(out):
    """Tables from opt_mechanisms.py output (maxpool counters, oneDNN census)."""
    md = []
    mj = out / "processed" / "mechanisms.json"
    if mj.exists():
        m = json.loads(mj.read_text())
        mp = pd.DataFrame(m["maxpool"]["per_callable"]).T
        cols = ["us_per_call", "cycles_per_output", "instructions_per_output", "ipc", "branches_per_output",
                "branch_misses_per_output", "loads_per_output", "stores_per_output", "fp_256b_per_output",
                "fp_512b_per_output"]
        mp[cols].round(3).to_csv(out / "processed" / "maxpool_mechanism.csv")
        md += ["## Mechanism check A: max-pool kernel counters", "",
               f"Input {m['maxpool']['input_shape']} -> {m['maxpool']['outputs']} outputs; per-call medians of "
               "in-process counters, normalised per pooled output. Results identical to NCHW: "
               f"{m.get('maxpool_equal')}.", "", mp[cols].round(3).to_markdown(), ""]
    rows = []
    for f in sorted((out / "raw").glob("onednn_verbose_*.txt")):
        v = f.stem.replace("onednn_verbose_", "")
        a = onednn_split(f)
        r = {"variant": v}
        for k in ("convolution", "reorder_weight", "reorder_activation"):
            n, ms, mb = a.get(k, [0, 0.0, 0.0])
            r[f"{k}_calls"] = n
            r[f"{k}_ms"] = ms
            if k.startswith("reorder"):
                r[f"{k}_MB"] = mb
        r["other_onednn_ms"] = sum(x[1] for k, x in a.items()
                                   if k not in ("convolution", "reorder_weight", "reorder_activation"))
        rows.append(r)
    if rows:
        od = pd.DataFrame(rows)
        od.round(3).to_csv(out / "processed" / "onednn_reorder_split.csv", index=False)
        md += ["## Mechanism check B: oneDNN primitives per inference", "",
               "From ONEDNN verbose of one inference (exec times as reported by oneDNN). Weight reorders = "
               "conv weights converted to oneDNN's blocked layout on every call; activation reorders = "
               "NCHW <-> blocked conversions of activations. MKL SGEMM (unstrided 1x1 convs in eager NCHW) "
               "does not appear here.", "", od.round(2).to_markdown(index=False), ""]
    ac = out / "processed" / "aten_census.csv"
    if ac.exists():
        a = pd.read_csv(ac)
        keep = ["aten::mkldnn_convolution", "aten::_slow_conv2d_forward", "aten::native_batch_norm",
                "aten::max_pool2d_with_indices", "aten::add_", "aten::clamp_min_", "aten::relu_",
                "aten::copy_", "aten::addmm", "mkldnn::_convolution_pointwise", "mkldnn::_convolution_pointwise_"]
        t = a[a.op.isin(keep)].pivot_table(index="variant", columns="op", values="calls", aggfunc="sum").fillna(0)
        md += ["## Mechanism check C: ATen operators dispatched per inference (calls)", "",
               t.astype(int).to_markdown(), ""]
    return md


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

    # Headline chart: end-to-end latency of every variant vs the compute floor.
    FLOOR_MS = 8.2174e9 / 63.86 / 2.1e9 * 1e3      # CALCULATED: FLOPs / measured peak FLOP/cycle / 2.1 GHz
    t2 = tab.sort_values("median_ms", ascending=True)
    fig, ax = plt.subplots(figsize=(9, 0.5 * len(t2) + 1.8))
    y = np.arange(len(t2))[::-1]
    cols = [ps.NEUTRAL if v == "baseline" else ps.CAT[0] for v in t2.variant]
    ax.barh(y, t2.median_ms, color=cols, height=0.62)
    ax.errorbar(t2.median_ms, y, xerr=[t2.median_ms - t2.p5_ms, t2.p95_ms - t2.median_ms], fmt="none",
                ecolor=ps.TEXT2, elinewidth=0.8, capsize=2)
    for yi, r in zip(y, t2.itertuples()):
        ax.text(r.p95_ms + 1, yi, f"{r.median_ms:.1f} ms  ({r.speedup_vs_baseline:.2f}x)", va="center",
                fontsize=8.5, color=ps.TEXT2)
    ax.axvline(FLOOR_MS, color=ps.CAT[7], linestyle="--", linewidth=1)
    ax.set_ylim(-0.6, len(t2) + 0.5)
    ax.text(FLOOR_MS - 1, len(t2) - 0.1, f"compute floor {FLOOR_MS:.1f} ms (8.22 GFLOP at measured FMA peak)",
            fontsize=8, color=ps.CAT[7], va="center", ha="right")
    ax.set_yticks(y)
    ax.set_yticklabels(t2.variant)
    ax.set_xlim(0, t2.p95_ms.max() * 1.3)
    ax.set_xlabel("ms per inference (median; whiskers p5-p95), one core")
    ps.titled(ax, "Single-core latency of each optimization",
              "same process, variants timed in interleaved blocks; grey = unmodified baseline")
    fig.savefig(out / "plots" / "opt_latency.png")
    plt.close(fig)

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
              "Per-operator-type time inside the model (eager variants only; compiled graphs have no "
              "module hooks); label = end-to-end median")
    ax.legend(ncol=4, loc="upper center", bbox_to_anchor=(0.5, -0.15))
    fig.savefig(out / "plots" / "opt_breakdown.png")
    plt.close(fig)

    md = ["# Optimization experiments", "", "Baseline = canonical explicit model. Speedup = baseline median / "
          "variant median (same process, same CPU, interleaved order). max_abs_diff = largest output "
          "difference vs baseline (numerical equivalence check).", "",
          tab.round(3).assign(max_abs_diff=tab.max_abs_diff.map(lambda v: f"{v:.1e}")).to_markdown(index=False),
          "", "## Per-operator-type time (ms, in-model hooks)", "", bdf.round(2).to_markdown(), ""]

    md += mechanisms_md(out)
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
