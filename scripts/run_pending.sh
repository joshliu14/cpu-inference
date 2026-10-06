#!/usr/bin/env bash
# Remaining measurements, each gated on a quiet machine (scripts/wait_quiet.sh).
set -uo pipefail
source "$(dirname "$0")/common.sh"
cd "$REPO_ROOT"
LOG="$REPO_ROOT/results/quiet_gate.log"
gate() { echo "== gate before: $1" | tee -a "$LOG"; scripts/wait_quiet.sh "$LOG" || { echo "gate timeout before $1"; exit 1; }; }
single_thread_env

gate "tdgp re-run"
"$PY" experiments/op_profile.py --cpu "$BENCH_CPU" --out results/2026-10-06_resnet_baseline --append \
    --passes tdgp --standalone-passes tdgp --iters 30 --reps 7 2>&1 | tail -7
"$PY" analysis/analyze_resnet.py results/2026-10-06_resnet_baseline > /dev/null 2>&1 && echo "analysis ok"

gate "counter validation";  scripts/run_counter_validation.sh 2>&1 | tail -2
gate "backend probe";       scripts/run_backend_probe.sh 2>&1 | tail -1
gate "instruction profile"; scripts/run_instruction_profile.sh 2>&1 | tail -3
gate "dispatch overhead";   scripts/run_dispatch_overhead.sh 2>&1 | tail -1
echo "PENDING CHAIN DONE"
