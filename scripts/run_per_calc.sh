#!/usr/bin/env bash
# Cost of ONE calculation: core level (register-only instruction loops) vs
# inside every ResNet-50 operator (time / calculations, split into compute
# kernel, weight re-layout, activation re-layout, framework).
# Waits until other users use < 1 core; records their CPU during each step.
set -uo pipefail
source "$(dirname "$0")/common.sh"
single_thread_env
OUT="$(make_result_dir per_calc)"
OTHER="$REPO_ROOT/scripts/other_cpu.sh"
echo "step,max_other_cpu_pct" > "$OUT/raw/contention.csv"
"$REPO_ROOT/scripts/wait_quiet.sh" "$OUT/raw/quiet_gate.log" || exit 1
step() {   # step NAME command...
    local name="$1"; shift
    until [[ $(taskset -c 27 "$OTHER") -lt 100 ]]; do echo "  waiting for other users" >&2; sleep 30; done
    ( while :; do taskset -c 27 "$OTHER"; sleep 1; done ) > "$OUT/raw/contention_$name.txt" &
    local sp=$!
    "$@"
    kill "$sp"; wait "$sp" 2>/dev/null
    echo "$name,$(sort -n "$OUT/raw/contention_$name.txt" | tail -1)" >> "$OUT/raw/contention.csv"
}
step core taskset -c "$BENCH_CPU" "$REPO_ROOT/microbench/bin/compute" > "$OUT/raw/compute.csv"
step operators "$PY" "$REPO_ROOT/experiments/per_calc.py" --cpu "$BENCH_CPU" --out "$OUT" --iters 30 --verbose-iters 5
"$PY" "$REPO_ROOT/analysis/analyze_per_calc.py" "$OUT" > /dev/null
cat "$OUT/raw/contention.csv"
echo "done: $OUT"
