#!/usr/bin/env bash
# Reproduce the whole measurement ladder on a fresh clone.
#
#   BENCH_CPU=6 scripts/run_all.sh          # ~60-75 minutes
#
# Order matters: system discovery and perf-event discovery first (later steps
# read results/perf_events.json), native baselines before ResNet (the ResNet
# analysis reads the newest *_microbench/processed/machine_model.json).
# Each step writes its own timestamped results/<date>_<name>/ directory and
# never overwrites an earlier one.
set -euo pipefail
source "$(dirname "$0")/common.sh"
cd "$REPO_ROOT"

[[ -x .venv/bin/python ]] || scripts/setup_env.sh
make -C microbench -s all

echo "== system discovery";        scripts/collect_system_info.sh
echo "== perf event discovery";    "$PY" scripts/discover_perf_events.py
echo "== native microbenchmarks";  scripts/run_microbench.sh
echo "== counter validation";      scripts/run_counter_validation.sh
echo "== ResNet-50 baseline";      scripts/run_resnet_baseline.sh
echo "== backend path";            scripts/run_backend_probe.sh
echo "== instruction profile";     scripts/run_instruction_profile.sh
echo "== dispatch overhead";       scripts/run_dispatch_overhead.sh
echo "all done; see results/ and docs/RESULTS.md"
