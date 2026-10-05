#!/usr/bin/env python3
"""Turn the raw files from collect_system_info.sh into system.json + SYSTEM.md."""
import json
import re
import sys
from pathlib import Path


def read(p: Path) -> str:
    return p.read_text(errors="replace") if p.exists() else ""


def grab(text: str, pattern: str, default="UNAVAILABLE"):
    m = re.search(pattern, text, re.M)
    return m.group(1).strip() if m else default


def main(out_dir: str) -> None:
    out = Path(out_dir)
    raw = out / "raw"
    lscpu = read(raw / "lscpu.txt")
    freq = read(raw / "frequency_power.txt")
    perf = read(raw / "perf_pmu.txt")
    sw = read(raw / "software.txt")
    dmi = read(raw / "dmidecode_memory.txt")
    turbo = read(raw / "turbostat_busy_cpu.txt")
    bg = read(raw / "background_dram_traffic.txt")

    caches = []
    for line in read(raw / "cache_sysfs.txt").splitlines():
        caches.append(dict(kv.split("=", 1) for kv in line.split()))

    dimm_speeds = re.findall(r"Configured Memory Speed: (\d+) MT/s", dmi)
    dimm_sizes = re.findall(r"^\s+Size: (\d+) GB", dmi, re.M)
    dimm_type = grab(dmi, r"^\s+Type: (DDR\d)")
    n_dimms = len(dimm_sizes)
    cfg_mts = int(dimm_speeds[0]) if dimm_speeds else None
    # One DDR5 DIMM per channel here, 64 data bits (8 bytes) per channel per transfer.
    peak_dram_gbs = n_dimms * cfg_mts * 8 / 1000 if cfg_mts else None

    bzy = None
    m = re.search(r"^\s*\d+\s+(\d+)\s+([\d.]+)\s+(\d+)\s+(\d+)", turbo, re.M)
    if m:
        bzy = {"cpu_avg_mhz": int(m.group(1)), "busy_pct": float(m.group(2)),
               "bzy_mhz": int(m.group(3)), "tsc_mhz": int(m.group(4))}

    bg_read = grab(bg, r"([\d,.]+) MiB\s+uncore_imc/cas_count_read/")
    bg_write = grab(bg, r"([\d,.]+) MiB\s+uncore_imc/cas_count_write/")
    bg_secs = grab(bg, r"([\d.]+) seconds time elapsed")

    info = {
        "kernel": grab(read(raw / "uname.txt"), r"^(Linux .*)$"),
        "os": grab(read(raw / "os_release.txt"), r'^PRETTY_NAME="(.*)"'),
        "cpu_model": grab(lscpu, r"^Model name:\s+(.*)$"),
        "cpu_family_model_stepping": [grab(lscpu, r"^CPU family:\s+(\d+)"),
                                      grab(lscpu, r"^Model:\s+(\d+)"),
                                      grab(lscpu, r"^Stepping:\s+(\d+)")],
        "sockets": grab(lscpu, r"^Socket\(s\):\s+(\d+)"),
        "cores_per_socket": grab(lscpu, r"^Core\(s\) per socket:\s+(\d+)"),
        "threads_per_core": grab(lscpu, r"^Thread\(s\) per core:\s+(\d+)"),
        "online_cpus": grab(lscpu, r"^On-line CPU\(s\) list:\s+(.*)$"),
        "offline_cpus": grab(lscpu, r"^Off-line CPU\(s\) list:\s+(.*)$"),
        "numa_nodes": grab(lscpu, r"^NUMA node\(s\):\s+(\d+)"),
        "caches_cpu0": caches,
        "isa_flags_of_interest": sorted(
            f for f in grab(lscpu, r"^Flags:\s+(.*)$", "").split()
            if re.match(r"(sse|avx|fma|amx|f16c|bmi)", f)),
        "frequency": {
            "driver": grab(freq, r"^scaling_driver=(.*)$"),
            "governor_cpu0": grab(freq, r"^cpu0 governor=(\S+)"),
            "epp_cpu0": grab(freq, r"^cpu0 governor=\S+ epp=(\S+)"),
            "no_turbo": grab(freq, r"^intel_pstate/no_turbo=(.*)$"),
            "scaling_max_khz": grab(freq, r"^cpu0 .* max=(\d+)"),
            "base_khz": grab(freq, r"^cpu0 .* base=(\d+)"),
            "hw_max_khz": grab(freq, r"^cpu0 .* hw_max=(\d+)"),
            "turbostat_busy_cpu": bzy or "UNAVAILABLE",
        },
        "thp": grab(freq, r"^enabled: (.*)$"),
        "memory": {
            "total_bytes": grab(read(raw / "free.txt"), r"^Mem:\s+(\d+)"),
            "dimm_type": dimm_type,
            "dimm_count": n_dimms,
            "dimm_size_gb": dimm_sizes[0] if dimm_sizes else "UNAVAILABLE",
            "configured_mts": cfg_mts or "UNAVAILABLE",
            "rated_mts": grab(dmi, r"^\s+Speed: (\d+) MT/s"),
            "theoretical_peak_gbs_socket": peak_dram_gbs or "UNAVAILABLE",
        },
        "background_dram_traffic_idle": {
            "read_MiB": bg_read, "write_MiB": bg_write, "seconds": bg_secs,
            "note": "socket-wide uncore IMC counters with our workload idle; "
                    "includes other users' activity",
        },
        "perf": {
            "version": grab(perf, r"^perf_version=(.*)$"),
            "perf_event_paranoid": grab(perf, r"^kernel.perf_event_paranoid=(.*)$"),
            "kptr_restrict": grab(perf, r"^kernel.kptr_restrict=(.*)$"),
            "nmi_watchdog": grab(perf, r"^kernel.nmi_watchdog=(.*)$"),
            "core_pmu_name": grab(perf, r"^cpu/caps/pmu_name=(.*)$"),
            "max_precise": grab(perf, r"^cpu/caps/max_precise=(.*)$"),
            "pmu_devices": grab(perf, r"^pmu_devices=(.*)$").split(),
        },
        "software": {
            "gcc": grab(sw, r"^(gcc .*)$"),
            "python": grab(sw, r"^(Python 3.*)$"),
            "torch": grab(sw, r"^torch (\S+)"),
            "torchvision": grab(sw, r"^torchvision (\S+)"),
            "numpy": grab(sw, r"^numpy (\S+)"),
            "torch_cpu_capability": grab(sw, r"^torch cpu capability (\S+)"),
            "mkl": grab(sw, r"Math Kernel Library Version (\S+)"),
            "onednn": grab(sw, r"MKL-DNN (v[\d.]+)"),
        },
    }
    # Collapse uncore PMU instance lists for readability.
    devs = info["perf"]["pmu_devices"]
    collapsed = {}
    for d in devs:
        key = re.sub(r"_\d+$", "_N", d)
        collapsed[key] = collapsed.get(key, 0) + 1
    info["perf"]["pmu_devices"] = collapsed

    (out / "system.json").write_text(json.dumps(info, indent=2) + "\n")

    c = {x["level"] + x["type"][0]: x for x in caches}
    md = [
        "# System configuration",
        "",
        "Generated by `scripts/collect_system_info.sh`. Raw probe output is in `raw/`.",
        "",
        "| Item | Value |",
        "|---|---|",
        f"| CPU | {info['cpu_model']} (family/model/stepping {'/'.join(info['cpu_family_model_stepping'])}) |",
        f"| Topology | {info['sockets']} socket, {info['cores_per_socket']} cores, {info['threads_per_core']} thread/core; online {info['online_cpus']}, offline {info['offline_cpus']} |",
        f"| NUMA nodes | {info['numa_nodes']} |",
    ]
    for k, label in (("1D", "L1d"), ("1I", "L1i"), ("2U", "L2"), ("3U", "L3")):
        if k in c:
            x = c[k]
            md.append(f"| {label} | {x['size']} per instance, {x['ways']}-way, {x['line']} B line, shared by CPUs {x['shared_cpu_list']} |")
    f = info["frequency"]
    md += [
        f"| Frequency control | driver {f['driver']}, governor {f['governor_cpu0']}, EPP {f['epp_cpu0']}, no_turbo={f['no_turbo']} |",
        f"| Frequency limits | scaling max {f['scaling_max_khz']} kHz, base {f['base_khz']} kHz, hardware max {f['hw_max_khz']} kHz |",
        f"| Measured busy frequency | {f['turbostat_busy_cpu']} |",
        f"| Memory | {info['memory']['dimm_count']} x {info['memory']['dimm_size_gb']} GB {info['memory']['dimm_type']}, configured {info['memory']['configured_mts']} MT/s (rated {info['memory']['rated_mts']}) |",
        f"| Theoretical DRAM peak (socket) | {info['memory']['theoretical_peak_gbs_socket']} GB/s (CALCULATED: DIMMs x MT/s x 8 B) |",
        f"| Background DRAM traffic (idle) | read {bg_read} MiB, write {bg_write} MiB over {bg_secs} s |",
        f"| THP | {info['thp']} |",
        f"| Kernel / OS | {info['kernel']} / {info['os']} |",
        f"| perf | {info['perf']['version']}, paranoid={info['perf']['perf_event_paranoid']}, kptr_restrict={info['perf']['kptr_restrict']}, nmi_watchdog={info['perf']['nmi_watchdog']} |",
        f"| Core PMU | {info['perf']['core_pmu_name']}, max_precise={info['perf']['max_precise']} |",
        f"| Toolchain | {info['software']['gcc']}; {info['software']['python']} |",
        f"| PyTorch | torch {info['software']['torch']}, torchvision {info['software']['torchvision']}, ATen capability {info['software']['torch_cpu_capability']}, MKL {info['software']['mkl']}, oneDNN {info['software']['onednn']} |",
        "",
        "ISA flags of interest: " + " ".join(info["isa_flags_of_interest"]),
        "",
        "PMU devices: " + ", ".join(f"{k} x{v}" for k, v in sorted(collapsed.items())),
        "",
    ]
    (out / "SYSTEM.md").write_text("\n".join(md))
    print("\n".join(md))


if __name__ == "__main__":
    main(sys.argv[1])
