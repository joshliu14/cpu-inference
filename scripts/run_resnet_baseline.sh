#!/usr/bin/env bash
# Baseline ResNet-50 measurements (levels 0-3, 5):
#   e2e_latency.py   wall-clock latency (explicit model, torchvision model,
#                    and ImageNet weights as a control)
#   op_profile.py    per-operator time + counter passes: in-model,
#                    standalone (hot) and standalone (cold caches)
# Output: results/<date>_resnet_baseline/
#
# usage: scripts/run_resnet_baseline.sh [quick]
set -euo pipefail
source "$(dirname "$0")/common.sh"
single_thread_env
OUT="$(make_result_dir resnet_baseline)"
echo "results -> $OUT  (cpu $BENCH_CPU)"
{ date -Is; uptime; cat /proc/loadavg; } >"$OUT/raw/machine_state_start.txt"

if [[ "${1:-}" == "quick" ]]; then
    ITERS=20; WARM=5; OPIT=5; REPS=3
else
    ITERS=300; WARM=30; OPIT=30; REPS=7
fi

E="$REPO_ROOT/experiments"
"$PY" "$E/e2e_latency.py" --cpu "$BENCH_CPU" --iters $ITERS --warmup $WARM --out "$OUT" --tag explicit
"$PY" "$E/e2e_latency.py" --cpu "$BENCH_CPU" --iters $ITERS --warmup $WARM --out "$OUT" --impl torchvision --tag torchvision
"$PY" "$E/e2e_latency.py" --cpu "$BENCH_CPU" --iters $ITERS --warmup $WARM --out "$OUT" --weights imagenet --tag imagenet_weights \
    || echo "imagenet weights unavailable (download failed); control skipped"
"$PY" "$E/e2e_latency.py" --cpu "$BENCH_CPU" --iters $ITERS --warmup $WARM --out "$OUT" --no-counters --tag no_counters

"$PY" "$E/op_profile.py" --cpu "$BENCH_CPU" --out "$OUT" --iters $OPIT --reps $REPS

{ date -Is; uptime; cat /proc/loadavg; } >"$OUT/raw/machine_state_end.txt"
"$PY" "$REPO_ROOT/analysis/analyze_resnet.py" "$OUT" || echo "analysis failed; raw data intact in $OUT/raw"
echo "done: $OUT"
