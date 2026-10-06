#!/usr/bin/env bash
# SIMD width actually used by ATen native kernels, under each ATEN_CPU_CAPABILITY.
# Instruction counts do not depend on machine load: no quiet gate needed.
set -euo pipefail
source "$(dirname "$0")/common.sh"
single_thread_env
OUT="$(make_result_dir isa_probe)"
"$PY" "$REPO_ROOT/experiments/isa_probe.py" --cpu "$BENCH_CPU" --out "$OUT" --symbols 2>&1 | tee "$OUT/raw/log.txt"
for cap in avx512 avx2 default; do
    ATEN_CPU_CAPABILITY=$cap "$PY" "$REPO_ROOT/experiments/isa_probe.py" --cpu "$BENCH_CPU" --out "$OUT" 2>&1 \
        | grep -v "Warning\|warnings.warn\|torch.randn" | tee -a "$OUT/raw/log.txt"
done
echo "done: $OUT"
