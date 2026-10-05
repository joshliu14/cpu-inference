#!/usr/bin/env bash
# Level 6: controlled native baselines.
#   compute    register-only latency/throughput (scalar, SSE, AVX2, AVX-512, int)
#   memlat     pointer-chasing latency vs working set (random/sequential, 4K/2M pages)
#   membw      bandwidth vs working set (read/write/nt-write/copy/triad/random)
#   intensity  adjustable arithmetic intensity (empirical roofline)
#   flags      same C source compiled with -O2/-O3/-march=native/... variants
# Output: results/<date>_microbench/{raw,processed,plots,asm}
#
# usage: scripts/run_microbench.sh [quick]
set -euo pipefail
source "$(dirname "$0")/common.sh"
QUICK="${1:-}"
OUT="$(make_result_dir microbench)"
mkdir -p "$OUT/asm"
echo "results -> $OUT  (cpu $BENCH_CPU)"

make -C "$REPO_ROOT/microbench" -s all asm
cp "$REPO_ROOT"/microbench/bin/*.asm "$OUT/asm/"
B="$REPO_ROOT/microbench/bin"
run() { taskset -c "$BENCH_CPU" "$@"; }

if [[ "$QUICK" == "quick" ]]; then
    export REPS=2 MAX_MB=256 MAX_STEPS=2000000 MIN_BYTES_PER_REP=100000000
fi

# Machine state at the start (noise context).
{ date -Is; uptime; cat /proc/loadavg; } >"$OUT/raw/machine_state_start.txt"

echo "[1/5] compute";   run "$B/compute" >"$OUT/raw/compute.csv"
echo "[2/5] memlat";    run "$B/memlat" random >"$OUT/raw/memlat_random_4k.csv"
THP=1 run "$B/memlat" random >"$OUT/raw/memlat_random_thp.csv"
run "$B/memlat" sequential >"$OUT/raw/memlat_sequential_4k.csv"
echo "[3/5] membw"
for k in read write write_nt copy triad rand_read; do
    run "$B/membw" "$k" >"$OUT/raw/membw_${k}_4k.csv"
done
THP=1 run "$B/membw" read >"$OUT/raw/membw_read_thp.csv"
echo "[4/5] intensity"; run "$B/intensity" >"$OUT/raw/intensity.csv"
THP=1 WS_LIST=524288 run "$B/intensity" >"$OUT/raw/intensity_dram_thp.csv"
echo "[5/5] flags"
for v in O2 O3 O3_native O3_native_zmm O3_native_fast; do
    run "$B/flags_$v" >"$OUT/raw/flags_$v.csv"
done

{ date -Is; uptime; cat /proc/loadavg; } >"$OUT/raw/machine_state_end.txt"
"$PY" "$REPO_ROOT/analysis/analyze_microbench.py" "$OUT" || echo "analysis step failed; raw data is intact in $OUT/raw"
echo "done: $OUT"
