#!/usr/bin/env bash
# LEVEL 4 (+5): which instructions actually execute, and where loads come from.
#
#   1. perf record of the full inference loop (cycles:P, LBR call stacks),
#      with oneDNN JIT code made visible (ONEDNN_JIT_PROFILE=6 -> jitdump,
#      then perf inject --jit) and Python frames named (python -X perf).
#      -> share of samples per shared library (DSO) and per symbol.
#   2. perf record of single operators run standalone (infer_loop --layer),
#      then perf annotate of each one's hottest symbol -> instruction-level
#      hot spots and an instruction-mix breakdown.
#   3. perf mem (load sampling with data source + latency) on the full loop.
# Large perf.data files go to raw_large/ (git-ignored); text reports are kept.
#
# usage: scripts/run_instruction_profile.sh
set -euo pipefail
source "$(dirname "$0")/common.sh"
single_thread_env
OUT="$(make_result_dir instruction_profile)"
BIG="$OUT/raw_large"
JIT="$BIG/jit"
mkdir -p "$BIG" "$JIT" "$OUT/annotate"
echo "results -> $OUT (cpu $BENCH_CPU)"
LOOP="$REPO_ROOT/experiments/infer_loop.py"
SECS="${SECS:-12}"

# Sampling period: the kernel has throttled kernel.perf_event_max_sample_rate to
# 1000/s on this machine, so sample every 2.5 M cycles (~840 samples/s at 2.1 GHz)
# instead of raising a system-wide limit. Recording starts only when the loop
# starts (perf control FIFO, see infer_loop.perf_enable).
PERIOD="${PERIOD:-2500003}"
record() {   # record <name> <seconds> [--layer L]
    local name="$1" secs="$2"; shift 2
    local ctl="$BIG/$name.ctl" ack="$BIG/$name.ack"
    rm -f "$ctl" "$ack"; mkfifo "$ctl" "$ack"
    PERF_CTL_FIFO="$ctl" PERF_ACK_FIFO="$ack" \
    ONEDNN_JIT_PROFILE=6 ONEDNN_JIT_PROFDIR="$JIT" JITDUMPDIR="$JIT" \
    perf record -q -k 1 -e cycles:P -c "$PERIOD" --call-graph lbr -D -1 --control "fifo:$ctl,$ack" \
        -o "$BIG/$name.data" -- \
        taskset -c "$BENCH_CPU" "$PY" -X perf "$LOOP" --seconds "$secs" "$@" >"$OUT/raw/${name}_loop.txt" 2>&1
    rm -f "$ctl" "$ack"
    perf inject --jit -i "$BIG/$name.data" -o "$BIG/$name.jit.data" 2>/dev/null || cp "$BIG/$name.data" "$BIG/$name.jit.data"
    perf report -i "$BIG/$name.jit.data" --stdio --no-children --sort dso -q --percent-limit 0.1 -g none \
        >"$OUT/raw/${name}_dso.txt" 2>/dev/null
    perf report -i "$BIG/$name.jit.data" --stdio --no-children --sort dso,sym -q --percent-limit 0.2 -g none \
        >"$OUT/raw/${name}_symbols.txt" 2>/dev/null
}

echo "[1/3] full inference loop"
record full "$SECS"
# (operators below: 8 s each -> ~6700 samples)
perf report -i "$BIG/full.jit.data" --stdio --children --sort sym -q --percent-limit 2 -g none \
    >"$OUT/raw/full_children.txt" 2>/dev/null

echo "[2/3] single operators"
LAYERS="${LAYERS:-maxpool layer1.0.conv1 layer1.0.conv2 layer1.0.conv3 layer2.0.downsample.0 layer4.0.conv2 conv1 layer1.0.bn1 layer1.0.relu1 layer1.0.add fc avgpool}"
for L in $LAYERS; do
    record "op_$L" 8 --layer "$L"
    # Annotate the hottest symbols of this operator (by sample share).
    "$PY" "$REPO_ROOT/analysis/annotate_top.py" "$BIG/op_$L.jit.data" "$OUT/annotate/$L" 3 || true
done

echo "[3/3] perf mem (load sampling)"
# Same events `perf mem -t load record` uses on this PMU, called through perf
# record so the control FIFO can exclude setup. ldlat=30: only loads whose
# load-to-use latency is >= 30 cycles are eligible, so this shows where SLOW
# loads come from, not the overall load mix (use mem_load_retired.* for that).
ctl="$BIG/mem.ctl" ack="$BIG/mem.ack"; rm -f "$ctl" "$ack"; mkfifo "$ctl" "$ack"
PERF_CTL_FIFO="$ctl" PERF_ACK_FIFO="$ack" \
perf record -q -e '{cpu/mem-loads-aux/,cpu/mem-loads,ldlat=30/}:P' -d -W -D -1 --control "fifo:$ctl,$ack" \
    -o "$BIG/mem.data" -- taskset -c "$BENCH_CPU" "$PY" "$LOOP" --seconds 8 >"$OUT/raw/mem_loop.txt" 2>&1
rm -f "$ctl" "$ack"
perf mem report -i "$BIG/mem.data" --stdio --sort mem -q >"$OUT/raw/mem_by_level.txt" 2>/dev/null
perf mem report -i "$BIG/mem.data" --stdio --sort mem,dso,sym -q --percent-limit 0.5 \
    >"$OUT/raw/mem_by_symbol_level.txt" 2>/dev/null
# Per-sample dump (period, data source, latency) for the analysis; the
# aux group leader carries no data source and is dropped.
perf script -i "$BIG/mem.data" -F event,period,weight,data_src 2>/dev/null | grep "ldlat" \
    >"$OUT/raw/mem_samples.txt" || true

"$PY" "$REPO_ROOT/analysis/analyze_instructions.py" "$OUT" || echo "analysis failed; raw data intact"
echo "done: $OUT"
