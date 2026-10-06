#!/usr/bin/env bash
# Validate PMU counters on microbenchmarks with known answers (see
# experiments/validate_counters.py). Output: results/<date>_counter_validation/
set -euo pipefail
source "$(dirname "$0")/common.sh"
make -C "$REPO_ROOT/microbench" -s all
OUT="$(make_result_dir counter_validation)"
"$PY" "$REPO_ROOT/experiments/validate_counters.py" --cpu "$BENCH_CPU" --out "$OUT"
echo "done: $OUT"
