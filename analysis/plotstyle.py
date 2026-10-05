"""Shared matplotlib style for every plot in the project.

Categorical colors are assigned in a fixed order (never cycled) from a
validated palette (CVD-separated adjacent pairs; checked with the dataviz
validator). Three slots are below 3:1 contrast on the light surface, so every
plot carries a legend or direct labels and every plot has a CSV table next to
it in processed/.
"""
import matplotlib

matplotlib.use("Agg")
import matplotlib.pyplot as plt  # noqa: E402

SURFACE = "#fcfcfb"
TEXT = "#0b0b0b"
TEXT2 = "#52514e"
GRID = "#e4e3df"
CAT = ["#2a78d6", "#eb6834", "#1baf7a", "#eda100", "#e87ba4", "#008300", "#4a3aa7", "#e34948"]
SEQ = ["#cde2fb", "#9ec5f4", "#6da7ec", "#3987e5", "#256abf", "#184f95", "#0d366b"]
NEUTRAL = "#a3a29c"

plt.rcParams.update({
    "figure.facecolor": SURFACE, "axes.facecolor": SURFACE, "savefig.facecolor": SURFACE,
    "axes.edgecolor": GRID, "axes.labelcolor": TEXT2, "axes.titlecolor": TEXT,
    "axes.titlesize": 12, "axes.titleweight": "bold", "axes.titlelocation": "left",
    "axes.labelsize": 10, "axes.grid": True, "grid.color": GRID, "grid.linewidth": 0.6,
    "axes.spines.top": False, "axes.spines.right": False, "axes.axisbelow": True,
    "xtick.color": TEXT2, "ytick.color": TEXT2, "xtick.labelsize": 9, "ytick.labelsize": 9,
    "legend.frameon": False, "legend.fontsize": 9, "lines.linewidth": 2, "lines.markersize": 5,
    "font.size": 10, "figure.dpi": 110, "savefig.dpi": 150, "savefig.bbox": "tight",
})


def fmt_bytes(x, _pos=None):
    for unit, div in (("GiB", 1 << 30), ("MiB", 1 << 20), ("KiB", 1 << 10)):
        if x >= div:
            v = x / div
            return f"{v:.0f} {unit}" if v >= 10 or v == int(v) else f"{v:.1f} {unit}"
    return f"{x:.0f} B"


def cache_lines(ax, sizes: dict, ymax_frac=0.97):
    """Dashed verticals at nominal cache capacities (labelled; recessive ink)."""
    for label, size in sizes.items():
        ax.axvline(size, color=NEUTRAL, linestyle="--", linewidth=0.9, zorder=1)
        ax.text(size, ymax_frac, f" {label}", transform=ax.get_xaxis_transform(), color=TEXT2,
                fontsize=8, va="top", ha="left")


def titled(ax, title, sub=None):
    """Title states the research question/answer; the subtitle states the setup."""
    ax.set_title(title, pad=20 if sub else 6)
    if sub:
        ax.text(0, 1.015, sub, transform=ax.transAxes, fontsize=8.5, color=TEXT2, va="bottom")
