#!/usr/bin/env bash
# System discovery: records the hardware/software configuration that every
# later measurement depends on. Output: results/<date>_system/
#
# Everything here is read-only. sudo is used only for read-only tools
# (dmidecode, turbostat) and only if it works without a password.
set -uo pipefail
source "$(dirname "$0")/common.sh"
OUT="$(make_result_dir system)"
R="$OUT/raw"
echo "writing to $OUT"

run() {  # run <outfile> <cmd...>; never abort discovery on a failing probe
    local f="$1"; shift
    { echo "\$ $*"; "$@"; } >"$R/$f" 2>&1 || echo "[exit $?]" >>"$R/$f"
}

run uname.txt uname -a
run os_release.txt cat /etc/os-release
run lscpu.txt lscpu
run lscpu_extended.txt lscpu --extended
run cpuinfo.txt cat /proc/cpuinfo
run numactl_hardware.txt numactl --hardware
run free.txt free -b
run meminfo.txt cat /proc/meminfo
# Kernel command line, with MAC addresses redacted.
sed -E 's/([0-9a-fA-F]{2}:){5}[0-9a-fA-F]{2}/<redacted-mac>/g' /proc/cmdline >"$R/cmdline.txt"

# Cache geometry straight from sysfs (per level, per CPU0 and the LLC sharing).
{
    for d in /sys/devices/system/cpu/cpu0/cache/index*; do
        printf "level=%s type=%s size=%s ways=%s line=%s sets=%s shared_cpu_list=%s\n" \
            "$(cat $d/level)" "$(cat $d/type)" "$(cat $d/size)" \
            "$(cat $d/ways_of_associativity)" "$(cat $d/coherency_line_size)" \
            "$(cat $d/number_of_sets)" "$(cat $d/shared_cpu_list)"
    done
} >"$R/cache_sysfs.txt"

# Frequency / power management.
{
    echo "online=$(cat /sys/devices/system/cpu/online) offline=$(cat /sys/devices/system/cpu/offline)"
    echo "scaling_driver=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver)"
    for f in /sys/devices/system/cpu/intel_pstate/*; do echo "intel_pstate/$(basename $f)=$(cat $f 2>/dev/null)"; done
    for c in $(seq 0 $(( $(nproc) - 1 ))); do
        p=/sys/devices/system/cpu/cpu$c/cpufreq
        echo "cpu$c governor=$(cat $p/scaling_governor) epp=$(cat $p/energy_performance_preference 2>/dev/null) min=$(cat $p/scaling_min_freq) max=$(cat $p/scaling_max_freq) base=$(cat $p/base_frequency 2>/dev/null) hw_max=$(cat $p/cpuinfo_max_freq) cur=$(cat $p/scaling_cur_freq)"
    done
    echo "--- cpuidle states (cpu0) ---"
    for d in /sys/devices/system/cpu/cpu0/cpuidle/state*; do
        echo "$(cat $d/name) latency_us=$(cat $d/latency) disable=$(cat $d/disable)"
    done
    echo "--- THP ---"
    echo "enabled: $(cat /sys/kernel/mm/transparent_hugepage/enabled)"
    echo "defrag:  $(cat /sys/kernel/mm/transparent_hugepage/defrag)"
} >"$R/frequency_power.txt" 2>&1
run cpupower_frequency_info.txt cpupower -c "$BENCH_CPU" frequency-info

# perf / PMU.
{
    echo "perf_version=$(perf --version)"
    for f in perf_event_paranoid perf_event_max_sample_rate perf_event_mlock_kb kptr_restrict nmi_watchdog; do
        echo "kernel.$f=$(cat /proc/sys/kernel/$f)"
    done
    echo "pmu_devices=$(ls /sys/bus/event_source/devices | tr '\n' ' ')"
    for f in /sys/bus/event_source/devices/cpu/caps/*; do echo "cpu/caps/$(basename $f)=$(cat $f)"; done
    echo "cpu/events: $(ls /sys/bus/event_source/devices/cpu/events | tr '\n' ' ')"
    echo "cpu/format:"; for f in /sys/bus/event_source/devices/cpu/format/*; do echo "  $(basename $f)=$(cat $f)"; done
} >"$R/perf_pmu.txt" 2>&1
perf list --no-desc >"$R/perf_list.txt" 2>&1

# Toolchain and Python stack.
{
    gcc --version | head -1
    g++ --version | head -1
    (clang --version 2>/dev/null | head -1) || echo "clang: not installed"
    objdump --version | head -1
    python3 --version
    "$PY" --version
    "$PY" - <<'EOF'
import torch, torchvision, numpy
print("torch", torch.__version__)
print("torchvision", torchvision.__version__)
print("numpy", numpy.__version__)
print("torch cpu capability", torch.backends.cpu.get_cpu_capability())
print("mkldnn available", torch.backends.mkldnn.is_available())
print("mkl available", torch.backends.mkl.is_available())
print(torch.__config__.show())
EOF
} >"$R/software.txt" 2>&1

# Privileged, read-only probes (only when sudo needs no password).
if sudo -n true 2>/dev/null; then
    # Serial numbers / asset tags are hardware identifiers, not research data.
    redact() { sed -E 's/^(\s*(Serial Number|Asset Tag|UUID|ID):).*/\1 <redacted>/'; }
    sudo -n dmidecode -t memory 2>&1 | redact >"$R/dmidecode_memory.txt"
    sudo -n dmidecode -t processor 2>&1 | redact >"$R/dmidecode_processor.txt"
    # One-second turbostat sample of the measurement CPU while it is busy.
    taskset -c "$BENCH_CPU" timeout 3 bash -c 'while :; do :; done' &
    sleep 0.5
    sudo -n turbostat --quiet --cpu "$BENCH_CPU" --show CPU,Avg_MHz,Busy%,Bzy_MHz,TSC_MHz,PkgWatt \
        --interval 1 --num_iterations 1 >"$R/turbostat_busy_cpu.txt" 2>&1
    wait
else
    echo "sudo requires a password; dmidecode/turbostat skipped" >"$R/privileged_skipped.txt"
fi

# Machine load at the time of discovery (aggregated; no other users' details).
{
    uptime
    echo "logged_in_sessions=$(who | wc -l)"
    mpstat -P ALL 2 1 2>/dev/null | grep -E "Average" || echo "mpstat unavailable"
} >"$R/load_snapshot.txt" 2>&1

# Background DRAM traffic with our own workload idle (socket-wide counters).
perf stat -a -e uncore_imc/cas_count_read/,uncore_imc/cas_count_write/ -- sleep 2 \
    >"$R/background_dram_traffic.txt" 2>&1

"$PY" "$REPO_ROOT/scripts/summarize_system.py" "$OUT"
echo "done: $OUT"
