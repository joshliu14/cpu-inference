#!/usr/bin/env bash
# Inter-op re-run with and without OpenMP thread binding.
#
# The mc_study inter-op runs set OMP_PROC_BIND=close. That binds the main
# thread to one core; PyTorch's inter-op pool threads are created later and
# may inherit that one-core mask, so inter-op work could not use the extra
# cores. This re-runs each setting with OMP_PROC_BIND=close and with no
# binding (process confined only by taskset), and records every thread's
# allowed CPUs (experiments/interop_graph.py, "thread_cpus").
#
# usage: scripts/run_interop_rerun.sh OUT_DIR   (e.g. results/2026-10-06_mc_study/interop_rerun)
set -uo pipefail
cd "$(dirname "$0")/.."
OUT="$1"
mkdir -p "$OUT/raw"
for bind in close none; do
    for KI in 1:1 1:2 1:4 2:2 4:2; do
        K=${KI%:*}; I=${KI#*:}; N=$((K * I))
        for mode in eager fork_traced; do
            name="interop_${bind}_${mode}_K${K}_I${I}"
            [ -f "$OUT/raw/$name.json" ] && continue
            until [ "$(taskset -c 27 scripts/other_cpu.sh)" -lt 100 ]; do sleep 20; done
            if [ "$bind" = close ]; then B=(OMP_PROC_BIND=close OMP_PLACES=cores); else B=(); fi
            env OMP_NUM_THREADS="$K" MKL_NUM_THREADS="$K" KMP_AFFINITY=disabled "${B[@]}" \
                taskset -c "$(seq -s, 1 "$N")" .venv/bin/python experiments/interop_graph.py \
                --mode "$mode" --intra "$K" --inter "$I" --out "$OUT" --name "$name" \
                > "$OUT/raw/$name.log" 2>&1
            other=$(taskset -c 27 scripts/other_cpu.sh)
            echo "$(date +%T) $name other_after=${other}%"
        done
    done
done
echo "done: interop rerun"
