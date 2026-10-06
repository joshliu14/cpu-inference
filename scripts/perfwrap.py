#!/usr/bin/env python3
"""Reusable `perf stat` wrapper for whole commands.

Runs a command under perf stat once per measurement pass (see
cpuinf/events.PASSES), each pass with --repeat N, pinned to one CPU, and
writes raw perf CSV plus a JSON summary with derived metrics.

    scripts/perfwrap.py --cpu 6 --repeat 5 --passes core,topdown,flops \
        --out results/<dir>/raw -- ./microbench/bin/compute fma512

Events are taken from results/perf_events.json; unsupported ones are skipped
and reported as UNAVAILABLE. Each pass is its own perf group set, so no pass
should need multiplexing; the 'pct running' column from perf is kept so that
any multiplexing is visible.
"""
import argparse
import json
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from cpuinf.events import PASSES  # noqa: E402
from cpuinf.metrics import derive  # noqa: E402


def load_supported() -> dict:
    doc = json.loads((ROOT / "results" / "perf_events.json").read_text())
    return {e["key"]: e["event"] for e in doc["events"] if e["supported"]}


def event_spec(keys, supported):
    names = [supported[k] for k in keys if k in supported]
    td = [n for n in names if n == "slots" or n.startswith("topdown-")]
    rest = [n for n in names if n not in td]
    parts = []
    if td:
        parts.append("{" + ",".join(["slots"] + [n for n in td if n != "slots"]) + "}")
    if rest:
        parts.append("{" + ",".join(rest) + "}")
    sw = {"task-clock", "page-faults", "context-switches", "cpu-migrations"}
    if rest and all(n in sw for n in rest):  # software events cannot be a hw group
        parts = [p for p in parts if not p.startswith("{" + rest[0])] + [",".join(rest)]
    return ",".join(parts), [k for k in keys if k not in supported]


def run_pass(name, keys, cmd, cpu, repeat, out_dir, supported):
    """One logical pass; split into verified schedulable sub-runs if needed."""
    from cpuinf.perfcounters import plan_groups
    rev = {v: k for k, v in supported.items()}
    names = [supported[k] for k in keys if k in supported]
    runs = plan_groups(names, anchor=())
    if len(runs) == 1:
        return run_one(name, keys, cmd, cpu, repeat, out_dir, supported)
    vals, info, rc = {}, {}, 0
    for i, r in enumerate(runs):
        v, inf, c = run_one(f"{name}.{i}", [rev[n] for n in r], cmd, cpu, repeat, out_dir, supported)
        vals.update(v)
        info.update(inf)
        rc = rc or c
    for k in keys:
        if k not in supported:
            info[k] = "UNAVAILABLE"
    return vals, info, rc


def run_one(name, keys, cmd, cpu, repeat, out_dir, supported):
    spec, missing = event_spec(keys, supported)
    csv = out_dir / f"perfstat_{name}.csv"
    full = ["perf", "stat", "-x,", "-o", str(csv), "-r", str(repeat), "-e", spec, "--",
            "taskset", "-c", str(cpu)] + cmd
    r = subprocess.run(full, capture_output=True, text=True)
    (out_dir / f"stdout_{name}.txt").write_text(r.stdout + r.stderr)
    rev = {v: k for k, v in supported.items()}
    vals, info = {}, {}
    for line in csv.read_text().splitlines():
        f = line.split(",")
        if len(f) < 4 or line.startswith("#"):
            continue
        ev = f[2].replace("cpu/", "").rstrip("/") if f[2].startswith("cpu/") else f[2]
        key = rev.get(ev) or rev.get(f[2])
        if key is None:
            continue
        if f[0].startswith("<"):
            vals[key] = None
            info[key] = f[0]
        else:
            vals[key] = float(f[0])
            info[key] = {"stddev_pct": f[3].rstrip("%") if f[3] else None,
                         "pct_running": f[5] if len(f) > 5 else None}
    for k in missing:
        info[k] = "UNAVAILABLE"
    return vals, info, r.returncode


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--cpu", type=int, default=6)
    ap.add_argument("--repeat", type=int, default=5)
    ap.add_argument("--passes", default="core,sw,topdown")
    ap.add_argument("--out", required=True)
    ap.add_argument("cmd", nargs=argparse.REMAINDER)
    a = ap.parse_args()
    cmd = a.cmd[1:] if a.cmd and a.cmd[0] == "--" else a.cmd
    out = Path(a.out)
    out.mkdir(parents=True, exist_ok=True)
    supported = load_supported()
    allvals, allinfo = {}, {}
    for p in a.passes.split(","):
        vals, info, rc = run_pass(p, PASSES[p], cmd, a.cpu, a.repeat, out, supported)
        if rc != 0:
            print(f"pass {p}: command exited {rc}; see {out}/stdout_{p}.txt", file=sys.stderr)
        for k, v in vals.items():
            allvals.setdefault(k, v)          # first pass that measured it wins
        allinfo[p] = info
    summary = {"command": cmd, "cpu": a.cpu, "repeat": a.repeat, "counts_mean": allvals,
               "derived": derive(allvals), "per_pass_info": allinfo}
    (out / "perf_summary.json").write_text(json.dumps(summary, indent=2) + "\n")
    d = summary["derived"]
    print(json.dumps({k: v for k, v in d.items() if v is not None}, indent=1))


if __name__ == "__main__":
    main()
