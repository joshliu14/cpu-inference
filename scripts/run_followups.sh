#!/usr/bin/env bash
# Follow-up experiments after the optimization and multi-core runs:
#   python_overhead.py      eager vs TorchScript trace vs GC off (one core)
#   multicore_breakdown.py  per-operator time at N threads (what stops scaling)
# Each step waits until other users use < 1 core; the other users' CPU during
# each step is recorded in raw/contention.csv.
set -uo pipefail
source "$(dirname "$0")/common.sh"
OUT="$(make_result_dir followups)"
OTHER="$REPO_ROOT/scripts/other_cpu.sh"
echo "step,max_other_cpu_pct" > "$OUT/raw/contention.csv"
"$REPO_ROOT/scripts/wait_quiet.sh" "$OUT/raw/quiet_gate.log" || exit 1
step() {   # step NAME command...
    local name="$1"; shift
    until [[ $(taskset -c 27 "$OTHER") -lt 100 ]]; do echo "  waiting for other users" >&2; sleep 30; done
    ( while :; do taskset -c 27 "$OTHER"; sleep 1; done ) > "$OUT/raw/contention_$name.txt" &
    local sp=$!
    "$@" 2>&1 | grep -v "Warning\|warnings.warn"
    kill "$sp"; wait "$sp" 2>/dev/null
    echo "$name,$(sort -n "$OUT/raw/contention_$name.txt" | tail -1)" >> "$OUT/raw/contention.csv"
}
( single_thread_env
  step python_overhead "$PY" "$REPO_ROOT/experiments/python_overhead.py" --cpu "$BENCH_CPU" --out "$OUT" )
export OMP_PROC_BIND=close OMP_PLACES=cores
for V in baseline fold_bn+channels_last; do
    for N in 1 4 16 26; do
        step "breakdown_${V}_${N}" env OMP_NUM_THREADS=$N MKL_NUM_THREADS=$N taskset -c 1-$N \
            "$PY" "$REPO_ROOT/experiments/multicore_breakdown.py" --variant "$V" --threads "$N" --out "$OUT"
    done
done
cat "$OUT/raw/contention.csv"
echo "done: $OUT"
