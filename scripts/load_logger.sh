#!/usr/bin/env bash
# Log machine state every 10 s while experiments run, so contaminated windows
# can be found afterwards: load average, %CPU of OTHER users' processes, and
# socket DRAM traffic over 1 s (uncore IMC; includes our own traffic).
# usage: scripts/load_logger.sh LOGFILE   (runs until killed)
LOG="$1"; ME="$(id -un)"
echo "time,load1,other_users_cpu_pct,dram_GBps" >> "$LOG"
while :; do
    other=$(ps -eo user=,pcpu= | awk -v me="$ME" '$1 != me {s += $2} END {printf "%.0f", s}')
    dram=$(perf stat -a -x, -e uncore_imc/cas_count_read/,uncore_imc/cas_count_write/ -- sleep 1 2>&1 \
           | awk -F, '/cas_count/ {s += $1} END {printf "%.2f", s * 1.048576 / 1000}')
    echo "$(date -Is),$(cut -d' ' -f1 /proc/loadavg),$other,$dram" >> "$LOG"
    sleep 9
done
