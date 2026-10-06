#!/usr/bin/env bash
# Second batch of pending measurements (2026-10-06 resume): dispatch overhead,
# then the single-core optimization experiments, then multi-core scaling. Each step waits for a quiet machine.
set -uo pipefail
source "$(dirname "$0")/common.sh"
cd "$REPO_ROOT"
LOG="$REPO_ROOT/results/quiet_gate.log"
gate() { echo "== gate before: $1" | tee -a "$LOG"; QUIET_WAIT_MIN=${QUIET_WAIT_MIN:-720} scripts/wait_quiet.sh "$LOG" || { echo "gate timeout before $1"; exit 1; }; }
gate "dispatch overhead";  scripts/run_dispatch_overhead.sh 2>&1 | tail -3
gate "optimizations";      QUIET_WAIT_MIN=${QUIET_WAIT_MIN:-720} scripts/run_optimizations.sh 2>&1 | tail -40
gate "multicore";          QUIET_WAIT_MIN=${QUIET_WAIT_MIN:-720} scripts/run_multicore.sh 2>&1 | tail -30
echo "PENDING2 CHAIN DONE"
