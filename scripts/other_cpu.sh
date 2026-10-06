#!/usr/bin/env bash
# Instantaneous %CPU used by OTHER users' processes (sum over processes, from
# a 1 s top sample; 100 = one core). ps %CPU is a lifetime average and lags.
top -b -n 2 -d 1 -w 512 | awk -v me="$(id -un)" '
    /^ *PID +USER/ {blk++; next}
    blk == 2 && NF >= 12 && $2 != me {s += $9}
    END {printf "%.0f\n", s}'
