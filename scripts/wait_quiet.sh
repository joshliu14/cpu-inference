#!/usr/bin/env bash
# Quiet gate: wait until the shared machine is quiet enough to measure.
#
# The machine is shared: other users' jobs compete for the shared L3 and DRAM
# even though our process is pinned to its own core, and a job that occupies
# every core also time-slices our CPU. This gate waits until
#   * 1-minute load average  <= QUIET_LOAD   (default 4)
#   * socket DRAM traffic     <= QUIET_DRAM_GBPS (default 2 GB/s, read+write,
#     measured over 2 s with the uncore IMC counters)
# re-checking every 60 s for up to QUIET_WAIT_MIN minutes (default 180).
#
# usage: scripts/wait_quiet.sh [record_file]
# exit 0 when quiet (state appended to record_file), 1 on timeout.
set -uo pipefail
LOAD_MAX="${QUIET_LOAD:-4}"
DRAM_MAX="${QUIET_DRAM_GBPS:-2}"
WAIT_MIN="${QUIET_WAIT_MIN:-180}"
REC="${1:-/dev/null}"
deadline=$(( $(date +%s) + WAIT_MIN * 60 ))
while :; do
    load=$(cut -d' ' -f1 /proc/loadavg)
    dram=$(perf stat -a -x, -e uncore_imc/cas_count_read/,uncore_imc/cas_count_write/ -- sleep 2 2>&1 \
           | awk -F, '/cas_count/ {s += $1} END {printf "%.2f", s * 1.048576 / 2 / 1000}')
    state="$(date -Is) load1=$load dram_GBps=$dram (limits: load<=$LOAD_MAX dram<=$DRAM_MAX)"
    if awk -v l="$load" -v d="$dram" -v L="$LOAD_MAX" -v D="$DRAM_MAX" 'BEGIN {exit !(l <= L && d <= D)}'; then
        echo "QUIET $state" | tee -a "$REC"
        exit 0
    fi
    echo "BUSY  $state" | tee -a "$REC" >&2
    if (( $(date +%s) > deadline )); then
        echo "TIMEOUT waiting for a quiet machine" | tee -a "$REC" >&2
        exit 1
    fi
    sleep 60
done
