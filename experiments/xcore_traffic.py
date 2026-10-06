#!/usr/bin/env python3
"""Cross-core cache traffic vs core count (multi-core memory analysis).

Question: when one inference is split across N threads, how much of the data
each core loads was produced in ANOTHER core's private cache (L1/L2)? The
mc_study showed L2 fills per image doubling and L2-miss latency rising from
67 to 110 ns at 28 threads while DRAM traffic per image stayed flat.

Runs the same workers as scripts/mc_study.py (experiments/mc_run.py, same
OpenMP binding and core sets) and counts, per image, on the cores used:
  pass X1: mem_load_retired.l3_hit / l3_miss, and of the L3 hits
           mem_load_l3_hit_retired.xsnp_fwd    (line MODIFIED in another core's cache: HitM)
           mem_load_l3_hit_retired.xsnp_no_fwd (line present, clean, in another core)
  pass X2: mem_load_l3_hit_retired.xsnp_miss   (snooped other cores, not found)
           ocr.demand_data_rd.l3_hit.snoop_hitm (demand reads served by a modified line in another core)
           ocr.demand_data_rd.l3_hit, l2_lines_in.all
Both passes are checked to count 100% of the time (no multiplexing).

usage: xcore_traffic.py --out DIR --configs baseline:1:1,baseline:28:1,baseline:1:28
       (variant:K intra-op threads:S streams)
"""
import argparse
import json
import os
import shutil
import subprocess
import sys
import time

REPO = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
PY = sys.executable
X1 = ("cycles,instructions,mem_load_retired.l3_hit,mem_load_retired.l3_miss,"
      "mem_load_l3_hit_retired.xsnp_fwd,mem_load_l3_hit_retired.xsnp_no_fwd")
X2 = ("cycles,instructions,mem_load_l3_hit_retired.xsnp_miss,ocr.demand_data_rd.l3_hit.snoop_hitm,"
      "ocr.demand_data_rd.l3_hit,l2_lines_in.all")

ap = argparse.ArgumentParser()
ap.add_argument("--out", required=True)
ap.add_argument("--configs", required=True)
ap.add_argument("--max-other", type=int, default=100, help="other users' %%CPU above which a run is redone")
args = ap.parse_args()
RAW = os.path.join(args.out, "raw")
os.makedirs(RAW, exist_ok=True)


def other_cpu():
    r = subprocess.run(["taskset", "-c", "27", os.path.join(REPO, "scripts", "other_cpu.sh")],
                       capture_output=True, text=True)
    try:
        return int(r.stdout.strip())
    except ValueError:
        return 0


def core_set(total):            # same as scripts/mc_study.py
    return list(range(0, 28)) if total >= 27 else list(range(1, total + 1))


def stat(cpus, events, seconds, helper):
    r = subprocess.run(["taskset", "-c", helper, "perf", "stat", "-C", ",".join(map(str, cpus)), "-x,",
                        "-e", events, "--", "sleep", f"{seconds}"], capture_output=True, text=True)
    tot, minrun = {}, 100.0
    for line in r.stderr.splitlines():
        f = line.split(",")
        if len(f) < 5:
            continue
        try:
            tot[f[2]] = float(f[0])
            minrun = min(minrun, float(f[4]))
        except ValueError:
            pass
    return tot, minrun


def run(variant, K, S):
    name = f"xcore_{variant}_K{K}_S{S}"
    out_json = os.path.join(RAW, f"{name}.json")
    if os.path.exists(out_json):
        print(f"{name}: already measured")
        return
    cs = core_set(K * S)
    helper = "27" if K * S >= 27 else "0"
    for attempt in (1, 2, 3):
        while other_cpu() >= args.max_other:
            time.sleep(20)
        sync = os.path.join(RAW, f"sync_{name}")
        shutil.rmtree(sync, ignore_errors=True)
        os.makedirs(sync)
        env = dict(os.environ, OMP_NUM_THREADS=str(K), MKL_NUM_THREADS=str(K), OMP_PROC_BIND="close",
                   OMP_PLACES="cores", KMP_AFFINITY="disabled")
        procs = [subprocess.Popen([PY, os.path.join(REPO, "experiments", "mc_run.py"), "--variant", variant,
                                   "--threads", str(K), "--batch", "1",
                                   "--cpus", ",".join(map(str, cs[s * K:(s + 1) * K])), "--id", str(s),
                                   "--sync", sync, "--out", args.out, "--tag", name],
                                  env=env, stdout=open(os.path.join(sync, f"log_{s}.txt"), "w"),
                                  stderr=subprocess.STDOUT) for s in range(S)]
        t0 = time.time()
        while sum(f.startswith("ready_") for f in os.listdir(sync)) < S:
            if any(p.poll() is not None for p in procs) or time.time() - t0 > 900:
                for p in procs:
                    p.kill()
                raise SystemExit(f"{name}: a worker died during build")
            time.sleep(0.5)
        lat = max(json.load(open(os.path.join(sync, f"ready_{s}")))["warm_latency_ms"] for s in range(S)) / 1e3
        W = max(5.0, 3 * lat)
        start = time.time() + 1.0
        with open(os.path.join(sync, "go"), "w") as f:
            f.write(f"{start} {start + 1.0 + 2 * W + 3.0}")
        while time.time() < start + 1.0:
            time.sleep(0.01)
        passes = {}
        for tag, ev in (("X1", X1), ("X2", X2)):
            a = time.time()
            tot, minrun = stat(cs, ev, W, helper)
            passes[tag] = {"window": [a, a + W], "counts": tot, "min_running_pct": minrun}
        mx = other_cpu()
        for p in procs:
            p.wait(timeout=120)
        streams = [json.load(open(os.path.join(RAW, f"stream_{name}_{s}.json"))) for s in range(S)]
        for tag, p in passes.items():
            a, b = p["window"]
            p["images"] = sum(1 for s in streams for e in s["end_times"] if a <= e <= b)
            p["per_image"] = {k: v / p["images"] for k, v in p["counts"].items()}
        x1, x2 = passes["X1"]["per_image"], passes["X2"]["per_image"]
        rec = {"name": name, "variant": variant, "K": K, "S": S, "cores": cs, "attempt": attempt,
               "max_other_cpu_pct": mx, "clean": mx < args.max_other, "warm_latency_ms": lat * 1e3,
               "passes": passes,
               "summary_per_image": {
                   "l3_hit_loads_K": x1["mem_load_retired.l3_hit"] / 1e3,
                   "l3_miss_loads_K": x1["mem_load_retired.l3_miss"] / 1e3,
                   "hitm_loads_K": x1["mem_load_l3_hit_retired.xsnp_fwd"] / 1e3,
                   "snoop_clean_hit_loads_K": x1["mem_load_l3_hit_retired.xsnp_no_fwd"] / 1e3,
                   "snoop_miss_loads_K": x2["mem_load_l3_hit_retired.xsnp_miss"] / 1e3,
                   "demand_rd_hitm_K": x2["ocr.demand_data_rd.l3_hit.snoop_hitm"] / 1e3,
                   "demand_rd_l3_hit_K": x2["ocr.demand_data_rd.l3_hit"] / 1e3,
                   "l2_fill_MB": x2["l2_lines_in.all"] * 64 / 1e6,
                   "hitm_share_of_l3_hit_loads": x1["mem_load_l3_hit_retired.xsnp_fwd"]
                   / max(x1["mem_load_retired.l3_hit"], 1),
                   "cycles_M_X1": x1["cycles"] / 1e6}}
        json.dump(rec, open(out_json if rec["clean"] else out_json + f".contaminated{attempt}", "w"), indent=1)
        print(f"{time.strftime('%T')} {name}: other<= {mx}% images X1={passes['X1']['images']} "
              f"X2={passes['X2']['images']} min_running={min(p['min_running_pct'] for p in passes.values())}% "
              + " ".join(f"{k}={v:.3g}" for k, v in rec["summary_per_image"].items()), flush=True)
        if rec["clean"]:
            return


for c in args.configs.split(","):
    v, K, S = c.split(":")
    run(v, int(K), int(S))
print("done: xcore traffic")
