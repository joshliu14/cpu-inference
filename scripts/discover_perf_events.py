#!/usr/bin/env python3
"""Discover which performance events actually work on this machine.

For every catalog entry (cpuinf/events.py) each candidate name is:
  1. looked up (generic / sysfs / perf JSON table) to find its encoding,
  2. test-counted with `perf stat` on a small workload (the official tool),
  3. test-opened in-process with perf_event_open (the path our scripts use).
The first candidate that passes is recorded. Anything that fails is written as
supported=false with value "UNAVAILABLE" -- never silently turned into 0.

Output: results/perf_events.json (+ a Markdown table next to it).
"""
import json
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from cpuinf.events import CATALOG, PASSES  # noqa: E402
from cpuinf.perfcounters import CounterSession, UncoreCounters, resolve  # noqa: E402

WORKLOAD = ["python3", "-c", "s=0\nfor i in range(2_000_000): s+=i*i"]


def needs_slots_group(name: str) -> bool:
    # The kernel only accepts top-down metric events inside a group led by slots.
    return name.startswith("topdown-")


def perf_stat_test(name: str, uncore: bool) -> tuple[bool, str]:
    spec = "{slots,%s}" % name if needs_slots_group(name) else name
    cmd = ["perf", "stat", "-x,", "-e", spec]
    cmd += ["-a", "--", "sleep", "0.2"] if uncore else ["--"] + WORKLOAD
    r = subprocess.run(cmd, capture_output=True, text=True)
    for line in r.stderr.splitlines():
        fields = line.split(",")
        if len(fields) >= 3 and (name.strip("/").split("/")[-1] in fields[2] or name in fields[2]):
            val = fields[0]
            if val.startswith("<"):
                return False, val
            return True, val
    return False, (r.stderr.strip().splitlines() or ["no output"])[-1][:200]


def inprocess_test(name: str, uncore: bool) -> tuple[bool, str]:
    try:
        if uncore:
            u = UncoreCounters(name)
            v = u.read_raw()
            u.close()
            return True, f"{len(u.fds)} instances, raw={v}"
        names = ["slots", name] if needs_slots_group(name) else [name]
        with CounterSession(names) as s:
            s.start()
            sum(i * i for i in range(200_000))
            r = s.stop()
        return True, str(r.get(name, "?"))
    except Exception as e:  # noqa: BLE001 - we want the reason recorded
        return False, f"{type(e).__name__}: {e}"


def main():
    out = []
    for ev in CATALOG:
        rec = {
            "key": ev.key, "event": None, "supported": False, "candidates_tried": [],
            "source": None, "encoding": None, "category": ev.category, "scope": ev.scope,
            "description": ev.description, "interpretation": ev.interpretation,
        }
        for cand in ev.candidates:
            attempt = {"name": cand}
            if not ev.uncore:
                try:
                    enc = resolve(cand)
                    attempt["encoding"] = (f"type={enc.type} config={enc.config:#x} "
                                           f"config1={enc.config1:#x}")
                    attempt["source"] = enc.source
                except KeyError as e:
                    attempt["lookup_error"] = str(e)
                    rec["candidates_tried"].append(attempt)
                    continue
            else:
                attempt["source"] = "kernel sysfs uncore PMU events"
            ok1, why1 = perf_stat_test(cand, ev.uncore)
            ok2, why2 = inprocess_test(cand, ev.uncore)
            attempt.update({"perf_stat_ok": ok1, "perf_stat_value": why1,
                            "inprocess_ok": ok2, "inprocess_value": why2})
            rec["candidates_tried"].append(attempt)
            if ok1 and ok2:
                rec.update({"event": cand, "supported": True, "source": attempt["source"],
                            "encoding": attempt.get("encoding")})
                break
        if not rec["supported"]:
            rec["event"] = "UNAVAILABLE"
        out.append(rec)
        print(f"{ev.key:24s} {'OK ' if rec['supported'] else 'UNAVAILABLE'} {rec['event']}")

    # Derived-metric support: perf's own metric tables vs. our computation.
    r = subprocess.run(["perf", "stat", "-M", "TopdownL1", "--", "true"], capture_output=True, text=True)
    perf_metrics = "available" if r.returncode == 0 else "UNAVAILABLE (" + r.stderr.strip().splitlines()[-1] + ")"
    doc = {
        "generated_by": "scripts/discover_perf_events.py",
        "perf_builtin_tma_metrics": perf_metrics,
        "tma_strategy": ("perf has no metric definitions for this CPU model, but the kernel exports "
                         "the hardware top-down events (slots + topdown-*). Level-1 and Level-2 "
                         "fractions are computed by cpuinf/metrics.py as event/slots."),
        "passes": PASSES,
        "events": out,
    }
    dst = ROOT / "results" / "perf_events.json"
    dst.write_text(json.dumps(doc, indent=2) + "\n")

    md = ["# Performance events on this machine", "",
          "Generated by `scripts/discover_perf_events.py`. `UNAVAILABLE` means no candidate "
          "event could be counted both by `perf stat` and in-process.", "",
          f"perf built-in TMA metrics: {perf_metrics}", "",
          "| key | event | supported | scope | interpretation |", "|---|---|---|---|---|"]
    for e in out:
        md.append(f"| {e['key']} | `{e['event']}` | {'yes' if e['supported'] else '**no**'} | "
                  f"{e['scope'].split(' (')[0]} | {e['interpretation'] or e['description']} |")
    (ROOT / "results" / "perf_events.md").write_text("\n".join(md) + "\n")
    print(f"wrote {dst}")


if __name__ == "__main__":
    main()
