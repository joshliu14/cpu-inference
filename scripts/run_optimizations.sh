#!/usr/bin/env bash
# Optimization experiments (after the baseline is understood).
#   experiments/opt_variants.py  one-change variants vs baseline (single core)
#   experiments/opt_threads.sh   intra-op thread scaling (uses CPUs 1..N)
# Output: results/<date>_optimizations/
set -euo pipefail
source "$(dirname "$0")/common.sh"
single_thread_env
OUT="$(make_result_dir optimizations)"
"$REPO_ROOT/scripts/wait_quiet.sh" "$OUT/raw/quiet_gate.log"
"$PY" "$REPO_ROOT/experiments/opt_variants.py" --cpu "$BENCH_CPU" --out "$OUT"
if [[ "${SKIP_THREADS:-0}" != 1 ]]; then
    "$REPO_ROOT/scripts/wait_quiet.sh" "$OUT/raw/quiet_gate.log"
    "$REPO_ROOT/experiments/opt_threads.sh" "$OUT"
fi
"$PY" "$REPO_ROOT/analysis/analyze_opt.py" "$OUT"
echo "done: $OUT"
