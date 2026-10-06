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

echo "== intra-op thread scaling"
for V in $VARIANTS; do
    for N in $NS; do
        OMP_NUM_THREADS=$N MKL_NUM_THREADS=$N taskset -c 1-$N \
            "$PY" "$REPO_ROOT/experiments/multicore.py" --mode threads --variant "$V" --threads "$N" \
            --iters 60 --warmup 10 --out "$OUT" 2>&1 | grep -v "Warning\|warnings.warn" || true
    done
done

echo "== independent single-thread instances"
for V in $VARIANTS; do
    for N in $NS; do
        SYNC="$OUT/raw/sync_${V}_${N}"
        rm -rf "$SYNC"; mkdir -p "$SYNC"
        pids=()
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
        echo "instances $V N=$N done ($(ls "$OUT"/raw/instance_${V}_${N}_*.json 2>/dev/null | wc -l) results)"
    done
done
