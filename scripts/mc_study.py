#!/usr/bin/env python3
"""Multi-core study orchestrator: intra-op scaling, intra x inter matrix,
batch x cores, and the memory-system ceiling, each configuration with
hardware counters.

For every configuration (variant, K intra-op threads, S streams, batch B):
  * S worker processes (experiments/mc_run.py) on disjoint core sets of K
    cores each (CPUs 1..26 when <= 26 cores are used, 0..27 for 28).
  * one common measurement window, split into
      pass A  perf stat -a -C <cores> -A: cycles, instructions, ref-cycles,
              LLC misses, L2 lines in, 512/256-bit FP instructions, cycles
              stalled on an L3 miss
      pass B  perf stat: L2-miss data-read occupancy and count (average
              latency by Little's law), scalar FP, total stall cycles
      prof    perf record -C <cores> (cycles) -> share of samples per CPU in
              OpenMP runtime / kernels / Python / ...
    plus socket DRAM traffic (uncore IMC CAS) during passes A and B.
  * other users' CPU sampled before and during the window; a configuration
    is re-run (up to 3 attempts) if other users exceed one core.

Counter passes were checked to count 100% of the time (no multiplexing).

usage: mc_study.py --out DIR --plan intra,matrix,batch,membw [--variants baseline,inductor]
"""
import argparse
import collections
import json
import os
import shutil
import subprocess
import sys
import time

REPO = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
PY = os.path.join(REPO, ".venv", "bin", "python")
OTHER = os.path.join(REPO, "scripts", "other_cpu.sh")
PASS_A = ("cycles,instructions,ref-cycles,longest_lat_cache.miss,l2_lines_in.all,"
          "fp_arith_inst_retired.512b_packed_single,fp_arith_inst_retired.256b_packed_single,"
          "memory_activity.stalls_l3_miss")
PASS_B = ("cycles,instructions,offcore_requests_outstanding.data_rd,offcore_requests.data_rd,"
          "fp_arith_inst_retired.scalar_single,cycle_activity.stalls_total")
IMC = "uncore_imc/cas_count_read/,uncore_imc/cas_count_write/"

ap = argparse.ArgumentParser()
ap.add_argument("--out", required=True)
ap.add_argument("--plan", default="membw,intra,split,interop,matrix,batch")
ap.add_argument("--variants", default="baseline,inductor")
ap.add_argument("--cores", default="1,2,4,8,16,28")
ap.add_argument("--max-other", type=int, default=100, help="max other-user CPU%% during a clean run")
args = ap.parse_args()
OUT = args.out
RAW = os.path.join(OUT, "raw")
BIG = os.path.join(OUT, "raw_large")
for d in (RAW, BIG, os.path.join(OUT, "processed"), os.path.join(OUT, "plots")):
    os.makedirs(d, exist_ok=True)
LOG = open(os.path.join(RAW, "mc_study.log"), "a")


def log(msg):
    line = f"{time.strftime('%H:%M:%S')} {msg}"
    print(line, flush=True)
    LOG.write(line + "\n")
    LOG.flush()


def other_cpu():
    try:
        return int(subprocess.run(["taskset", "-c", "27", OTHER], capture_output=True, text=True).stdout.strip())
    except ValueError:
        return 0


def wait_quiet():
    while True:
        o = other_cpu()
        if o < args.max_other:
            return
        log(f"  waiting: other users at {o}% CPU")
        time.sleep(30)


def core_set(total):
    return list(range(0, 28)) if total >= 27 else list(range(1, total + 1))


def cpus_str(cs):
    return ",".join(map(str, cs))


class Sampler:
    """Other users' CPU every ~2 s from CPU 27 while a window runs."""

    def __init__(self, path):
        self.p = subprocess.Popen(["bash", "-c", f"while :; do taskset -c 27 {OTHER}; sleep 1; done"],
                                  stdout=open(path, "w"))

    def stop(self, path):
        self.p.terminate()
        self.p.wait()
        vals = [int(v) for v in open(path).read().split() if v.strip().isdigit()]
        return max(vals) if vals else 0


def run_config(cfg):
    """cfg: name, variant, K, S, B. Returns True if clean."""
    name, K, S, B = cfg["name"], cfg["K"], cfg["S"], cfg["B"]
    total = K * S
    cs = core_set(total)
    helper = "27" if total >= 27 else "0"
    for attempt in (1, 2, 3):
        wait_quiet()
        sync = os.path.join(RAW, f"sync_{name}")
        shutil.rmtree(sync, ignore_errors=True)
        os.makedirs(sync)
        procs = []
        for s in range(S):
            mine = cs[s * K:(s + 1) * K]
            env = dict(os.environ, OMP_NUM_THREADS=str(K), MKL_NUM_THREADS=str(K), OMP_PROC_BIND="close",
                       OMP_PLACES="cores", KMP_AFFINITY="disabled")
            procs.append(subprocess.Popen(
                [PY, os.path.join(REPO, "experiments", "mc_run.py"), "--variant", cfg["variant"],
                 "--threads", str(K), "--batch", str(B), "--cpus", cpus_str(mine), "--id", str(s),
                 "--sync", sync, "--out", OUT, "--tag", name],
                env=env, stdout=open(os.path.join(sync, f"log_{s}.txt"), "w"), stderr=subprocess.STDOUT))
        t_build = time.time()
        while sum(1 for f in os.listdir(sync) if f.startswith("ready_")) < S:
            if any(p.poll() is not None for p in procs) or time.time() - t_build > 1800:
                log(f"  {name}: a worker died or timed out during build")
                for p in procs:
                    p.kill()
                return False
            time.sleep(0.5)
        lat_s = max(json.load(open(os.path.join(sync, f"ready_{s}")))["warm_latency_ms"] for s in range(S)) / 1e3
        wA, wB, wR = max(6.0, 3 * lat_s), max(4.0, 2 * lat_s), max(3.0, 1.5 * lat_s)
        window = 1.0 + wA + wB + wR + 2.5          # margins for perf start-up
        start = time.time() + 1.0
        with open(os.path.join(sync, "go"), "w") as f:
            f.write(f"{start} {start + window}")
        samp_path = os.path.join(RAW, f"other_{name}.txt")
        sampler = Sampler(samp_path)
        while time.time() < start + 1.0:
            time.sleep(0.01)
        tA0 = time.time()
        imcA = subprocess.Popen(["taskset", "-c", helper, "perf", "stat", "-a", "-x,", "-e", IMC, "--", "sleep", f"{wA}"],
                                stderr=open(os.path.join(RAW, f"imcA_{name}.csv"), "w"))
        subprocess.run(["taskset", "-c", helper, "perf", "stat", "-a", "-C", cpus_str(cs), "-A", "-x,", "-e", PASS_A,
                        "--", "sleep", f"{wA}"], stderr=open(os.path.join(RAW, f"statA_{name}.csv"), "w"))
        imcA.wait()
        tB0 = time.time()
        imcB = subprocess.Popen(["taskset", "-c", helper, "perf", "stat", "-a", "-x,", "-e", IMC, "--", "sleep", f"{wB}"],
                                stderr=open(os.path.join(RAW, f"imcB_{name}.csv"), "w"))
        subprocess.run(["taskset", "-c", helper, "perf", "stat", "-a", "-C", cpus_str(cs), "-A", "-x,", "-e", PASS_B,
                        "--", "sleep", f"{wB}"], stderr=open(os.path.join(RAW, f"statB_{name}.csv"), "w"))
        imcB.wait()
        pdata = os.path.join(BIG, f"prof_{name}.data")
        tR0 = time.time()
        subprocess.run(["taskset", "-c", helper, "perf", "record", "-q", "-C", cpus_str(cs), "-e", "cycles",
                        "-c", "2500003", "-o", pdata, "--", "sleep", f"{wR}"], stderr=subprocess.DEVNULL)
        t_end = time.time()
        max_other = sampler.stop(samp_path)
        for p in procs:     # streams stop by themselves at start + window (plus one inference)
            try:
                p.wait(timeout=max(30.0, start + window - time.time() + 3 * lat_s + 30))
            except subprocess.TimeoutExpired:
                p.kill()
        clean = max_other < args.max_other
        meta = dict(cfg, attempt=attempt, cores=cs, total_cores=total, warm_latency_s=lat_s,
                    windows={"A": [tA0, tA0 + wA], "B": [tB0, tB0 + wB], "prof": [tR0, tR0 + wR],
                             "start": start, "end": t_end},
                    max_other_cpu_pct=max_other, clean=clean)
        json.dump(meta, open(os.path.join(RAW, f"config_{name}.json"), "w"), indent=1)
        log(f"{name}: K={K} S={S} B={B} cores={total} warm {lat_s * 1e3:.1f} ms  other<= {max_other}%  "
            f"{'clean' if clean else 'CONTAMINATED'} (attempt {attempt})")
        if clean:
            summarize_profile(name, pdata)
            return True
    return False


def classify(ip, dso, sym):
    d = dso.lower()
    if ip.startswith("ffff") or d.startswith("[kernel") or "kallsyms" in d:
        return "OS kernel"
    if "gomp" in d:
        return "OpenMP runtime (spin/barrier)"
    if "perf-" in d and d.endswith(".map"):
        return "oneDNN JIT kernel"              # oneDNN publishes its JIT code in /tmp/perf-<pid>.map
    if "mkl_" in sym:
        return "MKL GEMM"
    if "torchinductor" in d or (os.path.basename(d).startswith("c") and d.endswith(".so") and len(os.path.basename(d)) > 30):
        return "inductor generated code"
    if "dnnl" in sym or "jit" in sym.lower():
        return "oneDNN host code"
    if "at::native" in sym or "c10::function_ref" in sym:
        return "ATen native kernels"
    if "python" in d:
        return "Python interpreter"
    if "libc.so" in d or "libstdc" in d:
        return "libc / allocator"
    if d in ("[unknown]", ""):
        return "unknown"
    return "PyTorch dispatcher / other"


LINE = __import__("re").compile(r"^\[(\d+)\]\s+([0-9a-f]+)\s+(.*?)\s+\(([^()]*)\)\s*$")


def summarize_profile(name, pdata):
    try:
        out = subprocess.run(["perf", "script", "-i", pdata, "-F", "cpu,ip,sym,dso"], capture_output=True,
                             text=True, timeout=900).stdout
    except subprocess.TimeoutExpired:
        return
    per_cpu = collections.defaultdict(collections.Counter)
    for line in out.splitlines():
        m = LINE.match(line.strip())
        if m:
            per_cpu[int(m.group(1))][classify(m.group(2), m.group(4), m.group(3))] += 1
    json.dump({str(c): dict(v) for c, v in per_cpu.items()}, open(os.path.join(RAW, f"prof_{name}.json"), "w"))
    try:
        os.remove(pdata)
    except OSError:
        pass


def membw_ceiling(cores):
    """Memory-system ceiling: n concurrent AVX-512 read streams (1 GiB each, 2 MiB pages)."""
    exe = os.path.join(REPO, "microbench", "bin", "membw")
    res = {}
    for n in cores:
        wait_quiet()
        cs = core_set(n)
        env = dict(os.environ, THP="1", MIN_KB=str(1 << 20), MAX_MB="1024", REPS="1000",
                   MIN_BYTES_PER_REP=str(4 * 10 ** 9))
        ps = [subprocess.Popen(["taskset", "-c", str(c), exe, "read"], env=env, stdout=subprocess.DEVNULL,
                               stderr=subprocess.DEVNULL) for c in cs]
        time.sleep(4.0)   # allocation + first touch
        r = subprocess.run(["perf", "stat", "-a", "-x,", "-e", IMC, "--", "sleep", "5"], capture_output=True, text=True)
        for p in ps:
            p.kill()
        tot = {"read": 0.0, "write": 0.0}
        for line in r.stderr.splitlines():
            f = line.split(",")
            if len(f) > 3 and "cas_count" in line:
                mb = float(f[0]) * 1.048576 if f[1] == "MiB" else float(f[0]) * 64 / 1e6
                tot["read" if "read" in line else "write"] += mb / 1000 / 5
        res[n] = tot
        log(f"membw ceiling: {n:2d} read streams -> DRAM read {tot['read']:.1f} GB/s, write {tot['write']:.1f} GB/s")
    json.dump(res, open(os.path.join(RAW, "membw_ceiling.json"), "w"), indent=1)


def split_runs(cores, variant="baseline"):
    """Per-layer time split (kernel / weight re-layout / activation re-layout / framework) at K threads:
    experiments/per_calc.py with oneDNN + MKL verbose timers, one process per K."""
    for K in cores:
        tag = f"_K{K}"
        if os.path.exists(os.path.join(RAW, f"per_calc_layers{tag}.csv")):
            log(f"split K={K}: already measured, skipping")
            continue
        for attempt in (1, 2, 3):
            wait_quiet()
            cs = core_set(K)
            env = dict(os.environ, OMP_NUM_THREADS=str(K), MKL_NUM_THREADS=str(K), OMP_PROC_BIND="close",
                       OMP_PLACES="cores", KMP_AFFINITY="disabled")
            samp_path = os.path.join(RAW, f"other_split{tag}.txt")
            sampler = Sampler(samp_path)
            subprocess.run([PY, os.path.join(REPO, "experiments", "per_calc.py"), "--cpus", cpus_str(cs),
                            "--threads", str(K), "--out", OUT, "--tag", tag, "--iters", "30", "--verbose-iters", "5"],
                           env=env, stdout=open(os.path.join(RAW, f"split{tag}.log"), "w"), stderr=subprocess.STDOUT)
            mx = sampler.stop(samp_path)
            log(f"split K={K}: other users <= {mx}% ({'clean' if mx < args.max_other else 'CONTAMINATED'})")
            if mx < args.max_other:
                break


def interop_runs():
    """Operator-level inter-op parallelism: experiments/interop_graph.py, one process per setting."""
    for K, I in ((1, 1), (1, 2), (1, 4), (2, 1), (2, 2), (4, 1), (4, 2)):
        for mode in ("eager", "fork_eager", "fork_traced"):
            name = f"interop_{mode}_K{K}_I{I}"
            if os.path.exists(os.path.join(RAW, f"{name}.json")):
                continue
            wait_quiet()
            cs = core_set(K * I)
            # No OMP_PROC_BIND here: it binds the main thread to one core, and PyTorch's inter-op pool
            # threads (created later) inherit that one-core mask, so inter-op work cannot use the other
            # cores (OBSERVED, interop_rerun/raw/*.json "thread_cpus"). taskset alone confines the process.
            env = dict(os.environ, OMP_NUM_THREADS=str(K), MKL_NUM_THREADS=str(K), KMP_AFFINITY="disabled")
            samp_path = os.path.join(RAW, f"other_{name}.txt")
            sampler = Sampler(samp_path)
            subprocess.run(["taskset", "-c", cpus_str(cs), PY, os.path.join(REPO, "experiments", "interop_graph.py"),
                            "--mode", mode, "--intra", str(K), "--inter", str(I), "--out", OUT, "--name", name],
                           env=env, stdout=open(os.path.join(RAW, f"{name}.log"), "w"), stderr=subprocess.STDOUT)
            mx = sampler.stop(samp_path)
            log(f"{name}: other users <= {mx}%")


def main():
    cores = [int(c) for c in args.cores.split(",")]
    variants = args.variants.split(",")
    plan = args.plan.split(",")
    cfgs = []
    if "intra" in plan:
        for v in variants:
            for n in cores:
                cfgs.append({"name": f"intra_{v}_K{n}_S1_B1", "variant": v, "K": n, "S": 1, "B": 1, "group": "intra"})
    if "matrix" in plan:
        splits = {4: [(1, 4), (2, 2)], 8: [(1, 8), (2, 4), (4, 2)], 16: [(1, 16), (2, 8), (4, 4), (8, 2)],
                  28: [(1, 28), (2, 14), (4, 7), (7, 4), (14, 2)]}
        for v in variants:
            for tot, sp in splits.items():
                for K, S in sp:
                    cfgs.append({"name": f"matrix_{v}_K{K}_S{S}_B1", "variant": v, "K": K, "S": S, "B": 1,
                                 "group": "matrix"})
    if "batch" in plan:
        for B in (4, 16, 64):
            for n in (1, 8, 28):
                cfgs.append({"name": f"batch_baseline_K{n}_S1_B{B}", "variant": "baseline", "K": n, "S": 1, "B": B,
                             "group": "batch"})
    if "membw" in plan:
        membw_ceiling(cores)
    if "split" in plan:
        split_runs(cores)
    if "interop" in plan:
        interop_runs()
    done = {f[len("config_"):-5] for f in os.listdir(RAW) if f.startswith("config_")
            and json.load(open(os.path.join(RAW, f))).get("clean")}
    for cfg in cfgs:
        if cfg["name"] in done:
            log(f"{cfg['name']}: already measured, skipping")
            continue
        run_config(cfg)
    log("MC STUDY DONE")


if __name__ == "__main__":
    main()
