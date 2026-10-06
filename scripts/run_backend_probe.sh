#!/usr/bin/env bash
# Which library/kernel runs each ResNet-50 operator? (ATen chain, oneDNN and
# MKL verbose logs, shared-library symbols). Output: results/<date>_backend/
set -euo pipefail
source "$(dirname "$0")/common.sh"
single_thread_env
OUT="$(make_result_dir backend)"
"$PY" "$REPO_ROOT/experiments/backend_probe.py" --cpu "$BENCH_CPU" --out "$OUT"
LIB="$("$PY" -c 'import torch, os; print(os.path.join(os.path.dirname(torch.__file__), "lib", "libtorch_cpu.so"))')"
{
    echo "# $LIB"
    readelf -h "$LIB" | grep -E "Class|Machine|Type"
    echo "# section sizes (.text = machine code)"
    readelf -S -W "$LIB" | grep -E " \.text| \.rodata| \.data " || true
    echo "# symbol table present?"; readelf -S -W "$LIB" | grep -cE "\.symtab" || true
} >"$OUT/raw/libtorch_cpu_elf.txt" 2>&1
# Kernels per CPU capability (ATen compiles some files once per ISA level).
nm -C --defined-only "$LIB" 2>/dev/null | grep -E "max_pool|batch_norm|clamp_min|relu|add_kernel|cpu_max_pool" \
    | grep -oE "at::native::(DEFAULT|AVX2|AVX512|[A-Za-z_]+)::[^ (]*" | sort | uniq -c | sort -rn | head -80 \
    >"$OUT/raw/aten_kernel_symbols_by_capability.txt" || true
nm -C --defined-only "$LIB" 2>/dev/null | grep -iE "mkl_blas_.*sgemm|sgemm_kernel" | awk '{print $3}' \
    | sed -E 's/_[0-9]+$//' | sort | uniq -c | sort -rn | head -60 >"$OUT/raw/mkl_sgemm_symbols.txt" || true
nm -C --defined-only "$LIB" 2>/dev/null | grep -E "dnnl::impl::cpu::x64::.*(jit_avx512_core_conv|brgemm|jit_uni_reorder|jit_avx512_core_f32)" \
    | awk '{$1=$2=""; print}' | sed -E 's/\(.*//' | sort -u | head -80 >"$OUT/raw/onednn_x64_symbols.txt" || true
echo "done: $OUT"
