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
        ax.text(4e6, y * 0.72, lab, fontsize=8, color=ps.TEXT2, ha="right", va="top")
    # Where ResNet-50's real activation tensors lie (elementwise inputs: 1x2048x7x7 .. 1x64x112x112).
    ax.axvspan(2048 * 49, 64 * 112 * 112, color=ps.GRID, alpha=0.6, zorder=0)
    ax.text((2048 * 49 * 64 * 112 * 112) ** 0.5, 0.18, "ResNet-50\ntensor sizes", fontsize=8, color=ps.TEXT2,
            ha="center", va="bottom")
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
    # A negative intercept means the per-element cost is not constant over the
    # fitted sizes (e.g. NCHW max-pool boundary handling): the fit is invalid.
    tab["fit_valid"] = tab.fixed_cycles > 0
    tab.round(3).to_csv(out / "processed" / "dispatch_summary.csv")

    # Direct measurement: cost of the smallest call of each callable (almost all overhead).
    small = df.sort_values("N").groupby("callable").first()
    small = small.assign(us=small.ns_per_call / 1e3)[["N", "us", "cycles_per_call", "instructions_per_call"]]
    small.round(2).to_csv(out / "processed" / "dispatch_smallest_call.csv")
    # CALCULATED: fixed overhead per ResNet-50 inference = calls per inference x
    # smallest-call cost of the matching module (a lower bound for the conv
    # paths: real layers also create/look up larger oneDNN primitives).
    calls = {"conv1x1 64->64": 33, "conv3x3 64->64": 20, "nn.BatchNorm2d(64)": 53, "nn.ReLU module": 49,
             "module_identity": 16 + 3, "add_ inplace": 16, "nn.MaxPool2d(3,2,1)": 1}
    est = pd.DataFrame([{"operator (module used as proxy)": k, "calls_per_inference": n,
                         "us_per_call": float(small.loc[k, "us"]), "us_per_inference": n * float(small.loc[k, "us"])}
                        for k, n in calls.items() if k in small.index])
    est.round(2).to_csv(out / "processed" / "dispatch_per_inference_estimate.csv", index=False)
    total_us = est.us_per_inference.sum()
    md = ["# Dispatch overhead", "", "Linear fit cycles(N) = fixed + per_element x N over N <= 64K elements "
          "(L2-resident). 'fixed' is an ESTIMATE of size-independent software cost.", "",
          f"Empty Python call: {noop * 1e3:.0f} ns; nn.Identity module call: {ident * 1e3:.0f} ns.", "",
          tab.round(3).to_markdown(), "",
          "## Smallest call of each callable (OBSERVED; almost entirely fixed cost)", "",
          small.round(2).to_markdown(), "",
          "## Fixed software cost per ResNet-50 inference (CALCULATED estimate)", "",
          "calls per inference x smallest-call cost. conv3x3 row also stands for conv7x7 and the 3 strided "
          "1x1 convs (oneDNN path); 'module_identity' stands for the 16 residual Add modules' wrapper plus "
          "avgpool/flatten/fc module calls. Conv rows are lower bounds.", "",
          est.round(2).to_markdown(index=False), "",
          f"**Total: {total_us / 1e3:.2f} ms per inference = {100 * total_us / 1e3 / 98.57:.1f}% of the "
          f"98.57 ms baseline.**", ""]
    (out / "processed" / "DISPATCH.md").write_text("\n".join(md))
    print("\n".join(md))


if __name__ == "__main__":
    main(sys.argv[1])
