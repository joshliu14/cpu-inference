#!/usr/bin/env python3
"""Plot per-call cost vs problem size for the dispatch-overhead experiment."""
import sys
from pathlib import Path

import pandas as pd

sys.path.insert(0, str(Path(__file__).resolve().parent))
import plotstyle as ps  # noqa: E402
from matplotlib import pyplot as plt  # noqa: E402
from matplotlib.ticker import FuncFormatter  # noqa: E402


def main(out_dir):
    out = Path(out_dir)
    df = pd.read_csv(out / "raw" / "dispatch_overhead.csv")
    fits = pd.read_csv(out / "processed" / "dispatch_fits.csv")
    (out / "plots").mkdir(exist_ok=True)
    show = ["torch.relu", "torch.add", "nn.BatchNorm2d(64)", "conv1x1 64->64", "conv3x3 64->64",
            "nn.MaxPool2d(3,2,1)", "F.max_pool2d chlast"]
    fig, ax = plt.subplots(figsize=(8.5, 5))
    for i, name in enumerate(show):
        d = df[df["callable"] == name].sort_values("N")
        if len(d):
            ax.plot(d.N, d.ns_per_call / 1e3, marker="o", markersize=3.5, color=ps.CAT[i], label=name)
    noop = df[df["callable"] == "python_noop"].ns_per_call.median() / 1e3
    ident = df[df["callable"] == "module_identity"].ns_per_call.median() / 1e3
    for y, lab in ((noop, "empty Python call"), (ident, "nn.Identity module call")):
        ax.axhline(y, color=ps.NEUTRAL, linestyle="--", linewidth=0.9)
        ax.text(1.2, y * 1.08, lab, fontsize=8, color=ps.TEXT2)
    ax.set_xscale("log")
    ax.set_yscale("log")
    ax.yaxis.set_major_formatter(FuncFormatter(lambda y, _: f"{y:g}"))
    ax.set_xlabel("elements in the input tensor (log)")
    ax.set_ylabel("microseconds per call (log)")
    ps.titled(ax, "Fixed cost per call dominates small operators",
              "Flat left part = size-independent software overhead; rising right part = real work")
    ax.legend(loc="upper left", ncol=2)
    fig.savefig(out / "plots" / "dispatch_overhead.png")
    plt.close(fig)
    cyc = fits[fits.metric == "cycles_per_call"].set_index("callable")
    ins = fits[fits.metric == "instructions_per_call"].set_index("callable")
    tab = pd.DataFrame({"fixed_cycles": cyc.fixed_intercept, "fixed_us": cyc.fixed_intercept / 2100,
                        "cycles_per_element": cyc.per_element, "fixed_instructions": ins.fixed_intercept})
    tab.round(3).to_csv(out / "processed" / "dispatch_summary.csv")
    md = ["# Dispatch overhead", "", "Linear fit cycles(N) = fixed + per_element x N over N <= 64K elements "
          "(L2-resident). 'fixed' is an ESTIMATE of size-independent software cost.", "",
          f"Empty Python call: {noop * 1e3:.0f} ns; nn.Identity module call: {ident * 1e3:.0f} ns.", "",
          tab.round(3).to_markdown(), ""]
    (out / "processed" / "DISPATCH.md").write_text("\n".join(md))
    print("\n".join(md))


if __name__ == "__main__":
    main(sys.argv[1])
