# Interpreting hardware counters in combination

This guide explains how to read the counter data this project collects for single-core, batch-1, FP32
ResNet-50 inference in PyTorch. The machine is one core of an Intel Xeon Gold 5512U (Emerald Rapids,
Golden Cove-class core) at a fixed 2.1 GHz with turbo and SMT off. It assumes you know programming and
basic computer architecture and are learning detailed performance analysis.

The rule behind every section: **a single counter never identifies a bottleneck.** A counter value
supports a claim only together with the counters that rule out the competing explanations. The best
evidence also compares the pattern with a reference kernel whose bottleneck is known by construction
(Section 2).

| Label | Meaning in this repository |
|---|---|
| OBSERVED | Read directly from a counter or timer, in a named result file |
| CALCULATED | Arithmetic on observed values or on tensor shapes (e.g. `cpuinf/manifest.py`) |
| INFERRED | An interpretation the evidence supports but does not prove; always name the evidence |
| UNKNOWN | Cannot be decided with the data or events we have; say what would decide it |

Sources:

- **Machine model:** `results/2026-10-05_microbench/processed/machine_model.json` and the summary
  CSVs. The raw CSVs record cycles and instructions, so microbenchmark IPC values here are
  CALCULATED. Plots are in `results/2026-10-05_microbench/plots/`.
- **Events:** availability in `results/perf_events.md`, meanings in `cpuinf/events.py`, formulas in
  `cpuinf/metrics.py`. Metric keys are written `like_this`.
- **End-to-end:** `results/2026-10-06_resnet_baseline/processed/e2e_summary_explicit.json`.
- **Per-layer:** the canonical `layer_table.csv` and `REPORT.md` do not exist yet. Per-layer remarks are
  **preliminary observations** from the earlier control run
  (`results/2026-10-05_control_outofplace_add/raw/inmodel_*.csv`, which differs only in the residual
  Add). They are rounded on purpose and must be re-checked against the baseline.

## Contents

0. [Before interpreting: is the measurement valid?](#0-before-interpreting-is-the-measurement-valid)
1. [Basic identities and why one counter misleads](#1-basic-identities-and-why-one-counter-misleads)
2. [Calibration anchors on this machine](#2-calibration-anchors-on-this-machine)
3. [Counter combinations](#3-counter-combinations)
   - [3.1 High cycles, low IPC, many cache misses](#31-high-cycles-low-ipc-many-cache-misses)
   - [3.2 High cycles, high IPC, few cache misses](#32-high-cycles-high-ipc-few-cache-misses)
   - [3.3 Many instructions, high IPC, heavy vector use](#33-many-instructions-high-ipc-heavy-vector-use)
   - [3.4 Few instructions, very many cycles](#34-few-instructions-very-many-cycles)
   - [3.5 Low IPC, few cache misses](#35-low-ipc-few-cache-misses)
   - [3.6 Many LLC misses, little time lost](#36-many-llc-misses-little-time-lost)
   - [3.7 Memory-bound with a high L1 hit rate](#37-memory-bound-with-a-high-l1-hit-rate)
   - [3.8 Frontend-bound](#38-frontend-bound)
   - [3.9 Bad speculation](#39-bad-speculation)
   - [3.10 High retiring, still slow](#310-high-retiring-still-slow)
   - [3.11 DRAM traffic: socket-wide CAS vs per-thread offcore](#311-dram-traffic-socket-wide-cas-vs-per-thread-offcore)
4. [The roofline as an interpretation tool](#4-the-roofline-as-an-interpretation-tool)
5. [Data-source attribution caveats](#5-data-source-attribution-caveats)
6. [Decision flowchart](#6-decision-flowchart)
7. [Claim to minimum evidence](#7-claim-to-minimum-evidence)
8. [Events the catalog lacks](#8-events-the-catalog-lacks)

---

## 0. Before interpreting: is the measurement valid?

A combination of counters is only meaningful if each counter is. Check these first:

- **No multiplexing.** The `multiplexed` column must be `False`. Multiplexed counts are scaled
  estimates, and their ratios can be biased.
- **One denominator per pass.** Different passes are different runs, so normalise each count by the
  `cycles` of its own pass. Do not divide `loads` from the loads pass by `cycles` from the stalls pass.
- **Clean execution.** `cpu_migrations` = 0, `context_switches` near 0, and `freq_ghz` (cycles /
  ref_cycles x 2.1) near 2.095. Kernel mode is counted by default, so page faults inside a region add
  cycles and instructions.
- **Long enough region.** Operators of tens of microseconds are dominated by the pass floor (the cost
  of an empty start/stop) and by the Python hook.
- **Top-down consistency.** The four Level-1 counts must sum to about `slots`, and `slots` must be about
  6 x `cycles`. `tma_retiring` x 6 is retired slots per cycle, which is roughly IPC x uops per
  instruction (about 1-1.3 for vector code). Operators with very different IPC cannot share one
  top-down profile.

**Worked failure (INFERRED: measurement artifact).** In the control run's `inmodel_topdown.csv`, the
Level-1 sums range from 0.71 to 1.56 of `slots`. Nearly every operator shows about 0.41 retiring, 0.14
bad speculation, 0.16 frontend and 0.34 backend. That includes convolutions near 50 FLOP/cycle and fc
at IPC about 0.3. For fc, 0.41 x 6 = 2.5 retired slots per cycle would mean about 8 uops per
instruction, which is implausible. `slots` itself matches 6 x cycles. Those per-layer top-down values
must not be interpreted.

*Resolution (OBSERVED, 2026-10-06).* The canonical baseline showed the same symptom: every operator
got the whole-run average split. The `topdown-*` events are derived from the PERF_METRICS register,
which holds 8-bit fractions accumulated since its last hardware reset, so differencing two reads
around a short region gives (delta slots) x (cumulative fraction) (INFERRED mechanism). The project
now measures per-operator top-down with plain general-purpose events (`tdgp` pass:
`topdown.slots_p`, `uops_retired.slots`, `topdown.bad_spec_slots`, `idq_bubbles.core`,
`topdown.backend_bound_slots`, `topdown.memory_bound_slots`, ...; see `cpuinf/events.py`). Their
Level-1 sum is 1.000 +- 0.005 for all 175 operators. A whole-process cross-check
(`results/2026-10-06_resnet_baseline/raw/topdown_method_validation/`) found perf-metrics sums of
1.05-1.14 even under `perf stat`, versus 1.001-1.006 for the general-purpose events, and per-fraction
differences of up to ~0.08 between the two methods. Lesson: a top-down profile is only usable after
the Level-1 sum check passes, and single fractions carry roughly +-0.05 uncertainty.

---

## 1. Basic identities and why one counter misleads

```
cycles = instructions x CPI                (CPI = 1 / IPC)
time   = cycles / frequency                (fixed, ~2.095 GHz measured)
slots  = 6 x cycles                        (Golden Cove allocates up to 6 uops/cycle)
retiring + bad_spec + frontend_bound + backend_bound = 1           (fractions of slots)
retiring = heavy + light;  bad_spec = br_mispredict + machine_clears
frontend = fetch_latency + fetch_bandwidth;  backend = memory_bound + core_bound
```

**End-to-end check** (OBSERVED medians): 475.2 M instructions, 206.5 M cycles, IPC 2.30 (CPI 0.435),
2.095 GHz. 206.5 M / 2.095 GHz = 98.56 ms, against a measured median of 98.57 ms (CALCULATED).

**Speed-ups.** Every speed-up is fewer instructions, a lower CPI, or both:
ln(cycles ratio) = ln(instructions ratio) + ln(CPI ratio). Report both terms. "IPC went up" is not a
speed-up if the instruction count rose more.

**Derived Level-2 entries.** `metrics.py` computes machine clears, fetch bandwidth and core bound as
differences of two measured numbers, clipped at 0. Small errors in either number become large relative
errors in the difference.

```
flops_measured  = sum(FP_ARITH count x lanes)   lanes 1/4/8/16 for scalar/128/256/512-bit FP32
                  (the hardware already counts each FMA instruction twice)
flops_per_cycle = flops_measured / cycles
bytes_into_l1d  = l1d.replacement x 64          L2 -> L1 fills (demand + prefetch)
bytes_into_l2   = l2_lines_in.all x 64          L3/DRAM -> L2 fills (demand + prefetch)
bytes_dram_reads_core = ocr.reads_to_core.dram x 64     this thread, demand + prefetch reads
mlp_l1d         = l1d_pend_miss.pending / l1d_pend_miss.pending_cycles
                  (average demand L1D misses in flight while at least one is outstanding)
```

**FP32 peaks by width** (OBSERVED, `compute_simd_peak.png`):

| Instruction kind | Peak FLOP/cycle |
|---|---|
| AVX-512 FMA | 63.9 |
| AVX2 FMA | 31.9 |
| SSE FMA | 16.0 |
| Scalar FMA | 4.0 |
| AVX-512 add or mul alone | 31.9 |
| Scalar add | 2.0 |

The FMA pipes sustain 2 instructions per cycle at every width. `FP_ARITH` counts add, sub, mul, div,
min, max, sqrt and FMA. It does **not** count compares, blends, logic ops, shuffles, conversions,
loads or stores. A max-pool or ReLU built from compares and blends reports zero FLOPs.

**Little's law** links the memory counters: bytes/cycle = lines in flight x 64 / latency
(CALCULATED for the anchors):

| Anchor | Bytes/cycle | Lines in flight |
|---|---|---|
| DRAM pointer chase | 64 / 208 = 0.31 | 1 |
| Independent random DRAM reads | 2.6 | about 8-10 |
| Streaming read | 8.8 | at least 29 |

The streaming figure exceeds the L1D's 16 fill buffers (Intel's Golden Cove description, not measured
here), so INFERRED: the L2 prefetcher supplies much of the concurrency. Also, 8.8 B/cycle is 18.5 GB/s,
about 6% of the socket's 307 GB/s theoretical peak. One core's DRAM bandwidth is a concurrency limit,
not a DRAM-channel limit.

**Why each counter alone misleads.**

| Counter or metric | Why it misleads alone | Pair it with |
|---|---|---|
| `cycles` | How much time, never why | Everything else |
| `instructions` | Counts instructions, not work: an AVX-512 FMA is 32 FLOP, a scalar add is 1 | FLOPs, instructions per output |
| IPC | Depends on instruction mix (table below) | FLOP/cycle, top-down |
| `cache_misses` (LLC) | Includes prefetches; a miss is not a stall | `stalls_l3_miss_frac`, `load_l3_miss_frac` |
| `llc_miss_ratio` | Ratio of two possibly small numbers; says nothing about cost | MPKI, stall fractions |
| `tma_retiring` | Useful slots, not useful *work*; scalar code retires well | FLOP/cycle, instructions per output |
| `tma_core_bound` | High at the FP32 peak itself (below) | FLOP/cycle, ports |
| `flops_per_cycle` | How far from peak, not why | Top-down, traffic |

**The same IPC can mean opposite things** (CALCULATED from the microbenchmark raw files):

| Kernel | IPC | FLOP/cycle | What limits it |
|---|---|---|---|
| AVX-512 FMA, 8 or more independent chains | 2.06 | 63.9 | FP32 peak: 2 FMA pipes |
| Integer add, 12 chains | 5.04 | 0 | Integer ALUs; no FP work |
| saxpy, `-O2` (scalar SSE) | 5.28 | ~1.5 | Instruction count: 7 per element |
| saxpy, `-O3 -march=native -ffast-math` | 5.07 | ~27 | Same IPC, 17.7x faster |
| dot, `-O2` | 3.09 | ~1.0 | 2-cycle scalar add latency chain |
| dot, `-O3 -march=native -ffast-math` | 2.19 | ~11 | Lower IPC, 11x faster |
| Pointer chase in L1 (32 KiB) | 0.28 | 0 | 5-cycle L1 latency, all hits |
| Pointer chase in DRAM (2 MiB pages) | 0.010 | 0 | 208-cycle latency, 1 miss in flight |
| Streaming read from DRAM | 0.19 | - | 8.8 B/cycle bandwidth |

Consequence for top-down (INFERRED; calibrate it): the FMA peak kernel retires about 2.1 uops per
cycle out of 6 slots. Its `tma_retiring` should therefore be about 0.35, with most of the rest Core
Bound. **High Core Bound can be the best achievable state** for FMA-dominated code on this core.

---

## 2. Calibration anchors on this machine

These microbenchmarks have bottlenecks known by construction. The microbenchmarks recorded only
cycles, instructions and time, so the last column is INFERRED.
`experiments/validate_counters.py` (`scripts/run_counter_validation.sh`) checks several of these
signatures. Once its results exist, cite them instead, and say "this operator looks like anchor X".

| Anchor | Bottleneck by construction | OBSERVED / CALCULATED | Expected signature (INFERRED) |
|---|---|---|---|
| `compute` AVX-512 FMA, K >= 8 | FMA throughput | 63.9 FLOP/cycle, IPC 2.06 | `fp_inst_512_share`~1, no loads, `port0`, `port5` ~1/cycle |
| `compute` AVX-512 FMA, K = 1 | FMA latency, 4 cycles | 8.0 FLOP/cycle, IPC 0.35 | Same mix at 1/8 the rate; core-bound, ports mostly idle |
| `memlat random`, 4-32 KiB | L1 latency, 5 cycles | IPC 0.28 | `load_l1_hit_frac`~1; L1-bound (bound_on_loads - stalls_l1d_miss) |
| `memlat random_thp`, 1 GiB | DRAM latency | 208 cycles/load, IPC 0.010 | `load_l3_miss` ~1/load, `stalls_l3_miss_frac`~1, `mlp_l1d`~1 |
| `memlat random`, 4 KiB pages, 1 GiB | DRAM + page walks | 259 cycles/load | As above, plus `dtlb_load_walks` ~1/load |
| `memlat sequential`, 1 GiB | Same chain, prefetchable | 11.1 cycles/load | Many LLC misses (prefetches), small demand stalls |
| `membw read`, DRAM | Single-core DRAM bandwidth | 8.8 B/cycle, IPC 0.19 | DRAM bytes/cycle ~8.8, high `mlp_l1d`, `fb_full` > 0, many `l2_hwpf` |
| `membw rand_read`, DRAM | Latency x limited concurrency | 2.6 B/cycle | `mlp_l1d` about 8-10 |
| `membw read`, 16 KiB | L1 load ports, 2 x 64 B/cycle | 120 B/cycle, IPC 2.63 | `load_l1_hit_frac`~1, `port_load` ~1.9/cycle |
| `membw write`, L2-sized | RFO + write-back | 15.9 B/cycle (read: 49.9) | `bound_on_stores_frac` high |
| `membw write_nt`, any size | Non-temporal stores bypass caches | ~11 B/cycle even at L1 sizes | Few fills; DRAM writes at the op |
| `flags` saxpy `-O2` vs `-ffast-math` | Instruction count | 1.33 vs 0.075 cycles/element | Scalar vs 512-bit FP share |
| `flags` dot, zmm, no fast-math | Ordered reduction = chain | 3.2 cycles/element, IPC 0.70 | Vector instructions, low FLOP/cycle |

Plots: `compute_chains.png`, `memory_latency_vs_ws.png`, `memory_bandwidth_vs_ws.png`,
`roofline_microbench.png` and `compiler_flags.png`.

---

## 3. Counter combinations

Each subsection gives what the combination can mean, the counters that tell the explanations apart,
and the conclusions it does **not** justify.

### 3.1 High cycles, low IPC, many cache misses

This is the textbook "memory-bound" picture, but IPC cannot separate its variants. The DRAM pointer
chase runs at IPC 0.010 and the DRAM streaming read at 0.19, yet one moves 0.31 B/cycle and the other
8.8.

**Can mean**
1. *Latency-bound:* the next address depends on the last miss, so about one miss is in flight
   (pointer chasing, indirect indexing). Anchor: 208 cycles per load.
2. *Bandwidth-bound:* many independent misses are in flight and the core's concurrency limit is
   reached. Anchor: 8.8 B/cycle.
3. *TLB-bound:* the DRAM chase costs 259 cycles per load with 4 KiB pages and 208 with 2 MiB pages,
   so page walks add about 50 cycles per access (CALCULATED).
4. *Misses that are not the cause:* `cache_misses` includes prefetches, and the cycles go elsewhere
   (a dependency chain, the frontend, mispredicts).

**Tell them apart with**
- `tma_memory_bound` vs `tma_core_bound`. If memory-bound is small, the misses do not limit.
- `stalls_l3_miss_frac` (stalls while a *demand* L3 miss is outstanding), not LLC MPKI.
- `mlp_l1d`: about 1-2 means latency; well above that means concurrency or bandwidth.
  `fb_full`/cycles shows exhausted L1 fill buffers.
- Achieved bytes/cycle at the source level against its roof: `bytes_dram_reads_core` vs 8.8,
  `bytes_into_l2` vs 11 (L3), `bytes_into_l1d` vs 50 (L2).
- Demand vs all traffic: `load_l3_miss_frac` vs `cache_misses`, and `ocr_dram_rd` vs `ocr_reads_dram`.
- `dtlb_load_walks` per 1000 loads.
- `inmodel` vs `standalone_hot` vs `standalone_cold`. A much faster hot run means the cost comes from
  where the data lives, not from the code.

**Not justified:** "DRAM-bound" from `cache_misses` or `llc_miss_ratio`; "bandwidth-bound" without
bytes/cycle against the measured roof; latency vs bandwidth from IPC.

### 3.2 High cycles, high IPC, few cache misses

The core is busy and fed, and there is a lot to execute. Whether that is good depends on *what*
executes.

**Can mean**
1. *Efficient compute-bound code doing necessary work.* FMA-dominated code tops out near IPC 2 (anchor:
   2.06 at peak). IPC of 3 or more means many non-FMA instructions.
2. *Many cheap or unnecessary instructions:* scalar code, interpreter and dispatcher, index math,
   layout conversion. Anchors: integer add at IPC 5.04 with zero FLOPs, and `-O2` saxpy at IPC 5.28
   with about 1.5 FLOP/cycle (2% of peak).
3. *Port pressure at a decent IPC,* for example shuffles competing with the second FMA unit on port 5.

**Tell them apart with**
- `flops_per_cycle` against 63.9 and the width-specific peaks.
- `fp_inst_512_share`, `fp_inst_256_share` and `fp_inst_scalar_share`.
- FLOPs per instruction (CALCULATED): about 31 in the FMA anchor, at most 1 in scalar code.
- Instructions per output element against a minimum (Section 3.10).
- `port0_per_cycle` and `port5_per_cycle` (the 512-bit FMA ports) against `port_load_per_cycle`.

*Preliminary:* most convolutions ran at roughly 50 FLOP/cycle or more, with essentially all FP work in
512-bit instructions and IPC about 2-3.3. That is compute-bound in the good sense. For the whole
inference, IPC is 2.30 (OBSERVED). The average is 39.8 FLOP/cycle, 62% of peak (CALCULATED: 8.217
GFLOP from the manifest over 206.5 M cycles). The compute floor is 128.7 M cycles, about 61 ms, against
98.6 ms measured.

**Not justified:** "efficient" or "near peak" from IPC; "nothing left to gain" without a minimum-work
comparison.

### 3.3 Many instructions, high IPC, heavy vector use

This is the trap of high IPC from the *wrong* instructions. `zmm` registers in the disassembly, or many
vector uops, do not mean the vector work is useful arithmetic.

**Can mean**
1. *Dense FMA work (good).* Only FLOP/cycle confirms it.
2. *Vector data movement:* loads, stores, broadcasts, permutes, blends, compares, conversions, gathers.
   `FP_ARITH` counts none of them. Layout reorders (e.g. oneDNN plain-to-blocked conversions) are
   vector-heavy with zero FLOPs.
3. *Half-width vectors:* 256-bit code caps at 31.9 FLOP/cycle. *Preliminary:* BN and ReLU executed
   their FP work in 256-bit instructions.
4. *Vector code in a serial pattern.* The `dot` built with `-march=native -mprefer-vector-width=512`
   and without `-ffast-math` contains zmm instructions but takes 3.2 cycles per element at IPC 0.70.
   That is slower than scalar `-O2` (1.95), because an in-order reduction is still a chain.
5. *Separate multiply and add instead of FMA:* capped at 31.9 FLOP/cycle.

**Tell them apart with**
- `flops_per_cycle` against 63.9, and FLOPs per instruction.
- The `fp_inst_*_share` values.
- `flops_measured` against manifest `flops`. Direct convolution should be about 1. Below 1 means work
  was skipped (padding taps, Winograd-like algorithms). Above 1 means padded or redundant work.
- `port5_per_cycle` high while FLOP/cycle is low (INFERRED: shuffles competing with FMAs).
- `tma_heavy_ops` and `ms_uops`, for multi-uop instructions such as gathers.

**Not justified:** "well vectorized" because vector instructions exist; "compute-bound" from IPC plus
vector share without FLOP/cycle; blaming vector width for a memory-bound op. At an arithmetic
intensity of 0.25 FLOP/B or less, BN and ReLU cannot exceed about 2.75 FLOP/cycle from L3 whatever the
width (Section 4).

### 3.4 Few instructions, very many cycles

Very high CPI: either each instruction is very expensive, or the cycles are not instruction time.

**Can mean**
1. *Dependent long-latency loads.* The DRAM chase runs about 2 instructions per load, a CPI of
   about 100.
2. *Microcode:* a few instructions expand into many uops (gathers, string moves, FP assists on
   denormals).
3. *Long-latency arithmetic:* divide or sqrt chains (the divider event is not in the catalog).
4. *Kernel work inside the region:* page faults on first touch (`page_faults`). Kernel mode is counted.
5. *An artifact:* the region is barely longer than the pass floor.

`cycles` counts only while the thread runs. If wall time is large but cycles are not, the thread was
blocked or preempted: compare `task_clock` with wall time and check `context_switches`.

**Tell them apart with:** `uops_issued`/`instructions`, `ms_uops`, `tma_heavy_ops`, `stalls_total_frac`,
`stalls_l3_miss_frac`, `mlp_l1d`, `load_l3_miss_frac`, `dtlb_load_walks`, `page_faults`, and the floor.

**Not justified:** "these instructions are expensive" without saying which; blaming DRAM without
load-source evidence.

### 3.5 Low IPC, few cache misses

This is often called "core-bound". It frequently is not.

**Can mean**
1. *An arithmetic dependency chain.* FMA anchor K=1: IPC 0.35 and 8 FLOP/cycle (1/8 of peak) with no
   memory traffic. Hiding the 4-cycle latency at 2 FMA/cycle needs 8 independent accumulators
   (`compute_chains.png`). The `dot` reductions are the real-code version.
2. *A load-latency chain on L1 hits.* L1 chase: IPC 0.28 with every load hitting. Top-down files this
   under Memory Bound (L1 Bound), not Core Bound.
3. *Port contention:* one port saturated while the others idle.
4. *A divider or other long-latency operation.*
5. *Loads blocked without missing:* 4K aliasing or failed store forwarding (not in the catalog).
6. *Not a backend problem:* frontend-bound or bad speculation.

**Tell them apart with**
- Level 1 first, then `tma_memory_bound` vs `tma_core_bound`.
- For core-bound: high `stalls_total_frac` with low port counts means a chain. One port near 1/cycle
  with the others low means contention. A high `ports_util_1` (cycles with exactly one uop executed)
  means a serial chain; that event is supported but not in a default pass.
- For L1-bound (approximation): (`bound_on_loads` - `stalls_l1d_miss`) / cycles.

**Not justified:** "memory-bound" because IPC is low; "core-bound" because misses are few; "needs more
vectorization" for a chain. Wider vectors do not shorten a chain; more independent chains do.

### 3.6 Many LLC misses, little time lost

**Can mean**
1. *Prefetchers run ahead of demand.* The sequential-chase anchor walks the same dependent chain over a
   DRAM-sized buffer in 11.1 cycles per load instead of 208. Every line still comes from DRAM, but
   about 95% of the latency is hidden.
2. *Misses overlap each other and compute.* The intensity anchor with a DRAM-resident working set
   reached 58 FLOP/cycle (91% of peak) at 32 FLOP/B.
3. *Most "misses" are prefetch requests,* some of them never used.

**Tell them apart with**
- Small `stalls_l3_miss_frac` and `tma_memory_bound`: the misses are not costing cycles.
- Small `load_l3_miss_frac` (demand) with large `cache_misses`: the misses are prefetches.
- `load_fb_hit_frac`: demand loads that found their line already in flight (late but useful
  prefetch).
- `ocr_dram_rd` much smaller than `ocr_reads_dram`, with high `l2_hwpf`: DRAM reads are
  prefetch-driven.

**Not justified:** "LLC misses are the bottleneck"; "removing misses will speed it up". The reverse is
not justified either: "not DRAM-limited because `stalls_l3_miss` is small". A bandwidth-bound stream
with good prefetching shows its waiting as L2 or fill-buffer stalls, because the prefetcher did the
DRAM part. Compare bytes/cycle with the roofs first (INFERRED; calibrate with `membw read`).

### 3.7 Memory-bound with a high L1 hit rate

**Can mean**
1. *Store-bound.* Load hit rates say nothing about stores. Missing stores need a read-for-ownership
   (RFO), and the store buffer fills. Anchor: regular stores reach 15.9 B/cycle at L2 sizes against
   49.9 for reads. At DRAM sizes the program sees 7.2 B/cycle while DRAM moves about twice that
   (INFERRED: `membw` does not count RFO bytes).
2. *L1 bandwidth:* two 64 B loads per cycle (anchor: 120 B/cycle at IPC 2.6, all hits). Whether
   top-down shows this as L1 Bound or Core Bound is UNKNOWN until measured.
3. *L1 latency chains:* the 5-cycle chase.
4. *A few expensive misses.* Hit rates are per load, cost is per cycle. With 99% L1 hits and 1%
   exposed DRAM misses, 0.99 x 5 + 0.01 x 208 = 7.0 cycles per load instead of 5.0, so that 1% costs
   30% (CALCULATED).
5. *Full fill buffers* (`fb_full`): a few misses hold every buffer and block other requests,
   including store RFOs.
6. *4K aliasing, store-forwarding blocks* (not in the catalog), or *DTLB walks* (`dtlb_load_walks`).

**Tell them apart with**
- `bound_on_stores_frac`.
- `stalls_l1d_miss_frac` vs `bound_on_loads_frac`.
- `fb_full`/cycles.
- `port_load_per_cycle` near 2 for 512-bit loads: L1 bandwidth.
- `port_std_per_cycle` near 1: store throughput (the L1 write anchor is 63.9 B/cycle, one 64 B
  store per cycle).
- `stores` together with `bytes_l2_writeback`.

**Not justified:** "data is in L1, so memory is not the issue"; naming 4K aliasing without the alias
event or an A/B test that shifts buffer offsets.

### 3.8 Frontend-bound

**Can mean**
1. *A large code footprint:* interpreter, dispatcher and many small operators cause i-cache and ITLB
   misses (fetch latency).
2. *Cold code:* oneDNN JIT kernels on first execution (warm-up should exclude this), or code evicted
   between calls.
3. *Decoded-uop cache (DSB) misses* that force legacy decoding through MITE (fetch bandwidth).
4. *Microcode sequencer switches* (`ms_uops`).
5. *Resteers after mispredicts.* These count as fetch latency, so frontend-bound and bad speculation
   often rise together.

**Tell them apart with**
- `tma_fetch_latency` vs `tma_fetch_bandwidth`.
- `icache_stalls`/cycles.
- Uop source shares `dsb_uops`, `mite_uops`, `ms_uops` and `lsd_uops`. Their sum should roughly match
  `uops_issued`; the exact accounting is UNKNOWN.
- Mispredicts per 1000 instructions.
- Region length, and `inmodel` vs `standalone_hot`.

INFERRED expectation: JIT convolution and GEMM inner loops are small and run from the DSB or the loop
stream detector (LSD). A convolution with a large frontend fraction more likely has Python or framework
code inside its window, or very short calls. Python glue between modules appears as "unattributed"
time in `REPORT.md`.

**Not justified:** "the code is too big" from the frontend fraction alone. Frontend Bound counts only
slots where the backend *could* accept uops. A fetch problem stays hidden in a backend-bound region and
can appear after the backend is fixed.

### 3.9 Bad speculation

`metrics.py` splits bad speculation into `tma_branch_mispredicts` and `tma_machine_clears` (the
difference between the two).

**Branch mispredicts** come from data-dependent branches (scalar compare code, branchy ReLU), loops
with short or variable trip counts (the 7x7 spatial size in stage 4), and the interpreter's indirect
branches. Cross-check (CALCULATED): `branch_misses` x 15-20 cycles / `cycles` should roughly agree
with `tma_branch_mispredicts`.

**Machine clears** come from memory-ordering events (rare single-threaded), self-modifying-code
clears when code pages are written (JIT code generation), and some microcode assists. The catalog has
no `machine_clears.*` events, so the *type* is UNKNOWN.

*Preliminary:* max-pool executed about 40 branches and about 2 mispredicts per output. At 15-20 cycles
each, mispredicts alone would be very roughly a quarter to a third of its cycles (CALCULATED). Most
other operators stayed below about 1 mispredict per 1000 instructions.

**Not justified:**
- "Branchy code is slow" from the branch count. Convolutions run many loop branches and almost never
  mispredict.
- Time lost estimated from `branch_miss_rate`, which is per branch, not per cycle.
- Any machine-clear cause without the events.

### 3.10 High retiring, still slow

Retiring means slots whose uops were not wasted. It does not mean the uops were needed. To judge that,
compare the work done with the minimum work:

- *FLOP-based operators* (conv, linear): `flops_measured` vs manifest `flops`, and FLOP/cycle vs peak.
  The minimum time is FLOPs / 63.9 cycles.
- *Data-movement operators* (pooling, BN, ReLU, Add, reorders): instructions per output element vs a
  CALCULATED minimum.

A useful bound (CALCULATED): at most 2 FMAs retire per cycle and `tma_retiring` x 6 is retired uops
per cycle. At `tma_retiring` of 0.5 or more (3+ uops/cycle), at least a third of retired uops are not
FMAs.

**Worked example (preliminary): max-pool.** The layer has 64 x 56 x 56 = 200,704 outputs, each the max
of a 3x3 window (8 comparisons). A channel-vectorized kernel needs about 1-2 instructions per output.
(CALCULATED: for one pixel with 64 channels, that is 4 zmm vectors, so 36 loads + 32 max + 4 stores =
72 instructions per 64 outputs, about 1.1.)

The control run shows:
- about 200 instructions per output at IPC near 2;
- zero `FP_ARITH` instructions, so no `vmaxps` (INFERRED: compares and branches);
- about 40 branches per output and few LLC misses;
- about a tenth of all inference cycles spent here.

An instruction excess of roughly 100x explains the time better than any stall category. Only a
different kernel or code path fixes it.

**Also check:** a high `tma_heavy_ops` points to microcoded or multi-uop instructions (`ms_uops`).

**Not justified:** "efficient because retiring is high"; "the hardware is the limit".

### 3.11 DRAM traffic: socket-wide CAS vs per-thread offcore

| | Uncore IMC CAS (`imc_cas_read`, `imc_cas_write`) | Offcore response (`ocr_dram_rd`, `ocr_reads_dram`) |
|---|---|---|
| Scope | Whole socket: 28 cores, kernel, devices | This thread only |
| Counts | Every 64 B DRAM burst: demand, prefetch, page walks, RFO, write-backs | Reads from this core served by DRAM (demand, or demand + prefetch); no write-backs |
| Timing | At DRAM access; dirty lines are written back on eviction, possibly during a later operator | At the request |
| Main error | Background from everything else on a shared machine | Event coverage (e.g. prefetches that fill only L3) |

**Background subtraction.** `SYSTEM.md` records idle background of about 65 MB/s read and 45 MB/s
write (CALCULATED from 123.5 and 85.4 MiB over 2.0 s). The `dram` pass of `op_profile.py` subtracts
rate x duration from a 2 s idle sample. At idle that is about 32 KB for a 0.5 ms operator, negligible
against fc's 8.2 MB of weights. A neighbour streaming at single-core speed (18 GB/s) would add about
9 MB in the same window. The subtraction assumes a small, steady background, so re-measure it before
and after the run, and repeat the measurement.

**When you can say "X was DRAM-bandwidth-bound" (INFERRED; all five are needed):**
1. Per-thread DRAM bytes for X (OBSERVED: `ocr_reads_dram` x 64, plus a write estimate). On a quiet
   machine these should agree with background-subtracted CAS reads.
2. Those bytes / cycles approach the single-core roof for the access pattern: 8.8 B/cycle read, 8.4
   copy, 8.5 triad, 7.2 program-visible regular-store writes (CALCULATED).
3. Concurrency evidence: high `tma_memory_bound`, plus high `mlp_l1d` and/or non-trivial `fb_full`.
   An `mlp_l1d` near 1 indicates latency instead.
4. X is slower in-model or `standalone_cold` than `standalone_hot`, by about the extra DRAM time.
5. FLOP/cycle is consistent with the roofline at the *measured* DRAM arithmetic intensity.

Phrase the result as "bound by this core's achievable DRAM bandwidth (about 18.5 GB/s, 6% of the
socket's 307 GB/s theoretical peak)", a per-core concurrency limit, not DRAM saturation.

**You cannot say it:**
- from CAS alone on a shared socket, or from `cache_misses`;
- from compulsory bytes (manifest `min_traffic_bytes`) / cycles, because real traffic can be larger
  (reorders, re-reads) or smaller (cache-resident inputs);
- for very short operators measured once (hook latency, uncore read skew), so loop or repeat;
- for writes, by attributing CAS writes to one operator, because write-backs are delayed;
- in `standalone_hot` mode, where the data is resident.

**Worked candidate (preliminary): fc, a 2048 x 1000 GEMV.** Its weights are 8.2 MB, and the whole model
holds about 102 MB of weights (25.6 M parameters x 4 B, CALCULATED) against a 52.5 MiB L3, so fc's
weights are unlikely to stay cached between inferences (INFERRED). The control run shows IPC near 0.3,
nearly all FP work at 512-bit, an LLC miss count close to the 128 K lines of the weight matrix, and
about 4 FLOP/cycle. The roofline at 0.5 FLOP/B predicts 4.4 FLOP/cycle from DRAM and 5.5 from L3.
This is consistent with DRAM-bandwidth-bound (INFERRED), but items 1 and 3 are still missing.

---

## 4. The roofline as an interpretation tool

```
attainable FLOP/cycle = min( peak FLOP/cycle , AI x bandwidth of the level the data comes from )
AI (arithmetic intensity) = FLOPs / bytes moved at that level            [FLOP/byte]
ridge point = peak / bandwidth     (left of it: bandwidth roof; right of it: compute roof)
```

Measured single-core read roofs (OBSERVED, `read_4k`/`read_thp`). Ridge points and roof values are
CALCULATED with the 63.9 FLOP/cycle peak:

| Level | Read bandwidth (B/cycle) | Ridge AI (FLOP/B) | Roof at AI 0.25 (FLOP/cycle) |
|---|---|---|---|
| L1 | 120 | 0.53 | 30 |
| L2 | 50 | 1.3 | 12.5 |
| L3 | 11.0 | 5.8 | 2.75 |
| DRAM | 8.8 | 7.3 | 2.2 |

Mixed traffic has lower roofs: copy reaches 26 B/cycle from L2, and regular-store writes 15.9.

**Where the roofs hold** (`roofline_microbench.png`, `intensity_summary.csv`):
- Left of the ridges, measured points sit on the bandwidth roofs. At AI 0.25 the kernel achieves 2.2
  FLOP/cycle from DRAM (8.8 B/cycle), 2.75 from L3, 12.4 from L2 and 27.4 from L1.
- L3 points at AI 2.25 and 4.25 sit on the roof (24.1 and 46.4 against 24.8 and 46.8).
- Near the **DRAM** ridge the corner is rounded. At AI 4.25 the kernel reaches 24.6 against 37.4
  (66%), at AI 8.25 it reaches 38.6 against 63.9 (60%), and only at AI 32 does it reach 58.3 (91%).

Even a perfectly regular kernel loses 30-40% near the DRAM ridge. Being below both roofs by about a
third near a ridge is not, by itself, evidence of a problem.

**Which AI to use**
- *Compulsory AI* (manifest `arithmetic_intensity`) assumes every tensor is moved exactly once.
- *Measured AI per level* gives a hierarchical roofline:
  - FLOPs / `bytes_into_l1d` against the L2 roof;
  - FLOPs / `bytes_into_l2` against the L3 roof;
  - FLOPs / `bytes_dram_reads_core` against the DRAM roof.

  The binding level is the point closest to its roof. Measured traffic far above compulsory traffic is
  itself a finding (re-reads, reorders, poor blocking).

**"Below both roofs"** (`analyze_resnet.classify`) means under 50% of peak FLOP/cycle *and* compulsory
bytes moved at under 50% of the read bandwidth of the level the working set fits in (L2 if 2 MiB or
less, otherwise L3). Neither throughput explains the time. The candidates are latency (low `mlp_l1d`),
overhead instructions (3.10), poor vectorization, frontend or speculation losses, or **a wrong
assumption in the classification** (real traffic above compulsory, data from DRAM rather than the
assumed level, or a point on the rounded ridge). Check measured-traffic AI and the flowchart before
writing "latency/overhead".

*Preliminary placement:*
- Most convolutions have compulsory AI from tens to over 100 FLOP/B (conv1: 61; a stage-1 3x3: 132)
  and run near the compute roof.
- The stage-4 3x3 convolutions (AI about 24, 9.4 MB of weights each) ran at roughly half of peak
  while moving far less than 8.8 B/cycle, so they sit below both roofs. The cause is UNKNOWN. Resolve
  it with `stalls_l3_miss_frac`, `mlp_l1d`, and `standalone_hot` vs `inmodel`.
- BN, ReLU and Add have AI of 0.25 or less, and their roughly 2 FLOP/cycle matches the L3/DRAM roofs.
- Max-pool's work is comparisons, which `FP_ARITH` does not count, so the roofline is the wrong tool.
  Use instructions per output.

**Limits:** the roofline places only `FP_ARITH` work, assumes perfect overlap, uses one bandwidth per
level, and ignores latency. It is a bound, not an explanation.

---

## 5. Data-source attribution caveats

Any statement that data came from registers, L1, L2, L3 or DRAM needs load-source counters or
sampling. Comparing working-set size with cache size is not enough.

- **Counting mode gives region totals, not per-instruction facts.** `mem_load_retired.*` counts retired
  *demand* loads by where they were served (`load_*_frac`). A 512-bit load counts once. `fb_hit` means
  the line was already in flight, so its true origin (possibly DRAM, via a prefetch) is hidden.
- **Sampling gives statistical per-instruction attribution.** `perf mem record` (PEBS load latency),
  e.g. on `experiments/infer_loop.py --layer fc`, records the source and latency of *sampled* loads
  above a threshold (default about 30 cycles on Intel), attributed to instruction addresses. That
  supports "about X% of sampled loads in function F came from DRAM". It does **not** support "this
  operand of this instruction came from DRAM" for any particular execution, and loads below the
  threshold are under-represented.
- **Register residency is a code property.** Show it with the disassembly (oneDNN JIT code needs
  `ONEDNN_JIT_PROFILE` or perf JIT dumps to be visible), backed by low `loads_per_instr` or few loads
  per FMA. Load counters only show what was *not* in registers.
- **Prefetch traffic is not demand traffic.** `l1d_replacement`, `l2_lines_in`, `cache_misses` and
  `ocr_reads_dram` include prefetches. `mem_load_retired.*` and `ocr_dram_rd` are demand-only. Bytes
  moved are not bytes needed, and a timely DRAM prefetch costs no stall.
- **An LLC miss does not prove a DRAM access, let alone a DRAM stall.** `LONGEST_LAT_CACHE.MISS`
  includes prefetches (some unused) and code reads. This part's L3 is non-inclusive, so a line can miss
  L3 and still sit in another core's L2 (a snoop). For single-threaded inference that is INFERRED to be
  negligible. Remote sockets do not apply (1 socket, 1 NUMA node).
- **Fills measure traffic, not usage.** `bytes_into_l1d` counts lines brought in, used or not.
  Write-backs (`bytes_l2_writeback`) go to L3, and only some reach DRAM. Non-temporal stores bypass
  the caches.
- **Calibrate event behaviour.** For example, how fused 512-bit uops appear in `port1` is UNKNOWN until
  the FMA anchor is measured with the ports pass.

---

## 6. Decision flowchart

```
[0] VALID?  multiplexed=False | migrations=0 | ctx-switches~0 | freq~2.095 GHz
            cycles >> pass floor | L1 top-down sum~1 | retiring*6 plausible vs IPC
      no --> fix the measurement; interpret nothing
       v yes
[1] HOW FAR FROM MINIMUM WORK?
      compute ops: flops_measured vs manifest; FLOP/cycle vs 63.9 (31.9 AVX2, 4.0 scalar)
      data-movement ops: instructions per output vs CALCULATED minimum
       v
[2] TOP-DOWN LEVEL 1 (fractions of slots, sum = 1; read all four, then follow the largest)
   +-- RETIRING
   |     FLOP/cycle ~64 and fp_512_share~1 ......... compute-bound: only fewer FLOPs help
   |     otherwise ................................. too many instructions: instr/output,
   |                                                 scalar/256-bit share, heavy_ops -> ms_uops
   +-- BAD SPECULATION
   |     br_mispredict ............................. branch_misses/1k instr x 15-20 cycles
   |     machine_clears ............................ type UNKNOWN (machine_clears.* missing)
   +-- FRONTEND BOUND
   |     fetch_latency ............................. icache_stalls, resteers, ITLB*
   |     fetch_bandwidth ........................... dsb vs mite vs ms vs lsd uops
   |     short region? ............................. Python hook/glue inside the window
   +-- BACKEND BOUND
         +-- MEMORY BOUND: stall ladder (fractions of cycles)
         |     stalls_l3_miss ..................... DRAM  --> see below
         |     stalls_l2_miss - stalls_l3_miss .... L3 bound
         |     stalls_l1d_miss - stalls_l2_miss ... L2 bound
         |     bound_on_loads - stalls_l1d_miss ... L1 bound (chains, aliasing*, fwd blocks*)
         |     bound_on_stores .................... store bound (RFO, store buffer full)
         |     DRAM: mlp_l1d~1-2, B/cycle << 8.8 ...... latency-bound (check dtlb walks)
         |           mlp_l1d high, B/cycle -> 8.8 ..... single-core bandwidth-bound (fb_full>0)
         |           low stalls but B/cycle at a roof . prefetch-fed bandwidth limit
         +-- CORE BOUND
               port0 & port5 ~1/cycle, FLOP/cycle high .. FMA throughput (the goal)
               stalls_total high, ports low ............. dependency chain: add chains
               one port ~1, others low .................. port contention (e.g. p5 shuffles)
               divider .................................. UNKNOWN (arith.div* missing)
       v
[3] CROSS-CHECK: roofline at measured AI (Sec. 4); inmodel vs standalone_hot vs standalone_cold
       v
[4] WRITE THE CLAIM with its label and the Section 7 evidence row   (* = not in events.py)
```

The stall ladder approximates Intel's Level-3 memory nodes from catalog events. `metrics.py` exposes
the raw `*_frac` values, so take the differences in analysis. They are fractions of cycles, not
slots, and do not sum exactly to `tma_memory_bound`.

---

## 7. Claim to minimum evidence

| Claim | Minimum evidence (all required) | Insufficient on its own |
|---|---|---|
| X is compute-bound | `flops_per_cycle` >= ~50% of 63.9, `fp_inst_512_share` ~1, low `tma_memory_bound` | High IPC; high retiring; zmm in asm |
| X runs near FP32 peak | Measured `flops_per_cycle` >= ~80% of 63.9, with manifest FLOPs agreeing | Manifest FLOPs / cycles alone |
| X is DRAM-bandwidth-bound | All five items in Section 3.11 | `cache_misses`; CAS on a shared socket; compulsory bytes |
| X is DRAM-latency-bound | High `stalls_l3_miss_frac`, `mlp_l1d` ~1-2, DRAM B/cycle well below 8.8, nonzero `load_l3_miss_frac` | Low IPC; high LLC MPKI |
| X's data comes from level L | `mem_load_retired.*` fractions, consistent with fills (`l1d_replacement`, `l2_lines_in`) | Working-set size vs cache size |
| An instruction's operand came from DRAM | `perf mem` samples at that address (a statistical statement only) | Any counting-mode result |
| X is L1-resident | `load_l1_hit_frac` ~1, small `bytes_into_l1d`, working set <= 48 KiB (CALCULATED) | No LLC misses |
| Prefetching hides X's misses | Many `cache_misses`/`l2_hwpf`; low `stalls_l3_miss_frac` and demand `load_l3_miss_frac`; `ocr_dram_rd` << `ocr_reads_dram` | Low memory-bound alone |
| X is store-bound | High `bound_on_stores_frac`; store count; `bytes_l2_writeback` | Memory-bound with high L1 hit rate |
| X is a dependency chain | Core-bound, high `stalls_total_frac`, low ports/cycle, plus code or anchor evidence | Low IPC with few misses |
| X is frontend-bound | High `tma_frontend_bound` in a long region, its Level-2 split, and a source (`icache_stalls`, DSB/MITE) | FE fraction of a tiny region |
| Mispredicts cost Y% | `tma_branch_mispredicts` cross-checked with `branch_misses` x 15-20 / cycles | `branch_miss_rate` |
| Machine clears are of type T | `machine_clears.*` events (not in the catalog) | `tma_machine_clears` |
| Vector width limits X | Low `fp_inst_512_share`, X not memory-bound, FLOP/cycle near the peak of the width in use | Scalar instructions in asm |
| X does unnecessary work | Instructions per output (or `flops_measured`) vs a written-down CALCULATED minimum | High instruction count |
| X uses AMX | `amx_busy` > 0 | oneDNN verbose names alone |
| Denormals slow X | `ms_uops`/heavy-ops spike plus an A/B run with `torch.set_flush_denormal(True)` | Heavy-ops alone |
| Cache state slows X in-model | `inmodel` slower than `standalone_hot`, with different load-source fractions | In-model time alone |
| Speed-up from fewer instructions (or lower CPI) | The Section 1 decomposition, same pass, before and after | IPC change alone |
| A difference is real | Larger than run-to-run spread (e2e cv 0.14%); no migrations or switches | One run each |

---

## 8. Events the catalog lacks

These discriminators are not in `cpuinf/events.py`. Event names differ between kernel and perf
versions, so add candidates and let `scripts/discover_perf_events.py` decide which exist. Never assume
an event exists.

| Question | Candidate event(s) |
|---|---|
| 4K aliasing | `ld_blocks_address.alias` |
| Store-forwarding blocks | `ld_blocks.store_forward` |
| Divider busy | `arith.div_active` (or `arith.fpdiv_active`, `arith.idiv_active`) |
| Machine-clear type | `machine_clears.count`, `.memory_ordering`, `.smc` |
| FP assists (denormals) | `assists.fp`, `assists.any` |
| ITLB and store-TLB walks | `itlb_misses.walk_completed`, `dtlb_store_misses.walk_completed` |
| Split loads | `mem_inst_retired.split_loads` |
| L1 misses waiting on L2 | `l1d_pend_miss.l2_stall` |

Some events are supported but in **no default pass**: `ports_util_1`, `ports_util_2`, `l2_rqsts_miss`
and `load_l2_miss`. Add a pass (checked with `plan_groups`) before relying on them.
