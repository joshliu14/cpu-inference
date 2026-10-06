#!/usr/bin/env bash
# Optimization experiment: intra-op thread scaling (NOT part of the baseline).
# For N threads the process is pinned to CPUs 1..N (CPU 0 takes more IRQs).
# usage: experiments/opt_threads.sh OUTDIR
set -euo pipefail
source "$(dirname "$0")/../scripts/common.sh"
OUT="$1"
for N in 1 2 4 8 14 26; do
    OMP_NUM_THREADS=$N MKL_NUM_THREADS=$N taskset -c 1-$N "$PY" "$REPO_ROOT/experiments/e2e_latency.py" \
        --threads $N --iters 100 --warmup 15 --out "$OUT" --tag "threads_$N" --no-counters
done
