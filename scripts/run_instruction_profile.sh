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

record() {   # record <name> <seconds> [--layer L]
    local name="$1" secs="$2"; shift 2
    ONEDNN_JIT_PROFILE=6 ONEDNN_JIT_PROFDIR="$JIT" JITDUMPDIR="$JIT" \
    perf record -q -k 1 -e cycles:P -c 200003 --call-graph lbr -o "$BIG/$name.data" -- \
        taskset -c "$BENCH_CPU" "$PY" -X perf "$LOOP" --seconds "$secs" "$@" >"$OUT/raw/${name}_loop.txt" 2>&1
    perf inject --jit -i "$BIG/$name.data" -o "$BIG/$name.jit.data" 2>/dev/null || cp "$BIG/$name.data" "$BIG/$name.jit.data"
    perf report -i "$BIG/$name.jit.data" --stdio --no-children --sort dso -q --percent-limit 0.1 \
        >"$OUT/raw/${name}_dso.txt" 2>/dev/null
    perf report -i "$BIG/$name.jit.data" --stdio --no-children --sort dso,sym -q --percent-limit 0.2 \
        >"$OUT/raw/${name}_symbols.txt" 2>/dev/null
}

echo "[1/3] full inference loop"
record full "$SECS"
perf report -i "$BIG/full.jit.data" --stdio --children --sort sym -q --percent-limit 2 -g none \
    >"$OUT/raw/full_children.txt" 2>/dev/null

echo "[2/3] single operators"
LAYERS="${LAYERS:-maxpool layer1.0.conv1 layer1.0.conv2 layer1.0.conv3 layer2.0.downsample.0 layer4.0.conv2 conv1 layer1.0.bn1 layer1.0.relu1 layer1.0.add fc avgpool}"
for L in $LAYERS; do
    record "op_$L" 5 --layer "$L"
    # Annotate the hottest symbols of this operator (by sample share).
    "$PY" "$REPO_ROOT/analysis/annotate_top.py" "$BIG/op_$L.jit.data" "$OUT/annotate/$L" 3 || true
done

echo "[3/3] perf mem (load sampling)"
perf mem -t load record -q -o "$BIG/mem.data" -- \
    taskset -c "$BENCH_CPU" "$PY" "$LOOP" --seconds 8 >"$OUT/raw/mem_loop.txt" 2>&1
perf mem -t load report -i "$BIG/mem.data" --stdio --sort mem -q >"$OUT/raw/mem_by_level.txt" 2>/dev/null
perf mem -t load report -i "$BIG/mem.data" --stdio --sort dso,sym,mem -q --percent-limit 0.5 \
    >"$OUT/raw/mem_by_symbol_level.txt" 2>/dev/null
perf report -i "$BIG/mem.data" --stdio --sort mem,dso -F overhead,sample,weight,mem,dso -q 2>/dev/null \
    >"$OUT/raw/mem_weight_by_level.txt" || true

"$PY" "$REPO_ROOT/analysis/analyze_instructions.py" "$OUT" || echo "analysis failed; raw data intact"
echo "done: $OUT"
