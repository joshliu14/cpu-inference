# Hardware Guide: the machine under our measurements

This project measures single-core, batch-1, FP32 ResNet-50 inference in PyTorch on one
Intel Xeon Gold 5512U core, starting at Python and going down to the microarchitecture.
This guide explains that CPU one concept at a time. For each concept it covers how the
concept shows up in the numbers this repository collects, and which counter, plot or
microbenchmark measures it.

It is written for readers who know programming and basic computer architecture (caches,
pipelines, virtual memory) but are still learning detailed CPU performance analysis.

## How to read this guide

Every factual statement carries one of these labels:

| Label | Meaning |
|---|---|
| **OBSERVED** | Measured or read on this machine and saved under `results/` (source given). |
| **OBSERVED (live)** | Read from CPUID or sysfs on this machine on 2026-10-06 while this guide was written (lightweight reads only). Not yet saved under `results/`. |
| **CALCULATED** | Arithmetic on observed or documented numbers. The formula is shown. |
| **INFERRED** | An explanation that fits the data but is not proven by it. |
| **DOCUMENTED** | Taken from vendor documentation or published microarchitecture descriptions (Intel, Golden Cove/Raptor Cove). Not verified here. |

Source keys (all paths are relative to the repository root):

| Key | Path |
|---|---|
| SYS | `results/2026-10-05_system/SYSTEM.md`, `results/2026-10-05_system/system.json` |
| RAW | `results/2026-10-05_system/raw/` (`lscpu.txt`, `cpuinfo.txt`, `cache_sysfs.txt`, `dmidecode_memory.txt`, `turbostat_busy_cpu.txt`, `frequency_power.txt`, `perf_pmu.txt`, `perf_list.txt`, `background_dram_traffic.txt`, `numactl_hardware.txt`, `meminfo.txt`) |
| MM | `results/2026-10-05_microbench/processed/machine_model.json` |
| CMP, LAT, BW, AI, FLG | `results/2026-10-05_microbench/processed/{compute,memlat,membw,intensity,flags}_summary.csv` |
| PLOT | `results/2026-10-05_microbench/plots/` |
| ASM | `results/2026-10-05_microbench/asm/` (objdump of the benchmark binaries) |
| SRC | `microbench/src/` (`compute.cpp`, `memlat.cpp`, `membw.cpp`, `intensity.cpp`, `flags_kernels.c`, `common.h`) |
| EV | `results/perf_events.json` (readable copy: `results/perf_events.md`) |
| BASE | `results/2026-10-06_resnet_baseline/raw/`: **preliminary** ResNet-50 counter data. It is used here only for illustration, and the canonical analysis will replace it. |

Units: at the fixed 2.1 GHz clock, 1 cycle = 1 / 2.1 GHz = 0.476 ns (CALCULATED). "B/cycle"
means bytes per core clock cycle. GB/s values are decimal (10^9 B/s).

## Contents

1. [The machine at a glance](#1-the-machine-at-a-glance)
2. [Clocks, frequency and power](#2-clocks-frequency-and-power)
3. [Cores and SMT](#3-cores-and-smt)
4. [A map of one core](#4-a-map-of-one-core)
5. [Registers and SIMD widths](#5-registers-and-simd-widths)
6. [Execution ports and units](#6-execution-ports-and-units)
7. [Out-of-order execution: latency versus throughput](#7-out-of-order-execution-latency-versus-throughput)
8. [Vector width, FMA and counting FLOPs](#8-vector-width-fma-and-counting-flops)
9. [Loads, stores and the load/store buffers](#9-loads-stores-and-the-loadstore-buffers)
10. [The cache hierarchy](#10-the-cache-hierarchy)
11. [TLBs and page size: why 4 KiB and 2 MiB pages measure differently](#11-tlbs-and-page-size-why-4-kib-and-2-mib-pages-measure-differently)
12. [Memory-level parallelism and Little's law for bandwidth](#12-memory-level-parallelism-and-littles-law-for-bandwidth)
13. [The memory subsystem: channels, IMC and CAS counts](#13-the-memory-subsystem-channels-imc-and-cas-counts)
14. [Speculation and branch prediction](#14-speculation-and-branch-prediction)
15. [Retirement, the 6-slot pipeline and top-down analysis](#15-retirement-the-6-slot-pipeline-and-top-down-analysis)
16. [The performance monitoring unit (PMU)](#16-the-performance-monitoring-unit-pmu)
17. [AMX: present, unused by FP32 inference](#17-amx-present-unused-by-fp32-inference)
18. [Cheat sheet](#18-cheat-sheet)
19. [Open questions and unverified points](#19-open-questions-and-unverified-points)

---

## 1. The machine at a glance

| Item | Value | Label / source |
|---|---|---|
| CPU | INTEL(R) XEON(R) GOLD 5512U, family 6, model 207 (0xCF), stepping 2, microcode 0x210002e0 | OBSERVED: SYS, RAW `cpuinfo.txt` |
| Generation | Model 0xCF is Emerald Rapids (5th-gen Xeon Scalable), whose cores are Raptor Cove, a refinement of Golden Cove. The kernel PMU driver reports `pmu_name=sapphire_rapids` because both generations share the same core PMU. | Model/pmu_name OBSERVED: RAW `perf_pmu.txt`. Generation mapping DOCUMENTED |
| Topology | 1 socket, 28 cores, 1 thread/core; CPUs 0-27 online, 28-55 offline; 1 NUMA node | OBSERVED: SYS, RAW `lscpu.txt`, `numactl_hardware.txt` |
| Clock | Turbo disabled, governor `performance`, 2.1 GHz base = scaling max (hardware max 3.7 GHz is unused) | OBSERVED: RAW `frequency_power.txt` |
| L1d / L1i | 48 KiB 12-way / 32 KiB 8-way per core, 64 B lines | OBSERVED: RAW `cache_sysfs.txt` |
| L2 | 2 MiB 16-way per core (private) | OBSERVED: RAW `cache_sysfs.txt` |
| L3 | 52.5 MiB (53760 KiB) 15-way, shared by all 28 cores | OBSERVED: RAW `cache_sysfs.txt` |
| DRAM | 8 x 16 GB DDR5 RDIMM (ECC, single rank), rated 5600 MT/s, configured 4800 MT/s, one DIMM in each of 8 channels | OBSERVED: RAW `dmidecode_memory.txt` |
| DRAM peak | 8 channels x 4800 MT/s x 8 B = 307.2 GB/s for the whole socket | CALCULATED: SYS |
| ISA | AVX-512 (F, DQ, BW, VL, VNNI, BF16, FP16, ...), FMA, AVX2, AMX (tile, bf16, int8) | OBSERVED: SYS |
| Software | perf 6.8.12, gcc 13.3.0, torch 2.14.1+cpu (CPU capability AVX512), oneDNN v3.12.0, MKL 2024.2 | OBSERVED: SYS |

The measured performance numbers are collected in the [cheat sheet](#18-cheat-sheet) at the end.

---

## 2. Clocks, frequency and power

**What it is.** The core clock sets how long a cycle lasts. Modern CPUs change it all the
time (turbo, power limits, AVX-512 frequency offsets), and that makes time-based
measurements noisy. On this machine the clock has been pinned.

| Setting | Value | Label / source |
|---|---|---|
| Driver / governor / EPP | `intel_pstate` active, `performance`, `performance` | OBSERVED: RAW `frequency_power.txt` |
| Turbo | `intel_pstate/no_turbo=1` | OBSERVED: same |
| Limits | min 0.8 GHz, scaling max 2.1 GHz = base 2.1 GHz, hardware max 3.7 GHz | OBSERVED: same |
| Busy core (turbostat on CPU 6) | Bzy_MHz 2100, TSC_MHz 2100, Avg_MHz 2095 at 99.77% busy, PkgWatt 89.92 W | OBSERVED: RAW `turbostat_busy_cpu.txt` |
| Frequency during microbenchmarks | 2.0954 GHz for every compute variant, including AVX-512 FMA | OBSERVED: CMP `freq_ghz_median`; MM `freq_ghz_during_avx512` = 2.095 |
| Uncore (mesh/L3) frequency | min = max = 2.5 GHz (fixed) | OBSERVED (live): `/sys/devices/system/cpu/intel_uncore_frequency/package_00_die_00/` |
| Idle states | POLL, C1 (1 us exit), C1E (2 us), C6 (290 us), all enabled | OBSERVED: RAW `frequency_power.txt` |

**How it shows up in our measurements.**

- *Cycles equal time.* With the clock fixed, `cycles / 2.1e9` is CPU time (EV
  interpretation of `cycles`). The project reports most results per cycle (B/cycle,
  FLOP/cycle) because cycles measure the work the core did, not the wall clock.
- *Checking frequency.* `ref-cycles` counts at the constant TSC rate (2.1 GHz). The
  frequency is `cycles / ref_cycles x 2.1 GHz`, computed as `freq_ghz` in
  `cpuinf/metrics.py` and in `analysis/analyze_microbench.py`. A value well below 2.1 means
  throttling or a frequency change, and the run should be treated with suspicion.
- *No AVX-512 frequency drop observed.* Intel documents lower frequencies for heavy
  AVX-512 code on Xeon parts (DOCUMENTED). With turbo off and one busy core we measure
  2.095 GHz under 512-bit FMAs, the same as under scalar code (OBSERVED, CMP). We have not
  tested many cores running AVX-512 at the same time.
- *The 0.2% gap* between 2.095 and 2.100 GHz is constant across runs (OBSERVED). We have
  not investigated it. A reference clock with spread-spectrum modulation is one possible
  cause (INFERRED). `cpupower` reports "boost ... Active: yes" even though `no_turbo=1`
  (RAW `cpupower_frequency_info.txt`). The measured Bzy_MHz of 2100 shows that turbo is
  in fact off.
- *Uncore clock.* The mesh, the L3 slices and the memory controllers run on the uncore
  clock, not the core clock (DOCUMENTED). L3 and DRAM latencies in core cycles therefore
  depend on both clocks. The uncore clock is fixed at 2.5 GHz here (OBSERVED, live), which
  removes one source of variance. `scripts/collect_system_info.sh` does not record it yet.
- *Idle states.* The benchmark loops never idle. A core that sleeps between inferences
  could enter C6, and the next inference would pay the wake-up latency. It would probably
  also start with cold private caches (INFERRED; DOCUMENTED that core C6 does not keep
  L1/L2 contents). This matters when interpreting end-to-end latency loops.
- *PkgWatt* covers the whole package, other users included. It is not a per-inference
  energy figure.

---

## 3. Cores and SMT

**What it is.** The package has 28 physical cores. Each core can run two hardware threads
(SMT, "Hyper-Threading"): dmidecode reports Thread Count 56 (RAW `dmidecode_processor.txt`).
Linux has turned SMT off. CPUs 28-55 are offline (RAW `lscpu.txt`) and
`/sys/devices/system/cpu/smt/control` = `off` (OBSERVED, live).

**Why SMT off matters for our counters.**

1. **The core belongs to our thread.** The front end, the reorder buffer, the execution
   ports, L1, L2, the TLBs and the fill buffers are all private to a core. With no
   sibling thread, a per-thread counter describes the whole core, and no other thread
   can evict our L1/L2 lines or take our ports.
2. **PMU capacity.** CPUID leaf 0xA reports 8 general-purpose counters per logical
   processor (OBSERVED, live), and the pass planner in `cpuinf/events.py` assumes 8. On
   older Intel cores, turning SMT on split counter resources between the two threads
   (DOCUMENTED for earlier generations). We cannot test that here because SMT is off.
3. **Top-down slots are a core resource.** With SMT on, two threads compete for the same
   6 issue slots per cycle, and per-thread top-down fractions need special handling
   (DOCUMENTED, Intel TMA notes). With SMT off, slots = 6 x our cycles (section 15).
4. **Some resources stay shared.** L3, the mesh and the memory controllers are shared with
   27 other cores and with other users of this machine. The microbenchmark runs recorded
   1-minute load averages of 0.35 (start) and 1.04 (end) with 7 users logged in
   (`results/2026-10-05_microbench/raw/machine_state_*.txt`). L1/L2-level results are
   quiet. L3- and DRAM-level results can be disturbed by neighbours (INFERRED).

All benchmarks are pinned to CPU 6. `scripts/common.sh` sets `BENCH_CPU=6` because CPUs 0
and 27 receive more interrupts. The `cpu-migrations` counter must read 0 and
`context-switches` about 0 (EV).

---

## 4. A map of one core

The core is a Golden Cove-class out-of-order core (DOCUMENTED). Port numbers below follow
the PMU event names in EV. Other sources number some ports differently.

```
 FRONT END  branch predictor steers fetch -> L1i 32 KiB (+ ITLB)
            uops come from: legacy decoders (MITE) | uop cache (DSB) |
                            loop stream detector (LSD) | microcode sequencer (MS)
                 |   idq.mite_uops / idq.dsb_uops / lsd.uops / idq.ms_uops
                 v
 ALLOCATE   rename + allocate: 6 slots per cycle   <- top-down accounting is done here
            each uop gets a ROB entry; loads/stores also get a load/store-buffer entry
                 v
 EXECUTE    scheduler -> ports  0, 1, 5+11, 6 : integer ALUs; vector units
                                0(+1) and 5   : the two 512-bit FMA pipes
                                2, 3, 10      : load address generation
                                7, 8 / 4, 9   : store address / store data
            loads -> L1d 48 KiB -> L2 2 MiB -> (mesh) L3 52.5 MiB shared -> DRAM
                 v
 RETIRE     reorder buffer retires uops in program order; "retired" events count here
            (instructions, fp_arith_inst_retired.*, mem_inst_retired.*, mem_load_retired.*)
```

The sections below go through the diagram from top to bottom.

---

## 5. Registers and SIMD widths

| Register file (architectural) | Count x width | Notes | Label |
|---|---|---|---|
| General-purpose (rax ... r15) | 16 x 64-bit | rsp holds the stack pointer, so 15 are usable for data | DOCUMENTED (x86-64 ISA) |
| Vector (zmm0-zmm31) | 32 x 512-bit | xmm (128-bit) and ymm (256-bit) are the low parts of zmm. AVX-512 doubled the count from 16 to 32. | DOCUMENTED |
| Mask (k0-k7) | 8 x 64-bit | Per-lane predicates for AVX-512 (k0 as a write mask means "no mask") | DOCUMENTED |
| AMX tiles | 8 x 1 KiB | See section 17 | DOCUMENTED |

FP32 lanes per instruction: scalar 1, xmm 4, ymm 8, zmm 16. Renaming maps these
architectural registers onto a much larger physical register file (DOCUMENTED; sizes not
quoted here).

**How it shows up in our measurements.**

- `compute.cpp` keeps every accumulator in a register so that only the arithmetic is
  timed. The source comments say the absence of memory operands was checked in the
  objdump listing (`ASM/compute.asm`). Integer kernels stop at K = 12 chains because
  16 accumulators plus a constant need more than the 15 usable GPRs and would spill to
  the stack (SRC `compute.cpp`, OBSERVED design constraint).
- `common.h` has register-only "sinks" (`keep_in_reg_v`) because a memory-operand
  alternative made GCC keep accumulators on the stack. That adds store-forwarding latency
  to every chain (SRC `common.h`).
- The width actually used is visible in two ways: dynamically through the
  `fp_arith_inst_retired.{scalar,128b,256b,512b}_packed_single` counters (EV), and
  statically through the register names in disassembly (`analysis/analyze_instructions.py`).
- Compiler defaults matter. GCC at `-O3 -march=native` emitted ymm (256-bit) code for
  saxpy and relu and switched to zmm only with `-mprefer-vector-width=512`
  (FLG: `O3_native` zmm=0, `O3_native_zmm` zmm=6). Plot: `PLOT/compiler_flags.png`.
  PyTorch reports CPU capability AVX512 and oneDNN generates its own AVX-512 code
  (OBSERVED: SYS), so the compiler default does not limit the ResNet kernels.

---

## 6. Execution ports and units

A uop runs on one *port*, and each port feeds a group of execution units. When a
workload saturates one port group, the bottleneck is "core bound" even if memory is fast.

| Ports (PMU naming) | Event (EV key) | Main units (DOCUMENTED, Golden Cove-class server core) | What we measured (OBSERVED) |
|---|---|---|---|
| 0 | `uops_dispatched.port_0` (`port0`) | integer ALU, vector ALU/FMA. For 512-bit uops the port-0 and port-1 vector units work together as one 512-bit pipe | with port 5: 2 FMA/cycle at 512 bits |
| 1 | `uops_dispatched.port_1` (`port1`) | integer ALU incl. `imul`, vector ALU/FMA for at most 256 bits | `imul`: 3-cycle latency, 1/cycle |
| 5 and 11 | `uops_dispatched.port_5_11` (`port5`) | integer ALU, shuffles, second 512-bit FMA (server parts) | (second FMA pipe) |
| 6 | `uops_dispatched.port_6` (`port6`) | integer ALU, branches | |
| 2, 3, 10 | `uops_dispatched.port_2_3_10` (`port_load`) | load address generation: 3 loads/cycle, at most 2 of them 512-bit | L1 read 120.3 B/cycle, about 2 x 64 B |
| 7, 8 | `uops_dispatched.port_7_8` (`port_sta`) | store address | |
| 4, 9 | `uops_dispatched.port_4_9` (`port_std`) | store data | L1 write 63.85 B/cycle = one 64 B store/cycle |

Per-port rates are the `port*_per_cycle` values in `cpuinf/metrics.py`.
`exe_activity.1_ports_util` and `2_ports_util` count cycles with low execution parallelism.

**Throughput results** (CMP, OBSERVED; plot `PLOT/compute_chains.png`):

| Operation | Latency (K = 1) | Max throughput | Implies |
|---|---|---|---|
| FP32 FMA, scalar / SSE / AVX2 / AVX-512 | 4.01 cycles | 2.0 per cycle | two FMA pipes, both 512-bit capable |
| FP32 mul (scalar, AVX-512) | 4.01 cycles | 2.0 per cycle | mul runs on the FMA pipes |
| FP32 add, scalar | 2.00 cycles | 2.0 per cycle | a faster adder path (DOCUMENTED: Golden Cove has dedicated FP adders) |
| FP32 add, AVX-512 | 3.43 cycles | 2.0 per cycle | between 2 and 4; see below |
| Integer add | 1.00 cycle | 4.89 per cycle | about 5 integer ALUs |
| Integer imul | 3.01 cycles | 1.0 per cycle | one multiplier port |

*Worked example: integer adds per cycle (CALCULATED).* The `int_add<12>` loop body
(`ASM/compute.asm`) has 96 `add` instructions plus `inc r10` and a macro-fused
`cmp/jne`, so 98 uops, all of which need an integer ALU. With 5 ALU ports (DOCUMENTED),
one iteration takes 98 / 5 = 19.6 cycles, which is 96 / 19.6 = **4.90 adds/cycle**. We
measure 4.89. The 5th integer port is real, and the loop overhead explains the shortfall
from 5.

*The 3.43-cycle 512-bit add* is INFERRED to come from 512-bit adds being scheduled
sometimes onto a 2-cycle adder and sometimes onto a 4-cycle FMA pipe, giving a latency
between the two. Counting `port0` versus `port5` on `fp32_avx512_add` with K = 1 would
test this. Treat it as unexplained until then.

*Worked example from ResNet-50 (BASE, preliminary).* For `conv1` (median of 30
iterations, `inmodel_ports.0.csv`): port 0 runs 0.80 uops/cycle, port 5 0.86, port 1 0.03,
and the load ports 1.71. The two 512-bit FMA pipes are both busy, while port 1 is almost
idle because its vector half is part of the fused 512-bit pipe on port 0.

---

## 7. Out-of-order execution: latency versus throughput

**Concepts.** *Latency* is the number of cycles until a result can be used by the next
instruction. *Throughput* is how many such instructions can start per cycle. An
out-of-order core keeps a window of decoded uops (the reorder buffer, ROB) and runs any
uop whose inputs are ready, so independent work fills the gaps left by long latencies.
The ROB has 512 entries (DOCUMENTED (Intel, Golden Cove), not measured here).

**The chain-count experiment** (SRC `compute.cpp`; CMP; `PLOT/compute_chains.png`).
Each kernel runs K independent dependency chains. With K = 1 every instruction waits for
the previous one, so time per op equals the latency. As K grows, chains overlap until the
ports saturate.

| K chains (AVX-512 FMA) | 1 | 2 | 4 | 6 | 8 | 10 | 12 | 16 |
|---|---|---|---|---|---|---|---|---|
| cycles per FMA | 4.008 | 2.004 | 1.002 | 0.668 | 0.509 | 0.502 | 0.501 | 0.501 |
| FMAs per cycle | 0.250 | 0.499 | 0.998 | 1.497 | 1.966 | 1.991 | 1.996 | 1.995 |

*Worked example: Little's law for FMA chains (CALCULATED).* Little's law says
*work in flight = throughput x latency*. To keep 2 FMA/cycle going when each takes 4
cycles, 2 x 4 = **8 independent FMAs** must be in flight. The table agrees: K = 8 reaches
98% of peak, and K >= 10 saturates. The same rule predicts the other curves:

| Operation | latency x throughput = chains needed | Observed (CMP) |
|---|---|---|
| scalar FP add | 2 x 2 = 4 | K = 4 already gives 1.93/cycle |
| imul | 3 x 1 = 3 | K = 2 gives 0.665 (= 2/3), K = 4 gives 1.0 |
| int add | 1 x 5 = 5 | approaches 4.9 more slowly because the loop overhead also needs ALUs |

This is why optimized convolution kernels (oneDNN) keep many independent accumulators,
for example several output vectors per inner loop (DOCUMENTED design practice). A
single accumulator would run at 1/8 of peak (CALCULATED).

*The same effect in compiled code* (FLG; `PLOT/compiler_flags.png`). A `dot` product
`s += x[i]*y[i]` at `-O2`, `-O3` and `-O3 -march=native` runs at 1.93-1.95 cycles per
element. That matches the 2-cycle scalar add latency, because every addition depends on
`s`. Strict FP semantics forbid the compiler from reordering the sum. With `-ffast-math`
the compiler may reassociate it into many vector accumulators, and the loop runs at
0.177 cycles/element, about 11x faster (OBSERVED; the explanation is DOCUMENTED compiler
behaviour).

*Worked example: why the ROB cannot hide DRAM (CALCULATED from OBSERVED latency and
DOCUMENTED ROB size).* Hiding one DRAM miss of about 208 cycles (2 MiB pages, MM) at
6 uops/cycle would take about 1250 uops of independent work in flight. The ROB holds 512.
The window fills, allocation stalls, and the cycles show up as *Backend Bound -> Memory
Bound* in top-down and in `memory_activity.stalls_l3_miss` (EV). An L2 hit (16 x 6 = 96
uops) is easily hidden. An L3 hit (63 x 6 = 378 uops) is hidden only when there is
plenty of independent work.

Related counters (EV): `uops_issued.any`, `uops_executed.thread`,
`cycle_activity.stalls_total`, `exe_activity.bound_on_loads`, and the top-down
`topdown-be-bound` / `topdown-mem-bound` pair (core bound = BE - mem).

---

## 8. Vector width, FMA and counting FLOPs

**Peak arithmetic** (MM, OBSERVED; plot `PLOT/compute_simd_peak.png`):

| Instruction | Lanes | FLOP per instruction | Instructions/cycle | FLOP/cycle |
|---|---|---|---|---|
| scalar FMA | 1 | 2 | 2.0 | 3.99 |
| SSE FMA (xmm) | 4 | 8 | 2.0 | 15.97 |
| AVX2 FMA (ymm) | 8 | 16 | 2.0 | 31.94 |
| AVX-512 FMA (zmm) | 16 | 32 | 2.0 | **63.86** |
| AVX-512 add or mul | 16 | 16 | 2.0 | 31.93 |

CALCULATED: 2 instructions/cycle x 16 lanes x 2 FLOP = 64 FLOP/cycle, and 63.86 x 2.1 GHz
= **134.1 GFLOP/s** (MM; 133.8 at the measured 2.095 GHz). Each step down in vector
width halves the peak, so code that is not vectorized at 512 bits gives up throughput
before memory even matters. The intensity benchmark (section 10), which loads from memory,
still reaches 63.16 FLOP/cycle when data is in L2 (MM `intensity_peak_flops_per_cycle`).

**How the PMU counts FLOPs.** `fp_arith_inst_retired.*` counts *retired instructions* by
width. From the event description (RAW `perf_list.txt`):

- it counts ADD SUB MUL DIV MIN MAX SQRT RSQRT14 RCP14 and FM(N)ADD/SUB;
- **FMA instructions count twice**, so `count x lanes` equals FLOPs with no correction
  (`cpuinf/metrics.py`: FLOPs = scalar x 1 + 128b x 4 + 256b x 8 + 512b x 16);
- MAX and MIN count, so a ReLU or max-pool built from `vmaxps` contributes "FLOPs" even
  though it does no multiply-add (INFERRED consequence of the documented definition);
- loads, stores, shuffles, conversions and AMX instructions do not count;
- the count is per instruction, so masked-off lanes are probably counted as if active
  (INFERRED, not verified).

*Worked example (BASE, preliminary, `inmodel_flops.csv`, median of 30 iterations).*
`conv1` retires 14,526,816 counts of `512b_packed_single` in 4,572,147 cycles:

- FLOPs = 14,526,816 x 16 = 232.4 MFLOP, i.e. 7.26 M FMA instructions (each counted twice).
- 232.4 M / 4.57 M cycles = **50.8 FLOP/cycle**, 80% of the 63.86 peak (CALCULATED).
- The nominal count for this layer is 64 x 3 x 7 x 7 x 112 x 112 = 118.0 M MAC = 236.0
  MFLOP (CALCULATED). The counter sees 98.5% of that, probably because oneDNN skips
  kernel taps that fall into the zero padding at the image border (INFERRED).
- For the whole model, FP_ARITH gives 8.20 GFLOP per inference and 39.1 FLOP/cycle, 61%
  of measured peak (CALCULATED from BASE). 8.2 GFLOP is the usual figure for ResNet-50
  (about 4.1 G multiply-accumulates, DOCUMENTED).

Derived metrics (`cpuinf/metrics.py`): `flops_per_cycle` and `fp_inst_{512,256,scalar}_share`.
`fp_scalar_double` and `fp_512_double` should be about 0 in FP32 inference.

---

## 9. Loads, stores and the load/store buffers

**Loads.** A load computes its address on a load port (2, 3, 10), translates it through
the DTLB (section 11), and reads L1d. The **L1 load-to-use latency is 5 cycles**
(OBSERVED: LAT, every random-chase working set up to 45 KiB; DOCUMENTED value for Golden
Cove is also 5).

**Stores.** A store is split into a store-address uop (ports 7, 8) and a store-data uop
(ports 4, 9). It waits in the **store buffer** until it retires, and only then is it
written to L1d. A later load to the same address can take its data straight from the
store buffer ("store-to-load forwarding").

| Structure | Size | Label |
|---|---|---|
| Load buffer | 192 entries | DOCUMENTED (Intel, Golden Cove), not measured here |
| Store buffer | 114 entries | DOCUMENTED (Intel, Golden Cove), not measured here |
| L1d fill buffers (outstanding L1 misses) | 16 | DOCUMENTED (Intel, Golden Cove), not measured here |

Every in-flight load or store holds one entry. When a buffer is full, allocation stops
even if the ROB has room.

**What we measured** (BW, OBSERVED; all kernels use 64-byte AVX-512 accesses, SRC `membw.cpp`):

| L1-resident kernel | B/cycle | Interpretation (CALCULATED / INFERRED) |
|---|---|---|
| read (`sum += a[i]`) | 120.3 | 94% of 2 loads x 64 B = 128 B/cycle: two 512-bit loads per cycle |
| write (`a[i] = v`) | 63.85 | one 64 B store per cycle |
| copy (`b[i] = a[i]`) | 127.6 | 64 B read + 64 B written per cycle |
| triad (`a = b + s*c`) | 181.3 | 94% of 2 loads + 1 store = 192 B/cycle |

**Stores that miss in L1** first need to fetch the line ("read for ownership", RFO). The
dirty line is written back later. `membw.cpp` counts only the bytes the program asks for
(STREAM convention), so the DRAM `write` result of 15.0 GB/s could mean about 30 GB/s of
real DRAM traffic: one read plus one write-back per line (CALCULATED upper bound,
INFERRED). The IMC CAS counters (section 13) would settle this.

**Non-temporal (streaming) stores** skip the caches and write whole lines through
write-combining buffers, which are the same fill buffers (DOCUMENTED). They run at
23.0-23.1 GB/s (11.0 B/cycle) at every working-set size from L2-sized up (OBSERVED:
`write_nt_4k`), because the data never stays in a cache. At L1 sizes they are slower
(19.7 GB/s), probably because the `sfence` after each pass becomes significant (INFERRED).

Counters (EV unless noted): `mem_inst_retired.all_loads` / `all_stores` (`loads`,
`stores`), `port_load`, `port_sta`, `port_std`, `exe_activity.bound_on_stores`. These
also exist on this PMU but are not in the project catalog (RAW `perf_list.txt`):
`resource_stalls.sb` (store buffer full) and `ld_blocks.store_forward` (forwarding
failed).

---

## 10. The cache hierarchy

**Geometry** (OBSERVED: RAW `cache_sysfs.txt`; CPUID leaf 4 agrees, OBSERVED live):

| Level | Size | Ways | Sets | Shared by | Notes |
|---|---|---|---|---|---|
| L1d | 48 KiB | 12 | 64 | 1 core | 64 sets x 64 B = 4 KiB per way (CALCULATED) |
| L1i | 32 KiB | 8 | 64 | 1 core | instruction fetch |
| L2 | 2 MiB | 16 | 2048 | 1 core | private, unified |
| L3 | 52.5 MiB | 15 | 57344 | all 28 cores | 28 slices: 57344 / 28 = 2048 sets x 15 ways x 64 B = 1.875 MiB per slice (CALCULATED) |

- *Why L1d is 12-way.* One way of L1d is exactly one 4 KiB page. The set index therefore
  comes from address bits that a page translation does not change, so the cache can be
  indexed while the TLB is translating (virtually indexed, physically tagged; DOCUMENTED
  principle, CALCULATED geometry). Making L1 bigger without breaking this rule means
  adding ways.
- *The L3 is non-inclusive.* CPUID leaf 4 reports inclusive = 0 for L3 (OBSERVED, live),
  and the L2s total 56 MiB, more than the 52.5 MiB L3 (CALCULATED). Data in a core's L2
  need not also be in L3.
- *L3 slices.* There are 28 `uncore_cha` PMUs (SYS), one Caching/Home Agent per slice
  (DOCUMENTED). Addresses are hashed across slices, so one core's L3 data is spread over
  the whole mesh.

**Load-to-use latency** (MM plateau medians, OBSERVED; `PLOT/memory_latency_vs_ws.png`).
`memlat.cpp` chases a random single-cycle permutation of 64 B nodes, so each load's
address comes from the previous load. Only one miss is ever in flight, and the
prefetchers cannot guess the next address.

| Level (plateau window) | random, 2 MiB pages | random, 4 KiB pages | sequential, 4 KiB pages |
|---|---|---|---|
| L1 (4-32 KiB) | 5.0 cyc / 2.4 ns | 5.0 / 2.4 | 5.0 / 2.4 |
| L2 (256 KiB-1 MiB) | 16.0 / 7.7 | 17.8 / 8.5 | 6.1 / 2.9 |
| L3 (8-24 MiB) | 62.7 / 29.9 | 78.7 / 37.6 | 7.1 / 3.4 |
| DRAM (512 MiB-1 GiB measured) | 207.9 / 99.2 | 258.6 / 123.4 | 11.1 / 5.3 |

- The true L2 hit latency is **16 cycles**. Both page sizes give 16.0 between 64 and
  362 KiB (LAT). The 4 KiB plateau value of 17.8 is raised by TLB misses (section 11).
- **Sequential chasing costs 2.4-5.3 ns at every size** (OBSERVED). The chain is just as
  dependent, but the addresses are predictable, so the hardware prefetchers have each
  line close to the core before it is needed. Intel cores prefetch into L1 (next-line,
  IP-stride) and into L2 (streamer, adjacent line) (DOCUMENTED). Convolutions read
  weights and activations in mostly regular patterns, so they benefit from this.

**Where the steps are** (2 MiB-page curve, OBSERVED: LAT):

| Boundary | Nominal | Latency rises between | Agreement |
|---|---|---|---|
| L1 -> L2 | 48 KiB | 45.2 KiB (5.0 cyc) and 53.8 KiB (15.9 cyc) | matches |
| L2 -> L3 | 2 MiB | 2.0 MiB (17.3) and 2.38 MiB (40.9) | matches |
| L3 -> DRAM | 52.5 MiB | 38.0 MiB (63.2) and 45.3 MiB (112.0) | **earlier than nominal** |

One core appears to get only about 38-45 MiB of L3 before misses start (OBSERVED: the
2 MiB-page curve reads 63.2 cycles at 38.0 MiB and 112.0 at 45.3 MiB; the 4 KiB curve
steepens past about 32 MiB). This is an observation, not a
measurement of L3 capacity. Possible causes, none verified (INFERRED): other cores and
users occupying L3 lines; a replacement policy and slice hash that do not behave like
perfect LRU under random access; page tables and code also living in L3. Intel RDT cache
allocation is supported (`cat_l3` flag) but is not in use: `/sys/fs/resctrl` is not
mounted (OBSERVED, live).

**Single-core bandwidth** (BW plateau medians from MM; GB/s, with B/cycle in parentheses;
`PLOT/memory_bandwidth_vs_ws.png`):

| Kernel | L1 | L2 | L3 | DRAM |
|---|---|---|---|---|
| read | 252.2 (120.3) | 104.6 (49.9) | 23.0 (11.0) | 18.5 (8.8) |
| read, 2 MiB pages | 252.1 (120.2) | 105.4 (50.3) | 23.1 (11.0) | 18.5 (8.8) |
| write | 133.8 (63.9) | 33.3 (15.9) | 20.2 (9.7) | 15.0 (7.2) |
| copy | 267.6 (127.6) | 54.9 (26.2) | 21.7 (10.4) | 17.6 (8.4) |
| triad | 380.3 (181.3) | 73.8 (35.2) | 22.2 (10.6) | 17.8 (8.5) |
| write_nt | 19.7 (9.4) | 23.0 (11.0) | 23.1 (11.0) | 23.1 (11.0) |
| rand_read (64 B per line touched) | 181.1 (86.1) | 91.1 (43.5) | 20.9 (10.0) | 5.4 (2.6) |

Read bandwidth falls by about 4.5x when data leaves L2, and then barely changes from L3 to DRAM.
Section 12 explains why: beyond L2, one core is limited by how many misses it can keep in
flight, not by the L3 or DRAM hardware.

**The empirical roofline** (AI; `PLOT/roofline_microbench.png`). `intensity.cpp` applies
F FMAs to every loaded vector, giving an arithmetic intensity of (2F + 1) / 4 FLOP/byte.
At F = 0 (0.25 FLOP/B) it reaches 27.4 FLOP/cycle in L1, 12.4 in L2, 2.75 in L3 and 2.20
in DRAM, about bandwidth x 0.25 (OBSERVED). Near the corner, the DRAM curve sits below
`min(peak, bandwidth x AI)`. At F = 8 (4.25 FLOP/B) it reaches 24.6 FLOP/cycle against a
bound of 8.8 x 4.25 = 37.4 (CALCULATED). One explanation is that when every line carries
a lot of compute, the 512-entry window holds fewer loads, so less memory traffic overlaps
(INFERRED). 2 MiB pages raise the DRAM curve slightly (25.5 at F = 8).

**Counters that observe the hierarchy** (EV; per-thread unless noted):

| Question | Event(s) / derived metric |
|---|---|
| Which level served each retired load? | `mem_load_retired.{l1_hit, l1_miss, fb_hit, l2_hit, l3_hit, l3_miss}` / `mem_inst_retired.all_loads` -> `load_*_frac` |
| Was a line already on its way (often because of a prefetch)? | `mem_load_retired.fb_hit` |
| How many bytes moved between levels (demand + prefetch)? | `l1d.replacement` x 64 (into L1), `l2_lines_in.all` x 64 (into L2), `l2_lines_out.non_silent` x 64 (L2 write-backs) |
| How much of the L2 traffic is prefetch? | `l2_rqsts.all_hwpf`, `l2_rqsts.miss` |
| Did our thread's reads reach DRAM? | `ocr.demand_data_rd.dram` (demand only), `ocr.reads_to_core.dram` (demand + prefetch) |
| How often did the core stall on a miss? | `memory_activity.stalls_l1d_miss` / `_l2_miss` / `_l3_miss` |

Note that generic `cache-references` and `cache-misses` on this CPU mean "requests to L3"
and "L3 misses" (prefetches included), not all cache accesses (EV interpretation).

---

## 11. TLBs and page size: why 4 KiB and 2 MiB pages measure differently

**What it is.** Each load uses a virtual address that must be translated to a physical
one. TLBs cache recent translations. On a miss in the first-level DTLB the core looks in
the second-level STLB. If that also misses, a hardware *page walk* reads the page-table
entries from the cache hierarchy before the load can continue. The *reach* of a TLB is
entries x page size. Linux's transparent huge pages (THP) can back memory with 2 MiB
pages. THP is in `madvise` mode here (SYS), so only memory that is explicitly
`madvise(MADV_HUGEPAGE)`d gets huge pages. `memlat`/`membw`/`intensity` do this when
`THP=1` (SRC `common.h`).

**TLB sizes, as the CPU reports them** (CPUID leaf 0x18, OBSERVED live):

| TLB | Page sizes | Entries | Reach (CALCULATED) |
|---|---|---|---|
| L1 DTLB, loads | 4 KiB | 64 (4-way) | 256 KiB |
| L1 DTLB, loads | 2 MiB / 4 MiB | 32 (4-way) | 64 MiB (2 MiB pages) |
| L1 DTLB, loads | 1 GiB | 8 | 8 GiB |
| L1 DTLB, stores | all | 16 (fully assoc.) | 64 KiB at 4 KiB pages |
| STLB (two arrays) | 4 KiB / 2 MiB / 4 MiB, and 4 KiB / 1 GiB | 1024 + 1024 | 8 MiB (4 KiB pages: 2048 entries); 2 GiB (2 MiB pages: 1024 entries) |
| L1 ITLB | 4 KiB; 2 MiB / 4 MiB | 256; 32 | 1 MiB; 64 MiB |

**How it shows up: the 4 KiB versus 2 MiB latency curves** (LAT, OBSERVED):

1. **L2-sized working sets.** With 2 MiB pages, L2 latency is flat at 16.0 cycles up to
   1.7 MiB. With 4 KiB pages it rises from 430 KiB onward, to 22.2 cycles at 1.4 MiB. The
   extra cycles are first-level DTLB misses that hit in the STLB (INFERRED).
   *Worked check (CALCULATED/INFERRED).* For a random access pattern, the DTLB miss rate
   is about 1 - entries/pages. With the CPUID figure of 64 entries, the penalty implied by
   the data drifts from 1.9 to 5.9 cycles between 430 KiB and 1 MiB, which a single
   penalty cannot explain. With **96 entries** (384 KiB reach) the implied penalty is a
   constant **6.9-7.1 cycles** over the same range, and the curve is flat until 362 KiB
   exactly as observed. The data therefore suggests an effective 4 KiB load-DTLB reach
   of about 384 KiB, larger than CPUID leaf 0x18 reports. This is unresolved (section 19).
2. **L3-sized working sets.** The 4 KiB curve adds 6.3 cycles at 4 MiB (DTLB misses that
   hit the STLB). The extra then grows to 9.5 at 8 MiB, 17.7 at 16 MiB and 25.6 at
   32 MiB (CALCULATED: 4 KiB minus 2 MiB latency). It grows past 8 MiB, consistent with
   the 8 MiB STLB reach for 4 KiB pages: beyond it, accesses need page walks, whose page-table reads hit
   in L1/L2/L3 (INFERRED). That is why the L3 plateau value is 78.7 cycles with 4 KiB
   pages and 62.7 with 2 MiB pages.
3. **DRAM-sized working sets.** 258.6 versus 207.9 cycles, so **about 51 cycles (24 ns)
   per access for page walks** (CALCULATED). One GiB of 4 KiB pages needs 2 MiB of
   page-table entries, which do not stay in L1/L2 (CALCULATED/INFERRED).
4. **Bandwidth is almost unaffected.** Sequential `read` gives 18.5 GB/s from DRAM with
   either page size (BW). A sequential stream needs one translation per 64 lines of a
   4 KiB page, and the walk overlaps with other misses (INFERRED).

**Why this matters for ResNet-50.** The FP32 weights are about 25.6 M parameters x 4 B
= 102 MB (DOCUMENTED parameter count; CALCULATED size), about 25,000 4 KiB pages, far
beyond the 2048-entry STLB. At system-collection time `AnonHugePages` was 0 kB (RAW
`meminfo.txt`). Unless PyTorch's allocator asks for huge pages, tensors are probably on
4 KiB pages (INFERRED; PyTorch has an opt-in environment variable for this, DOCUMENTED,
not verified here). Mostly-sequential weight streaming hides much of the cost.
Gather-like or strided accesses do not.

Counters: `dtlb_load_misses.walk_completed` (EV `dtlb_load_walks`). Also on this PMU but
not in the catalog (RAW `perf_list.txt`): `dtlb_load_misses.walk_completed_4k`,
`walk_completed_2m_4m`, `walk_active`, `walk_pending`. `walk_pending / walk_active` gives
the average number of concurrent walks.

---

## 12. Memory-level parallelism and Little's law for bandwidth

**The rule.** For any queue, *items in flight = throughput x latency* (Little's law). For
memory:

```
bandwidth  =  (outstanding cache lines x 64 B) / latency
```

One core can track only a limited number of outstanding misses. The L1d **fill buffers**
(16, DOCUMENTED (Intel, Golden Cove), not measured here) hold L1 misses. Requests going
beyond L2 wait in L2's queue toward the uncore (the "superqueue"; Golden Cove is
DOCUMENTED to support 48 outstanding L2 misses, not measured here). If latency is high
and the queue is short, bandwidth is capped no matter how fast DRAM is.

*Worked examples (CALCULATED from OBSERVED bandwidth and latency; MM):*

| Case | Bandwidth | Latency used | Lines in flight = BW x latency / 64 B |
|---|---|---|---|
| L2 read | 49.9 B/cycle | 16 cycles | 49.9 x 16 / 64 = **12.5** (fits in 16 fill buffers; the fill-buffer cap would be 16 x 64 / 16 = 64 B/cycle) |
| L3 read | 11.0 B/cycle | 62.7 cycles (idle) | 11.0 x 62.7 / 64 = **10.8** |
| DRAM read, sequential | 8.82 B/cycle | 207.9 cycles (idle, 2 MiB pages) | 8.82 x 207.9 / 64 = **28.7** |
| DRAM read, random independent lines | 2.6 B/cycle | 258.6 cycles (4 KiB pages) | 2.6 x 258.6 / 64 = **10.5** |

How to read this (INFERRED unless noted):

- **L2:** about 12 lines in flight at 16 cycles is close to what 16 fill buffers allow.
  L2 bandwidth is limited by L1 miss handling.
- **DRAM sequential:** 28.7 lines is more than the 16 L1 fill buffers, which suggests that
  the L2 streamer prefetcher keeps extra requests in flight from L2's own queue (DOCUMENTED
  mechanism). Single-core DRAM bandwidth (18.5 GB/s) is about 6% of the 307.2 GB/s
  socket peak (CALCULATED). The limit is the core's ability to keep misses in flight,
  not DRAM.
- **L3:** only about 11 lines in flight at *idle* latency. The latency under streaming
  load is probably higher than the idle pointer-chase value, so the true number of
  lines in flight is larger than the estimate. We have not isolated the per-core L3
  bandwidth limit. Non-temporal stores also top out at about 23 GB/s, about the same as
  L3 reads, which hints at a common per-core limit toward the uncore.
- **Random DRAM loads:** with no prefetching and a page walk on almost every access
  (4 KiB pages), only about 10 demand misses are in flight.
- **Pointer chasing** (section 10) keeps 1 line in flight by construction:
  64 B / 99.2 ns = 0.65 GB/s.

*Socket view (CALCULATED).* Reaching the 307.2 GB/s peak at about 99 ns needs
307.2 GB/s x 99.2 ns = 30.5 KB, about **476 lines in flight** across the socket. One core
manages about 29, so DRAM bandwidth saturates only with many cores
(307.2 / 18.5 = about 17 cores at the single-core rate; real sustainable peaks are lower,
DOCUMENTED). For our batch-1, single-core study, **socket DRAM bandwidth is far from saturated.
A layer that streams data from DRAM is limited by per-core concurrency x latency**
(INFERRED from the numbers above).

Counters that measure memory-level parallelism directly (EV): `l1d_pend_miss.pending` /
`l1d_pend_miss.pending_cycles` = average L1D misses in flight (`mlp_l1d` in
`cpuinf/metrics.py`); `l1d_pend_miss.fb_full` = cycles in which a demand request was
blocked because all fill buffers were busy (`fb_full`). Also available (RAW
`perf_list.txt`): `offcore_requests_outstanding.{data_rd, demand_data_rd, cycles_with_*}`
for occupancy beyond L2.

---

## 13. The memory subsystem: channels, IMC and CAS counts

| Item | Value | Label |
|---|---|---|
| DIMMs | 8 x 16 GB DDR5 registered (RDIMM), 1 rank, 80-bit total width (64 data + ECC) | OBSERVED: RAW `dmidecode_memory.txt` |
| Slots | A1-A8 populated, B1-B8 empty, so one DIMM per channel | OBSERVED: same |
| Speed | rated 5600 MT/s, configured 4800 MT/s | OBSERVED: same |
| Why 4800 | most likely the memory-speed limit of this CPU SKU | INFERRED (check Intel ARK) |
| Channels / controllers | 8 `uncore_imc_N` PMUs (one per channel); 4 `uncore_imc_free_running_N` and 4 `uncore_m2m_N` suggest 4 controllers x 2 channels | PMU counts OBSERVED: SYS; controller grouping INFERRED |
| Sub-channels | each DDR5 DIMM has two 32-bit sub-channels; the `unc_m_cas_count.pch0/pch1` events count them separately | DOCUMENTED; events OBSERVED in RAW `perf_list.txt` |
| Peak | per channel 4800 MT/s x 8 B = 38.4 GB/s; x 8 = 307.2 GB/s | CALCULATED |
| NUMA | 1 node, distance 10: no remote-memory effects | OBSERVED: RAW `numactl_hardware.txt` |

**CAS counts.** Each DRAM read or write burst is started by a column-address-strobe (CAS)
command and moves one 64 B line (DOCUMENTED). `uncore_imc/cas_count_read/` and
`cas_count_write/`, summed over the 8 channel PMUs, therefore give the bytes that actually
crossed the DRAM interface. perf scales them to MiB. The project sums all instances in
`cpuinf/perfcounters.py` (`UncoreCounters`) and records them as `imc_cas_read` /
`imc_cas_write` (EV).

**Why socket-wide.** The memory controllers sit behind the mesh and serve requests from
every core and every I/O device. The counters do not know which core asked (DOCUMENTED
scope; EV labels these "socket-wide"). Two consequences:

- *Background traffic.* With our workload idle, the socket did 123.54 MiB of reads and
  85.41 MiB of writes in 2.001 s (OBSERVED: RAW `background_dram_traffic.txt`). That is
  about 64.7 MB/s read + 44.8 MB/s write, or about 11 MB per 100 ms (CALCULATED). This
  floor has to be subtracted from per-layer DRAM bytes, and it matters most for short
  layers.
- *Per-thread cross-check.* `ocr.demand_data_rd.dram` and `ocr.reads_to_core.dram` count
  only our thread's requests that DRAM served (EV). Comparing them with the CAS-derived
  bytes separates our traffic from everyone else's. Write-backs are invisible to the
  per-thread events, and they reach DRAM later than the store that caused them, when a
  dirty line is evicted (DOCUMENTED mechanism).

*Preliminary illustration (BASE `inmodel_dram.csv`, median of 30 iterations).* The
in-model passes sum to about 125 MB read and 9 MB written per inference. About 6 MB of
the reads is the expected background (CALCULATED). The rest is the same order as the
102 MB of FP32 weights, which fits with the weights being re-read from DRAM on every
inference because they do not fit in the 52.5 MiB L3 (INFERRED).

---

## 14. Speculation and branch prediction

**What it is.** The front end must guess the outcome of every branch long before the
branch executes, so that fetch can continue. When a guess is wrong, every uop after the
branch is discarded and fetch restarts from the correct path. A *machine clear* is a
similar flush caused by something other than a branch, for example a memory-ordering
conflict or self-modifying code (DOCUMENTED). In top-down terms, slots spent on discarded
uops are **Bad Speculation**.

**How it shows up in our measurements.**

- Each misprediction costs roughly 15-20 cycles of wasted pipeline work (the project's
  working figure in EV; a DOCUMENTED order of magnitude, not measured here).
- The microbenchmarks contain only highly predictable loop branches, so their results
  reflect arithmetic and memory alone (INFERRED from the code; branch counters are not
  recorded in the microbenchmark CSVs).
- In ResNet-50, branchy code is mostly outside the math kernels: the Python interpreter,
  `nn.Module` dispatch, the ATen dispatcher, oneDNN primitive selection and loop tails.
  `experiments/dispatch_overhead.py` estimates the fixed per-call cost of this layer.
- The PMU can record the last 32 taken branches (`cpu/caps/branches=32` in RAW
  `perf_pmu.txt`; DOCUMENTED meaning: LBR depth), which `perf record -b` can use to
  locate hot mispredicting branches.

Counters: `branches`, `branch-misses` (EV; `branch_miss_rate` in `cpuinf/metrics.py`),
`topdown-bad-spec`, `topdown-br-mispredict`. The difference between the two topdown
events is machine clears. Also available (RAW `perf_list.txt`): `br_misp_retired.*` by
branch type, `machine_clears.count`, `machine_clears.memory_ordering`,
`int_misc.clear_resteer_cycles`.

---

## 15. Retirement, the 6-slot pipeline and top-down analysis

**Slots.** Each cycle the allocation stage can accept up to 6 uops: **6 slots per cycle**
(DOCUMENTED (Intel, Golden Cove); retirement can reach 8 per cycle, DOCUMENTED, not
measured here). The fixed counter `slots` counts slots. In the ResNet baseline, slots
per nanosecond in the top-down pass divided by cycles per nanosecond in the core pass
gives **6.008 slots per cycle** (CALCULATED across passes from BASE `inmodel_topdown.csv`
and `inmodel_core.csv`).

**Top-down (TMA) Level 1.** Every slot falls into exactly one of four categories
(DOCUMENTED, Intel Top-down Microarchitecture Analysis):

| Category | The slot... | Hardware behind it (sections) |
|---|---|---|
| Retiring | was used by a uop that later retired: useful work | ports, vector width (6, 8) |
| Bad Speculation | was used by a uop that was later discarded | branch prediction, machine clears (14) |
| Frontend Bound | was empty because the front end delivered no uop | L1i, ITLB, decoders, uop cache (4) |
| Backend Bound | was empty because the back end could not accept a uop | memory (9-13) or execution units (6, 7) |

**Level 2** splits each category in two. The hardware reports the first half, and
`cpuinf/metrics.py` gets the second by subtraction.

**Two ways to read top-down on this machine, and which one we use.**

| | perf-metrics events (`slots` + `topdown-*`) | general-purpose events (the `tdgp` pass) |
|---|---|---|
| Retiring | `topdown-retiring` | `uops_retired.slots` |
| Bad Speculation | `topdown-bad-spec` | `topdown.bad_spec_slots` |
| Frontend Bound | `topdown-fe-bound` | `idq_bubbles.core` - `int_misc.uop_dropping` |
| Backend Bound | `topdown-be-bound` | `topdown.backend_bound_slots` |
| L2: heavy ops / br. mispredict / fetch latency / memory bound | `topdown-heavy-ops` / `-br-mispredict` / `-fetch-lat` / `-mem-bound` | `uops_retired.heavy` / `topdown.br_mispredict_slots` / 6 x `idq_bubbles.cycles_0_uops_deliv.core` - uop_dropping / `topdown.memory_bound_slots` |
| Denominator | fixed counter `slots` | `topdown.slots_p` |
| Counters used | fixed counter + PERF_METRICS register | 6 + 4 general-purpose counters (two runs) |

The perf-metrics events are derived from the PERF_METRICS register, which holds 8-bit
*fractions accumulated since the hardware last reset it*. OBSERVED: when we start and stop
counting around each ResNet operator, every operator gets the **same** Level-1 split (the
whole-run average) and the four fractions do not sum to 1 (0.71-1.56 in the control run).
INFERRED mechanism: the difference of two reads is (delta slots) x (cumulative fraction).
Even for whole-process `perf stat`, the perf-metrics fractions summed to 1.05-1.14 in our
cross-check, while the general-purpose fractions summed to 1.001-1.006 (OBSERVED,
`results/2026-10-06_resnet_baseline/raw/topdown_method_validation/`). The two methods
differ by up to about 0.08 absolute in individual fractions. The project therefore uses
the general-purpose events (`tdgp` pass) for all per-operator top-down numbers; across the
175 ResNet operators their Level-1 sum is 1.000 +- 0.005 (OBSERVED). Treat any single
top-down fraction as uncertain by roughly +-0.05 and compare operators, not decimals.

**Reading top-down correctly.**

- *High Retiring is not automatically good.* A scalar loop can retire at full width and
  still do 1/16 of the work of an AVX-512 loop. Check `fp_inst_512_share` and
  FLOP/cycle as well (EV interpretation of `td_retiring`).
- *IPC depends on instruction mix.* One zmm FMA is 32 FLOPs. Compare kernels by
  FLOP/cycle or bytes/cycle, not by IPC.
- *Retired versus executed.* `instructions`, `fp_arith_inst_retired.*` and
  `mem_*_retired.*` count at retirement, so discarded speculative work is excluded.
  `uops_issued.any` and `uops_executed.thread` include it.
- *Front end details* come from the uop delivery counters (`idq.dsb_uops`,
  `idq.mite_uops`, `lsd.uops`, `idq.ms_uops`) and from `icache_data.stalls` (EV).
  JIT-generated oneDNN kernels have compact hot loops, so front-end limits should mostly
  show up in the Python and dispatch layers (INFERRED).

---

## 16. The performance monitoring unit (PMU)

**Counters per core** (CPUID leaf 0xA, OBSERVED live: architectural perfmon version 5):

| Counter | Count | Width | What it counts |
|---|---|---|---|
| General-purpose (GP) | **8** | 48-bit | any programmable event, subject to per-event restrictions (below) |
| Fixed | **4** | 48-bit | instructions retired, core cycles, reference cycles, slots (DOCUMENTED mapping of fixed counters 0-3) |
| PERF_METRICS | 1 register | n/a | the hardware's own top-down Level-1 and Level-2 breakdown, read together with `slots` (DOCUMENTED) |

The kernel exposes PERF_METRICS as the eight `topdown-*` events (RAW `perf_pmu.txt`).
They must be grouped with `slots` as the group leader (DOCUMENTED Linux requirement), and
`scripts/perfwrap.py` builds that `{slots,topdown-*}` group. They use no GP counters, so
the perf-metrics `topdown` pass fits in one run. As explained in section 15, they are
only trustworthy over whole processes here; per-operator top-down uses the
general-purpose `tdgp` pass, which needs two runs (6 + 4 events).

**perf has no TMA formulas for this model.** perf 6.8.12 reports
`Cannot find metric or group 'TopdownL1'` (OBSERVED: EV `perf_builtin_tma_metrics`), even
though it knows this model's events. The project therefore reads the raw `slots` and
`topdown-*` counts and computes the fractions itself (EV `tma_strategy`,
`cpuinf/metrics.py`).

**"8 GP counters" does not mean "any 8 events".** Some events may only be placed on
certain counters. The project found that `MEM_LOAD_RETIRED.*` and `MEM_INST_RETIRED.*`
fit **only 4 at a time**. `cpuinf/perfcounters.py` (`plan_groups`) notes that they are
restricted to GP counters 0-3. That matches Intel's event tables as far as we know
(DOCUMENTED, not verified here). The effect is visible in the baseline (OBSERVED, BASE):

| Pass | Runs needed (events beside `cycles`) |
|---|---|
| loads | 4 + 4 (`inmodel_loads.0.csv`: loads, stores, l1_hit, l1_miss; `.1`: fb_hit, l2_hit, l3_hit, l3_miss) |
| ports | 7 + 1 |
| stalls | 7 + 1 |
| traffic | 4 + 3 |
| frontend | 6 + 2 |
| core, flops, topdown (perf-metrics) | 1 run each |
| tdgp (general-purpose top-down) | 6 + 4 |

`plan_groups` finds these splits greedily by opening the events and checking for
multiplexing. We have not attributed the non-`loads` splits to specific causes. Possible
causes are per-event counter masks, and the kernel's NMI watchdog, which is enabled here
(`nmi_watchdog=1`, SYS) and holds a counter on each CPU (DOCUMENTED Linux behaviour;
INFERRED effect).

**Multiplexing.** When there are more events than counters, the kernel time-slices them
and scales the counts, which hides short phases. The project avoids this: every pass
records a `multiplexed` flag, and it is `False` for every row of every baseline file
(OBSERVED, BASE).

**Scope.**

- *Core events* count only the measured thread on its core (`pid=0, cpu=-1`;
  `cpuinf/perfcounters.py`). The microbenchmarks group `cycles`, `ref-cycles` and
  `instructions` (SRC `common.h`), and can add more through `PERF_EXTRA`.
- *Uncore events* are socket-wide and include every process (EV scope).
- *Precise events / PEBS.* `max_precise=3` (RAW `perf_pmu.txt`). `mem_load_retired.*`
  are precise events that can report the exact instruction and data address (RAW
  `perf_list.txt`: "Supports address when precise"). The `ldlat` format field enables
  load-latency sampling (`mem-loads`).

**Uncore PMUs on this socket** (OBSERVED: SYS; roles DOCUMENTED):

| PMU | Instances | Role |
|---|---|---|
| `uncore_cha` | 28 | Caching/Home Agent: an L3 slice and its snoop filter |
| `uncore_imc` | 8 | memory channels: CAS counts, activates |
| `uncore_imc_free_running` | 4 | always-on memory-controller counters |
| `uncore_m2m` | 4 | mesh-to-memory interface |
| `uncore_iio`, `uncore_irp`, `uncore_m2pcie` | 7 each | PCIe and I/O traffic |
| `uncore_m3upi` | 3 | socket-to-socket links (unused with 1 socket) |
| `uncore_pcu`, `power`, `cstate_core`, `cstate_pkg` | 1 each | power control, RAPL energy, C-state residency |
| `intel_pt`, `intel_bts` | 1 each | instruction tracing |

---

## 17. AMX: present, unused by FP32 inference

The CPU has Advanced Matrix Extensions: `amx_tile`, `amx_bf16` and `amx_int8` (OBSERVED:
SYS). AMX adds 8 tile registers of 1 KiB each and a matrix-multiply unit that works on
BF16 and INT8 data only (DOCUMENTED). There is no FP32 path, so FP32 inference cannot use
AMX unless the model is converted to BF16 or INT8 (DOCUMENTED). The same applies to
`avx512_bf16`, `avx512_fp16`, `avx512_vnni` and `avx_vnni`.

**How it shows up.** `exe.amx_busy` (EV `amx_busy`) counts cycles with the AMX unit busy.
Over all 30 iterations of every layer in the baseline it sums to **0** (OBSERVED: BASE
`inmodel_flops.csv`). If a later experiment uses BF16, remember that AMX work does not
appear in `fp_arith_inst_retired.*` (section 8). FLOP accounting would then need a
different method.

---

## 18. Cheat sheet

**Numbers to remember** (OBSERVED unless marked):

| | Value |
|---|---|
| Clock | 2.1 GHz fixed (2.095 measured); 1 cycle = 0.476 ns (CALCULATED) |
| FMA | 4-cycle latency, 2/cycle, so 8 independent chains are needed (CALCULATED) |
| Peak FP32 | 63.86 FLOP/cycle = 134.1 GFLOP/s |
| Latency, 2 MiB pages | L1 5 / L2 16 / L3 63 cycles (30 ns) / DRAM 208 cycles (99 ns) |
| Extra cost of 4 KiB pages | about +16 cycles at L3 sizes (8-24 MiB plateau); about +51 cycles (24 ns) at DRAM sizes (CALCULATED) |
| Read bandwidth, 1 core | L1 120 / L2 50 / L3 11 / DRAM 8.8 B/cycle (18.5 GB/s) |
| DRAM peak (socket) | 307.2 GB/s (CALCULATED); one core reaches 6% |
| Pipeline | 6 slots/cycle (CALCULATED from counters) |
| Capacities | L1d 48 KiB, L2 2 MiB, L3 52.5 MiB nominal (about 38-45 MiB apparent for one core) |

**Which counter answers which question** (keys from EV):

| Question | Look at |
|---|---|
| Is the clock what we think? | `cycles / ref_cycles x 2.1` -> `freq_ghz` |
| Where do the slots go? | `slots`, `td_*` -> `tma_*` |
| How much math, at what width? | `fp_*_single` -> `flops_per_cycle`, `fp_inst_512_share` |
| Are the FMA ports saturated? | `port0`, `port5` per cycle (2 FMA pipes) |
| Where did loads hit? | `load_*` / `loads` -> `load_*_frac` |
| How many bytes moved between levels? | `l1d_replacement`, `l2_lines_in`, `l2_lines_out_nonsilent` (x 64) |
| How many misses were in flight? | `l1d_pend_miss_pending / l1d_pend_miss_cycles` -> `mlp_l1d`; `fb_full` |
| Did we stall waiting for DRAM? | `stalls_l3_miss`, `ocr_dram_rd` |
| What did the socket read from DRAM? | `imc_cas_read`, `imc_cas_write` (minus the background floor) |
| TLB trouble? | `dtlb_load_walks` |
| Front-end trouble? | `td_fe_bound`, `td_fetch_lat`, `icache_stalls`, `dsb_uops` vs `mite_uops` |
| Noise? | `context_switches`, `cpu_migrations`, `page_faults`, `multiplexed` |

---

## 19. Open questions and unverified points

1. **512-bit add latency of 3.43 cycles.** It lies between 2 and 4. The port-split
   explanation (section 6) is INFERRED. Test it with `port0` versus `port5` counts on
   `fp32_avx512_add`, K = 1.
2. **Effective 4 KiB load-DTLB reach.** The latency data fits about 96 entries with a
   7-cycle STLB-hit penalty, while CPUID leaf 0x18 reports 64 (section 11). Test with
   `dtlb_load_misses.*` counts around 256-512 KiB.
3. **Apparent L3 capacity of about 38-45 MiB** against 52.5 MiB nominal (section 10).
   Neighbour activity, replacement policy and slice hashing are all candidates.
4. **What limits per-core L3 bandwidth.** Little's law at idle latency gives about 11
   lines in flight, fewer than DRAM streaming achieves (section 12). Measure loaded
   latency and `offcore_requests_outstanding.*`.
5. **Buffer sizes** (ROB 512, load buffer 192, store buffer 114, 16 fill buffers,
   48 L2 misses, retire width 8) are DOCUMENTED (Intel, Golden Cove), not measured here.
6. **Counter-group splits** other than the MEM_* restriction (section 16) have not been
   attributed. The NMI watchdog is one candidate.
7. **AVX-512 frequency under multi-core load** is untested. Only one busy core was
   measured.
8. **RFO and write-back traffic** for regular stores is not yet measured with IMC
   counters (section 9).
9. **Live-read facts** (CPUID leaves 0xA/0x4/0x18, uncore frequency, SMT control,
   resctrl) are not yet captured by `scripts/collect_system_info.sh`. Adding them would
   turn the "OBSERVED (live)" entries above into reproducible records.
