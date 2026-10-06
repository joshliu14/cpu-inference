#!/usr/bin/env bash
# Multi-core experiments (after the single-core work): intra-op thread scaling
# and N independent instances. The unmodified baseline is always included;
# by default the fastest single-core variants from the latest optimization run
# are added (fastest overall + fastest eager-mode variant).
# usage: scripts/run_multicore.sh [OPT_DIR]
set -euo pipefail
source "$(dirname "$0")/common.sh"
OPT="${1:-$(ls -d "$REPO_ROOT"/results/*_optimizations* 2>/dev/null | tail -1)}"
if [[ -z "${VARIANTS:-}" ]]; then
    VARIANTS="baseline"
    if [[ -n "$OPT" && -f "$OPT/processed/opt_summary.json" ]]; then
        VARIANTS="baseline $("$PY" - "$OPT/processed/opt_summary.json" <<'PYEOF'
import json, sys
v = {k: d["latency_ms"]["median"] for k, d in json.load(open(sys.argv[1]))["variants"].items()
     if "latency_ms" in d and k != "baseline"}
best = min(v, key=v.get)
eager = min((k for k in v if k not in ("jit_freeze", "inductor")), key=v.get)
print(" ".join(dict.fromkeys([eager, best])))
PYEOF
)"
    fi
fi
export VARIANTS
OUT="$(make_result_dir multicore)"
echo "variants: $VARIANTS (from ${OPT:-none})" | tee "$OUT/raw/variants.txt"
"$REPO_ROOT/scripts/wait_quiet.sh" "$OUT/raw/quiet_gate.log"
"$REPO_ROOT/experiments/multicore.sh" "$OUT" 2>&1 | tee "$OUT/raw/multicore.log"
"$PY" "$REPO_ROOT/analysis/analyze_multicore.py" "$OUT" > /dev/null
echo "done: $OUT"
