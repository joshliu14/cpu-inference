#!/usr/bin/env bash
# Intel VTune Profiler on ResNet-50 (FP32, batch 1, baseline): one core, one
# inference on 28 threads, and 28 independent single-thread copies.
#
# Two analyses per configuration:
#   uarch-exploration  full top-down (TMA) hierarchy, per operator via ITT tasks
#   memory-access      cache/DRAM-bound breakdown, DRAM bandwidth timeline
# experiments/vtune_run.py labels each PyTorch operator as an ITT task and each
# inference as an "inference" range; oneDNN adds its own "convolution" and
# "reorder" tasks. ITT tasks are per thread: with 28 OpenMP threads only the
# main thread carries them, so the 28-thread runs are grouped by function.
#
# Driverless (perf-based) collection: the account is not in the "vtune" group,
# so events are multiplexed in one run (multi-run needs the driver). Runs are
# long (uarch: ~2 min on one core, ~1 min multi-core) so every event group
# gets many samples; a 30-inference test gave level-1 TMA sums of 110%.
#
# Every collection waits for a quiet machine and is redone if other users
# exceed one core while it runs (sampled every ~3 s, scripts/other_cpu.sh).
#
# usage: scripts/run_vtune.sh [OUT_DIR]     (default results/<date>_vtune)
set -uo pipefail
cd "$(dirname "$0")/.."
source /opt/intel/oneapi/vtune/latest/env/vars.sh > /dev/null 2>&1
OUT="${1:-results/$(date +%F)_vtune}"
RAW="$OUT/raw_large"; PROC="$OUT/processed"; LOGD="$OUT/raw"
mkdir -p "$RAW" "$PROC" "$LOGD"
PY=.venv/bin/python
MAX_OTHER=100
log() { echo "$(date +%T) $*" | tee -a "$OUT/run.log"; }

gate() {
    scripts/wait_quiet.sh "$OUT/quiet_gate.log" > /dev/null 2>&1
    until [ "$(taskset -c 27 scripts/other_cpu.sh)" -lt "$MAX_OTHER" ]; do sleep 20; done
}

sampler_start() {   # $1 = file; samples other users' CPU every ~3 s
    ( while :; do echo "$(date +%s) $(taskset -c 27 scripts/other_cpu.sh)"; sleep 2; done ) > "$1" &
    SAMPLER=$!
}
sampler_stop() { kill "$SAMPLER" 2> /dev/null; wait "$SAMPLER" 2> /dev/null; awk 'BEGIN{m=0} {if ($2 > m) m = $2} END{print m}' "$1"; }

export_reports() {  # $1 = name
    local r="$RAW/$1"
    vtune -report summary -r "$r" > "$PROC/$1_summary.txt" 2> /dev/null
    vtune -report summary -r "$r" -format csv -csv-delimiter , > "$PROC/$1_summary.csv" 2> /dev/null
    vtune -report hotspots -r "$r" -group-by task -format csv -csv-delimiter , > "$PROC/$1_by_task.csv" 2> /dev/null
    vtune -report hotspots -r "$r" -group-by function -format csv -csv-delimiter , > "$PROC/$1_by_function.csv" 2> /dev/null
    vtune -report hotspots -r "$r" -group-by module -format csv -csv-delimiter , > "$PROC/$1_by_module.csv" 2> /dev/null
}

collect() {         # $1 = name, $2 = analysis, $3 = extra knobs, rest = command
    local name=$1 analysis=$2 knobs=$3; shift 3
    if [ -f "$PROC/${name}_by_task.csv" ]; then log "$name: already done"; return; fi
    for attempt in 1 2 3; do
        gate
        rm -rf "$RAW/$name"
        sampler_start "$LOGD/other_$name.txt"
        # shellcheck disable=SC2086
        vtune -collect "$analysis" $knobs -data-limit=3000 -r "$RAW/$name" -- "$@" \
            > "$LOGD/vtune_$name.log" 2>&1
        local rc=$? mx; mx=$(sampler_stop "$LOGD/other_$name.txt")
        log "$name: rc=$rc other<=${mx}% $(grep -h 'median' "$LOGD/vtune_$name.log" | head -1)"
        if [ "$rc" -eq 0 ] && [ "$mx" -lt "$MAX_OTHER" ]; then
            export_reports "$name"
            log "$name: clean (attempt $attempt), $(du -sh "$RAW/$name" | cut -f1)"
            return
        fi
        log "$name: CONTAMINATED or failed (attempt $attempt), retrying"
    done
}

one()    { echo env OMP_NUM_THREADS=1 MKL_NUM_THREADS=1 taskset -c 6 $PY experiments/vtune_run.py --threads 1 --iters "$1"; }
thr()    { echo env OMP_NUM_THREADS=28 MKL_NUM_THREADS=28 OMP_PROC_BIND=close OMP_PLACES=cores \
                taskset -c 0-27 $PY experiments/vtune_run.py --threads 28 --iters "$1"; }
copies() { echo "for c in \$(seq 0 27); do OMP_NUM_THREADS=1 MKL_NUM_THREADS=1 taskset -c \$c $PY experiments/vtune_run.py --threads 1 --iters $1 > /dev/null & done; wait"; }

# iterations: ~104 ms (1 core), ~15 ms (28 threads), ~120 ms per copy (28 copies)
# shellcheck disable=SC2046
collect uarch_1t     uarch-exploration ""                          $(one 1200)
# shellcheck disable=SC2046
collect memory_1t    memory-access     ""                          $(one 600)
# shellcheck disable=SC2046
collect uarch_28t    uarch-exploration "-knob sampling-interval=5" $(thr 4000)
# shellcheck disable=SC2046
collect memory_28t   memory-access     "-knob sampling-interval=5" $(thr 2000)
collect uarch_28cp   uarch-exploration "-knob sampling-interval=5" bash -c "$(copies 500)"
collect memory_28cp  memory-access     "-knob sampling-interval=5" bash -c "$(copies 250)"
log "done: vtune"
