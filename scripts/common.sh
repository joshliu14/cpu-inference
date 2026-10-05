# Shared helpers for experiment scripts. Source this file; do not execute it.

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PY="$REPO_ROOT/.venv/bin/python"

# make_result_dir <name>
# Creates results/<YYYY-MM-DD>_<name>/ and prints its path. If that directory
# already exists, a _HHMMSS suffix is added so earlier results are never
# overwritten.
make_result_dir() {
    local name="$1"
    local base="$REPO_ROOT/results/$(date +%F)_${name}"
    local dir="$base"
    if [[ -e "$dir" ]]; then
        dir="${base}_$(date +%H%M%S)"
    fi
    mkdir -p "$dir"/{raw,processed,plots}
    echo "$dir"
}

# Environment that pins every math library to a single thread.
single_thread_env() {
    export OMP_NUM_THREADS=1
    export MKL_NUM_THREADS=1
    export OPENBLAS_NUM_THREADS=1
    export NUMEXPR_NUM_THREADS=1
    export KMP_AFFINITY=disabled
}

# Default measurement CPU. CPUs 0 and 27 receive more interrupts on this
# machine, so a mid-range CPU is used unless BENCH_CPU is set.
BENCH_CPU="${BENCH_CPU:-6}"
