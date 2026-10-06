#!/usr/bin/env bash
# Multi-core experiments: intra-op thread scaling and N independent instances.
# The unmodified baseline ResNet-50 is always measured; VARIANTS adds others.
#
# usage: experiments/multicore.sh OUTDIR
#   env: VARIANTS   space-separated variant names (default "baseline")
#        NS         core counts (default "1 2 4 8 16 26"; CPUs 1..N are used,
#                   CPU 0 and 27 take more interrupts on this machine)
#        SECONDS_INST  measurement window per instance run (default 20)
set -euo pipefail
source "$(dirname "$0")/../scripts/common.sh"
OUT="$1"
VARIANTS="${VARIANTS:-baseline}"
NS="${NS:-1 2 4 8 16 26}"
WIN="${SECONDS_INST:-20}"
mkdir -p "$OUT/raw" "$OUT/processed"
export OMP_PROC_BIND=close OMP_PLACES=cores KMP_AFFINITY=disabled

# ---- contention handling (the machine is shared) ---------------------------
# Before each configuration: wait until other users use < 1 core (instant
# top sample). During it: sample other users' CPU every ~2 s from CPU 27
# (not used by any configuration). A configuration during which other users
# exceeded 1 core is re-run (up to 3 attempts) and flagged if never clean.
OTHER="$REPO_ROOT/scripts/other_cpu.sh"
echo "config,attempt,max_other_cpu_pct,clean" > "$OUT/raw/contention_summary.csv"
wait_others() {
    for _ in $(seq 1 "${MAX_WAIT_POLLS:-360}"); do
        o=$(taskset -c 27 "$OTHER"); [[ "$o" -lt 100 ]] && return 0
        echo "  waiting: other users at ${o}% CPU" >&2; sleep 30
    done
    return 1
}
run_cfg() {   # run_cfg NAME command...
    local name="$1"; shift
    for attempt in 1 2 3; do
        wait_others || { echo "$name: gave up waiting for other users" >&2; return 1; }
        local f="$OUT/raw/contention_${name}.txt"
        ( while :; do echo "$(date +%s) $(taskset -c 27 "$OTHER")"; sleep 1; done ) > "$f" &
        local sp=$!
        "$@"
        kill "$sp" 2>/dev/null; wait "$sp" 2>/dev/null
        local mx; mx=$(awk '{if ($2 > m) m = $2} END {print m + 0}' "$f")
        local clean=$(( mx < 100 ? 1 : 0 ))
        echo "$name,$attempt,$mx,$clean" >> "$OUT/raw/contention_summary.csv"
        [[ $clean == 1 ]] && return 0
        echo "  $name: other users reached ${mx}% CPU during the run -> retry" >&2
    done
}

echo "== intra-op thread scaling"
for V in $VARIANTS; do
    for N in $NS; do
        run_cfg "threads_${V}_${N}" env OMP_NUM_THREADS=$N MKL_NUM_THREADS=$N taskset -c 1-$N \
            "$PY" "$REPO_ROOT/experiments/multicore.py" --mode threads --variant "$V" --threads "$N" \
            --iters 60 --warmup 10 --out "$OUT" || true
    done
done

instances() {   # instances VARIANT N: N single-thread copies on CPUs 1..N, common window
    local V="$1" N="$2"
    SYNC="$OUT/raw/sync_${V}_${N}"
    rm -rf "$SYNC"; mkdir -p "$SYNC"
    local pids=()
    for c in $(seq 1 "$N"); do
        OMP_NUM_THREADS=1 MKL_NUM_THREADS=1 "$PY" "$REPO_ROOT/experiments/multicore.py" --mode instance \
        --variant "$V" --cpu "$c" --sync "$SYNC" --seconds "$WIN" --out "$OUT" --tag "${V}_${N}_${c}" \
        >"$SYNC/log_$c.txt" 2>&1 &
        pids+=($!)
    done
    # wait until every instance has built and warmed up (max 15 min)
    for _ in $(seq 1 900); do
        [[ $(ls "$SYNC" | grep -c '^ready_') -ge $N ]] && break
        sleep 1
    done
    start=$(( $(date +%s) + 2 ))
    echo "$start" > "$SYNC/go"
    # socket DRAM traffic inside the measurement window (1 s margin each side)
    sleep 3
    perf stat -a -x, -e uncore_imc/cas_count_read/,uncore_imc/cas_count_write/ -- sleep $(( WIN - 2 )) \
        2> "$OUT/raw/imc_instances_${V}_${N}.csv"
    for p in "${pids[@]}"; do wait "$p" || echo "instance $p failed"; done
}

echo "== independent single-thread instances"
for V in $VARIANTS; do
    for N in $NS; do
        run_cfg "instances_${V}_${N}" instances "$V" "$N" || true
        echo "instances $V N=$N done ($(ls "$OUT"/raw/instance_${V}_${N}_*.json 2>/dev/null | wc -l) results)"
    done
done
