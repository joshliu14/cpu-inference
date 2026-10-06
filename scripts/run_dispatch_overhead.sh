#!/usr/bin/env bash
# Fixed software overhead per operator call (Python -> dispatcher -> kernel).
# Output: results/<date>_dispatch_overhead/
set -euo pipefail
source "$(dirname "$0")/common.sh"
single_thread_env
OUT="$(make_result_dir dispatch_overhead)"
"$PY" "$REPO_ROOT/experiments/dispatch_overhead.py" --cpu "$BENCH_CPU" --out "$OUT"
"$PY" "$REPO_ROOT/analysis/analyze_dispatch.py" "$OUT" || true
echo "done: $OUT"
