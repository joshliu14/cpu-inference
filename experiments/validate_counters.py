#!/usr/bin/env python3
"""Validate PMU counters against microbenchmarks with KNOWN answers.

Before using a counter to explain ResNet-50 we check that it reports what we
think it reports, on kernels where the correct value is known by
construction. Each case runs one native microbenchmark configuration with
extra events counted only around its timed region (PERF_EXTRA, see
microbench/src/common.h) and compares counter / expected.

Cases (expected values follow from how the kernels are built):
  fma512        each vfmadd231ps zmm = 2 FP_ARITH counts (FMA counts twice)
  chase_<lvl>   one dependent load per step; working set chosen to live in
                L1 / L2 / L3 / DRAM, so (almost) every load should hit that level
  stream_*      sequential reads/writes over 512 MiB: bytes requested vs line
                fills, DRAM CAS bytes (uncore), and how many demand loads miss
                (prefetchers should make demand misses rare)
  tlb_*         1 GiB random chase with 4 KiB vs 2 MiB pages: page walks

usage: validate_counters.py --cpu 6 --out DIR
"""
import argparse
import csv
import io
import json
import os
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from cpuinf.perfcounters import PMU_ROOT, _pack, resolve  # noqa: E402

ap = argparse.ArgumentParser()
ap.add_argument("--cpu", type=int, default=6)
ap.add_argument("--out", required=True)
args = ap.parse_args()
BIN = ROOT / "microbench" / "bin"
out = Path(args.out)
(out / "raw").mkdir(parents=True, exist_ok=True)
(out / "processed").mkdir(parents=True, exist_ok=True)


def extra_spec(events):
    parts = []
    for e in events:
        if e.startswith("uncore_imc/"):
            ev = e.split("/")[1]
            for d in sorted(PMU_ROOT.glob("uncore_imc_[0-9]*")):
                f = d / "events" / ev
                if f.exists():
                    c, c1, _ = _pack(d.name, f.read_text().strip())
                    cpu = int((d / "cpumask").read_text().split(",")[0].split("-")[0])
                    parts.append(f"{e},{int((d / 'type').read_text())},{c:x},{c1:x},{cpu}")
        else:
            enc = resolve(e)
            parts.append(f"{e},{enc.type},{enc.config:x},{enc.config1:x},-1")
    return ";".join(parts)


def run(binary, argv, env, events):
    e = dict(os.environ, **{k: str(v) for k, v in env.items()}, PERF_EXTRA=extra_spec(events))
    r = subprocess.run(["taskset", "-c", str(args.cpu), str(BIN / binary)] + argv, env=e,
                       capture_output=True, text=True)
    rows = list(csv.DictReader(io.StringIO(r.stdout)))
    for row in rows:
        row["extra_d"] = {kv.split("=")[0]: int(kv.split("=")[1]) for kv in row["extra"].split("|") if kv}
    return rows, r.stderr


CASES = []


def case(name, binary, argv, env, events, expect, note):
    CASES.append(dict(name=name, binary=binary, argv=argv, env=env, events=events, expect=expect, note=note))


L1, L2, L3, DRAM = 16, 1024, 16384, 1048576  # KiB; chosen inside each level (see machine_model)
for lvl, kb in (("L1", L1), ("L2", L2), ("L3", L3), ("DRAM", DRAM)):
    case(f"chase_{lvl}", "memlat", ["random"], dict(THP=1, MIN_KB=kb, MAX_KB=kb, REPS=3, MAX_STEPS=4000000),
         ["mem_load_retired.l1_hit", "mem_load_retired.l2_hit", "mem_load_retired.l3_hit",
          "mem_load_retired.l3_miss"],
         {"loads": "steps"}, f"random pointer chase, {kb} KiB, 2 MiB pages: one dependent load per step")
case("chase_DRAM_dram_attribution", "memlat", ["random"],
     dict(THP=1, MIN_KB=DRAM, MAX_KB=DRAM, REPS=3, MAX_STEPS=4000000),
     ["ocr.demand_data_rd.dram", "offcore_requests.demand_data_rd", "uncore_imc/cas_count_read/",
      "uncore_imc/cas_count_write/"],
     {}, "each step should be one demand read served by DRAM = one 64 B CAS read")
case("tlb_4k", "memlat", ["random"], dict(THP=0, MIN_KB=DRAM, MAX_KB=DRAM, REPS=3, MAX_STEPS=4000000),
     ["dtlb_load_misses.walk_completed", "dtlb_load_misses.stlb_hit"], {}, "1 GiB chase, 4 KiB pages")
case("tlb_2m", "memlat", ["random"], dict(THP=1, MIN_KB=DRAM, MAX_KB=DRAM, REPS=3, MAX_STEPS=4000000),
     ["dtlb_load_misses.walk_completed", "dtlb_load_misses.stlb_hit"], {}, "1 GiB chase, 2 MiB pages")
STREAM = dict(MIN_KB=524288, MAX_KB=524288, REPS=3, MIN_BYTES_PER_REP=1)
case("stream_read", "membw", ["read"], STREAM,
     ["l2_lines_in.all", "uncore_imc/cas_count_read/", "uncore_imc/cas_count_write/", "mem_load_retired.l3_miss"],
     {}, "sequential 512 MiB read, 64 B zmm loads")
case("stream_read_sources", "membw", ["read"], STREAM,
     ["mem_inst_retired.all_loads", "mem_load_retired.l1_hit", "mem_load_retired.fb_hit",
      "mem_load_retired.l2_hit"], {}, "where do demand loads of a stream get their data?")
case("stream_write", "membw", ["write"], STREAM,
     ["uncore_imc/cas_count_read/", "uncore_imc/cas_count_write/", "l2_lines_out.non_silent"],
     {}, "regular stores: expect DRAM reads (read-for-ownership) as well as writes")
case("stream_write_nt", "membw", ["write_nt"], STREAM,
     ["uncore_imc/cas_count_read/", "uncore_imc/cas_count_write/"],
     {}, "non-temporal stores: expect DRAM writes, no RFO reads")
case("fma512", "compute", [], dict(ONLY_VARIANT="fp32_avx512_fma", ONLY_K=12, REPS=3, TARGET_OPS=100000000),
     ["fp_arith_inst_retired.512b_packed_single", "uops_dispatched.port_0", "uops_dispatched.port_5_11",
      "uops_dispatched.port_1"], {}, "register-only AVX-512 FMA throughput kernel")

results = []
for c in CASES:
    rows, err = run(c["binary"], c["argv"], c["env"], c["events"])
    (out / "raw" / f"{c['name']}.csv").write_text(
        "\n".join(json.dumps({k: v for k, v in r.items()}) for r in rows) + "\n")
    if not rows:
        results.append({"case": c["name"], "error": err[-300:]})
        continue
    r = sorted(rows, key=lambda r: float(r["cycles"]))[len(rows) // 2]     # median-cycles rep
    work = float(r["work"])
    x = r["extra_d"]
    rec = {"case": c["name"], "note": c["note"], "work": work, "work_unit": r["work_unit"],
           "cycles": int(r["cycles"]), "instructions": int(r["instructions"])}
    # Normalisation: pointer chases and fma -> per load / per instruction;
    # streams (work in bytes) -> per 64-byte line requested. Uncore CAS
    # counts are one 64 B line each, so they normalise the same way.
    per = work / 64 if r["work_unit"] == "bytes" else work
    for k, v in x.items():
        rec[k] = v
        rec[f"{k}/work"] = v / per
    results.append(rec)
    print(c["name"], {k: (round(v, 4) if isinstance(v, float) else v) for k, v in rec.items() if "/" in k})

(out / "processed" / "counter_validation.json").write_text(json.dumps(results, indent=2) + "\n")

# Human-readable verdicts
V = ["# Counter validation against known-answer microbenchmarks", "",
     "Each row: counter value divided by the known amount of work: per dependent load for pointer "
     "chases, per 64-byte line requested for streams, per FMA instruction for fma512. One uncore "
     "CAS = one 64 B line. Uncore counters are socket-wide, so other activity on the machine adds "
     "to them.", ""]
for r in results:
    if "error" in r:
        V.append(f"- **{r['case']}**: ERROR {r['error']}")
        continue
    V.append(f"## {r['case']}\n\n{r['note']}; work = {r['work']:.4g} {r['work_unit']}; "
             f"cycles per unit = {r['cycles'] / (r['work'] / 64 if r['work_unit'] == 'bytes' else r['work']):.3f}\n")
    V.append("| counter | value | per unit (load / line / FMA) |")
    V.append("|---|---|---|")
    for k in r:
        if k.endswith("/work"):
            base = k[:-5]
            V.append(f"| `{base}` | {r[base]:,} | {r[k]:.4f} |")
    V.append("")
(out / "processed" / "COUNTER_VALIDATION.md").write_text("\n".join(V) + "\n")
print("wrote", out / "processed" / "COUNTER_VALIDATION.md")
