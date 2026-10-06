#!/usr/bin/env bash
# Optimization experiments (after the baseline is understood).
#   experiments/opt_variants.py  one-change variants vs baseline (single core)
#   experiments/opt_mechanisms.py counters / oneDNN + ATen census per variant
# Multi-core scaling is a separate experiment: scripts/run_multicore.sh.
# Output: results/<date>_optimizations/
set -euo pipefail
source "$(dirname "$0")/common.sh"
single_thread_env
OUT="$(make_result_dir optimizations)"
"$REPO_ROOT/scripts/wait_quiet.sh" "$OUT/raw/quiet_gate.log"
"$PY" "$REPO_ROOT/experiments/opt_variants.py" --cpu "$BENCH_CPU" --out "$OUT" 2>&1 | grep -v "Warning\|warnings.warn" \
    | tee "$OUT/raw/opt_variants.log"
"$REPO_ROOT/scripts/wait_quiet.sh" "$OUT/raw/quiet_gate.log"
"$PY" "$REPO_ROOT/experiments/opt_mechanisms.py" --cpu "$BENCH_CPU" --out "$OUT" 2>&1 \
    | grep -v "Warning\|warnings.warn\|USDT" | tee "$OUT/raw/opt_mechanisms.log"
"$PY" "$REPO_ROOT/analysis/analyze_opt.py" "$OUT"
echo "done: $OUT"
