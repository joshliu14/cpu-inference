# ResNet-50 on CPU: compute and memory bottlenecks (master results)

Every compute and memory bottleneck measured in this project, with where it
is, how large it is, the mechanism, and the evidence. ResNet-50 inference,
FP32, batch 1 unless stated, PyTorch 2.14.1 eager (oneDNN 3.12, MKL 2024.2),
Intel Xeon Gold 5512U (28 cores, SMT off, turbo off, fixed 2.1 GHz,
8 x DDR5-4800).

Labels: **OBSERVED** = measured here; **CALCULATED** = arithmetic on
measurements or tensor shapes; **INFERRED** = best explanation consistent
with several observations, not measured directly. Every table names its
source. Path abbreviations:

| abbreviation | directory |
|---|---|
| `MB` | `results/2026-10-05_microbench/` (native microbenchmarks) |
| `BASE` | `results/2026-10-06_resnet_baseline/` (per-operator counters, one core) |
| `INS` | `results/2026-10-06_instruction_profile/` (perf record, annotate, perf mem) |
| `BK` | `results/2026-10-06_backend_003851/` (library per operator) |
| `ISA` | `results/2026-10-06_isa_probe/` |
| `PC` | `results/2026-10-06_per_calc/` (cost per calculation) |
| `OPT` | `results/2026-10-06_optimizations/` |
| `FU` | `results/2026-10-06_followups/` |
| `MC` | `results/2026-10-06_multicore/` (first multi-core run) |
| `MCS` | `results/2026-10-06_mc_study/` (multi-core study with counters) |
| `VT` | `results/2026-10-06_vtune/` (Intel VTune) |

---

## 0. The answer

1. **One core is compute-bound where it matters.** The 53 convolutions take
   80% of the 98.6 ms and run at 77% of FMA peak (49 FLOP/cycle of 63.9),
   limited by FMA throughput, not memory.
2. **About 28 ms of the 98.6 ms is recoverable overhead around the
   convolutions** (CALCULATED, `docs/RESULTS.md` 21.5). The time spent there
   is 31.9 ms: a scalar, branch-mispredicting max-pool (10.2 ms), oneDNN
   re-laying-out weights (6.5 ms) and activations (2.0 ms) on every call,
   AVX2-only element-wise kernels run as separate memory passes (8.9 ms), and
   framework and Python glue (~4.3 ms). Removing it (torch.compile) gives
   70.4 ms, 87% of FMA peak.
3. **Memory costs time on one core in three places only:** fc (DRAM
   bandwidth), the layer1-2 element-wise ops (limited by how many misses one
   core can keep in flight: L1 fill buffers full in 70% of add's cycles, the
   L2 super queue full in 48%), and the software re-layout traffic. The 98
   MiB of weights stream from DRAM every inference but at only ~1.4 GB/s.
4. **The memory hierarchy's real contribution on one core is
   operator-to-operator reuse on chip:** the same operators run 7.2 ms slower
   when each starts with cold caches.
5. **On 28 threads (one image) the bottleneck becomes synchronization:** 61%
   of cycles in the OpenMP runtime, conv math only 26% of the time, plus
   cross-core cache transfers (54% of on-chip reads are HitM). DRAM stays at
   3% of the ceiling.
6. **With 28 independent copies the bottleneck becomes the shared L3:** LLC
   misses and DRAM traffic per image x4.3, loaded memory latency x2, each copy
   22% slower; DRAM bandwidth still only 56% of the measured ceiling.

---

## 1. Reference frame: what the hardware can do (OBSERVED, `MB/processed/`)

### 1.1 Compute (one core, `machine_model.json`, `compute_summary.csv`)

| instruction | latency (cycles) | throughput | peak FP32 FLOP/cycle |
|---|---|---|---|
| AVX-512 FMA (16 lanes) | 4.0 | 2 per cycle | **63.9 (134 GFLOP/s)** |
| AVX2 FMA (8 lanes) | 4.0 | 2 per cycle | 31.9 |
| SSE FMA (4 lanes) | 4.0 | 2 per cycle | 16.0 |
| scalar FMA | 4.0 | 2 per cycle | 4.0 |
| AVX-512 add | 3.4 | 2 per cycle | 31.9 |
| AVX-512 max (ReLU, max-pool) | 4.0 | 2 per cycle | 32 compares/cycle |

No AVX-512 frequency drop (2.095 GHz with 512-bit FMAs running). One
multiply-add costs 0.0149 ns at peak, 1.91 ns if each waits for the previous
one (`PC/processed/PER_CALC.md`).

### 1.2 Memory levels (one core, `memlat_summary.csv`, `membw_summary.csv`)

| level | size | load latency | read bandwidth, one core |
|---|---|---|---|
| L1D | 48 KiB / core | 5 cycles (2.4 ns) | 120 B/cycle (252 GB/s) |
| L2 | 2 MiB / core | 16 cycles (7.7 ns) | 50 B/cycle (105 GB/s) |
| L3 | 52.5 MiB shared | 63-68 cycles (30-32 ns) | 11 B/cycle (23 GB/s) |
| DRAM | 8 channels | 208-209 cycles (99 ns) | 8.8 B/cycle (18.5 GB/s) |

* 4 KiB pages add ~50 cycles of page walk at 1 GiB (DRAM latency 259 cycles).
* DRAM traffic (read + write) with n cores streaming reads (`MCS/raw/membw_ceiling.json`):
  18.1 / 37.5 / 74.5 / 140.9 / 235.2 / **244.2 GB/s** at 1 / 2 / 4 / 8 / 16 /
  28 cores (80% of the 307 GB/s theoretical, CALCULATED). One core gets 7%.
* INFERRED: one core is limited by misses in flight, not by DRAM (Little's
  law: 18 GB/s x ~100 ns = ~28 lines in flight). Section 3.4 measures the
  fill-buffer limit directly.

### 1.3 Roofline measured on this core (`intensity_summary.csv`, FLOP/cycle reached)

| FLOP per byte | 0.25 | 0.75 | 1.25 | 2.25 | 4.25 | 8.25 | 16.25 | 32.25 |
|---|---|---|---|---|---|---|---|---|
| from L1 | 27.4 | 47.7 | 53.1 | 57.4 | 60.1 | 61.7 | 62.4 | 63.0 |
| from L2 | 12.4 | 37.0 | 53.0 | 57.3 | 60.3 | 61.9 | 62.5 | 63.2 |
| from L3 | 2.7 | 8.2 | 13.4 | 24.1 | 46.4 | 60.1 | 61.7 | 62.2 |
| from DRAM | 2.2 | 6.5 | 10.4 | 15.7 | 24.6 | 38.6 | 51.4 | 58.3 |

From DRAM a kernel needs ~32 FLOP/byte to reach 90% of peak (the
theoretical ridge, 63.9 / 8.8 = 7.3 FLOP/byte, is optimistic: CALCULATED).
ResNet's convs have 16-166 FLOP per compulsory byte; its element-wise ops
0.08-0.25 (`BASE/processed/manifest.csv`).

### 1.4 Code generation matters as much as hardware (`flags_summary.csv`)

ReLU over an L1-resident array: 2.62 cycles/element at `-O2` (scalar),
0.31 at `-O3`, 0.18 at `-O3 -march=native` (AVX2), 0.09-0.11 with zmm. The
same loop inside ResNet costs 0.40 cycles/element (CALCULATED from 0.19 ns
per element, `PC`), 2.2x the AVX2 reference, because its tensors do not fit
in L1/L2 (section 3.4).

---

## 2. One core: where the time goes (OBSERVED, `BASE/processed/REPORT.md`)

98.57 ms median of 300 (sd 0.14 ms); 206.5 M cycles; 475.2 M instructions;
IPC 2.30; 8.22 GFLOP = 62% of FMA peak; compute floor 61.3 ms (CALCULATED).
Explicit model == torchvision (max abs diff 0.0, 98.55 ms).

| operator type | count | ms | % time | % FLOPs | FLOP/cycle | IPC |
|---|---|---|---|---|---|---|
| conv 1x1 | 36 | 41.05 | 41.6 | 51.6 | 49.3 | 2.85 |
| conv 3x3 | 16 | 35.89 | 36.4 | 45.0 | 49.1 | 1.92 |
| max-pool | 1 | 10.22 | 10.3 | 0.02 | 0.075 | 1.99 |
| batchnorm | 53 | 4.93 | 5.0 | 0.3 | 2.1 | 2.05 |
| conv 7x7 | 1 | 2.17 | 2.2 | 2.9 | 51.7 | 1.90 |
| residual add | 16 | 2.05 | 2.1 | 0.1 | 1.3 | 0.92 |
| ReLU | 49 | 1.82 | 1.8 | 0.1 | 2.4 | 1.41 |
| fc + avgpool + flatten | 3 | 0.60 | 0.6 | 0.05 | 3.3 | 0.47 |

Roofline classification (rule in `REPORT.md`): **53 operators compute-bound
(79.1 ms, 80%)**, 34 bandwidth-bound on L3 (6.2 ms, 6%), 87 below both roofs
(13.4 ms, 14%: max-pool and small element-wise calls).

By stage: stem 12.9 ms (8.8 FLOP/cycle: the max-pool), layer1 14.6 (43.9),
layer2 20.1 (48.8), layer3 29.0 (48.1), layer4 21.5 (**35.9**).

---

## 3. One core: bottlenecks by location

### 3.1 Convolutions: FMA-throughput-bound (OBSERVED, `BASE`, `INS`)

* 99.999% of conv FP instructions are 512-bit packed FMA; convs retire 1.42
  (3x3) to 1.63 (1x1) of 2 possible FMAs per cycle; ports 0 and 5 (the FMA
  ports) 72-88% busy; 97% of conv loads hit L1; L3-miss stalls 2.4-2.8% of
  cycles. Top-down: retiring 0.47, core-bound 0.32-0.41, memory-bound
  0.07-0.09.
* Libraries (`BK/processed/BACKEND.md`): the 33 unstrided 1x1 convs run MKL
  SGEMM (`mkl_blas_avx512_sgemm_kernel_*`); 3x3, 7x7 and the 3 strided 1x1
  convs run oneDNN JIT `avx512_core`.
* oneDNN skips multiply-adds on zero padding: padded 3x3 convs on 7x7 and
  14x14 maps execute 0.82x and 0.91x the textbook FLOPs, exactly (19/21)^2
  and (40/42)^2 (OBSERVED + CALCULATED).

**Efficiency falls with depth** (CALCULATED from `BASE/processed/layer_table.csv`, means per group):

| stage | group | n | ms | % of FMA peak | L1 hit | L3-miss stalls | TMA memory | TMA core | weights from DRAM (MB) |
|---|---|---|---|---|---|---|---|---|---|
| layer1 | 1x1 | 7 | 5.3 | 90% | 97% | 1.0% | 0.03 | 0.42 | 0.8 |
| layer1 | 3x3 | 3 | 5.9 | 87% | 99% | 0.5% | 0.05 | 0.16 | 0.7 |
| layer2 | 1x1 | 9 | 9.7 | 89% | 96% | 1.1% | 0.05 | 0.42 | 2.7 |
| layer2 | 3x3 | 4 | 7.9 | 88% | 99% | 1.0% | 0.04 | 0.21 | 2.5 |
| layer3 | 1x1 | 13 | 14.9 | 78% | 96% | 3.1% | 0.09 | 0.42 | 12.1 |
| layer3 | 3x3 | 6 | 12.4 | 84% | 99% | 2.9% | 0.06 | 0.33 | 14.1 |
| layer4 | 1x1 | 7 | 11.2 | 62% | 94% | 3.2% | 0.10 | 0.39 | 22.5 |
| layer4 | 3x3 | 3 | 9.7 | **53%** | 96% | 5.7% | 0.11 | 0.49 | 28.1 |
| stem | 7x7 | 1 | 2.2 | 81% | 99% | 0.7% | 0.12 | 0.52 | 1.1 |

Where the layer4 loss comes from (`PC`, per-layer library timers):

| layer | ms | per multiply-add vs core peak | split |
|---|---|---|---|
| `layer2.0.conv1` (best) | | 1.04x | MKL kernel at 1.02x |
| `layer4.0.conv2` | 3.42 | 1.98x | kernel 2.22 ms (1.29x), **weight re-layout 1.08 ms (32%)** |
| `layer4.0.downsample.0` | 2.89 | 1.89x | kernel 1.78 ms, **weight re-layout 0.90 ms (31%)** |
| `layer4.x.conv3` (MKL) | 1.24 | 1.6x in the kernel | no re-layout |

* Memory is a minor part of it: layer4 weights stream at 2.9 GB/s (16% of
  one core's DRAM rate) and L3-miss stalls stay at 3-6% of cycles.
* INFERRED: on 7x7 maps the matrix multiply has only 49 columns, too few to
  block well (core-bound 0.49), and oneDNN converts 9.4 MB weight tensors on
  every call.

### 3.2 Max-pool: instruction count and branch mispredictions, not memory (OBSERVED, `INS`, `OPT`)

* 10.2 ms (10.3% of time) for 0.02% of FLOPs: 5.70 ns per comparison, 382x
  the core's best (`PC`).
* Per pooled output: 214 instructions, 39 branches, **1.85 mispredictions**,
  62 loads; a scalar `vmovss`/`vcomiss`/`ja` loop with an `isnan` check in
  double precision; also computes int64 argmax indices that inference
  discards. Top-down: bad speculation 0.37, front-end 0.28, memory 0.00.
* Proof: the channels-last kernel takes 6.4 cycles and 23.6 instructions per
  output, no mispredictions; max-pool 10.19 -> 1.81 ms including both layout
  conversions (`OPT/processed/maxpool_mechanism.csv`).

### 3.3 Element-wise ops: narrow code and separate passes (OBSERVED, `ISA`, `INS`, `PC`)

* ReLU, add, BN and avgpool run 256-bit AVX2 code on an AVX-512 machine:
  this PyTorch build has no AVX-512 instantiation of these kernels (0 of
  `add_kernel`, `clamp_min_scalar`...; 36 dispatched kernels have AVX-512
  builds, 48 do not). Forcing `ATEN_CPU_CAPABILITY=avx512` changes nothing:
  ReLU on 802,816 elements retires exactly 100,352 256-bit ops.
* BN's hot loop reloads its data pointers through two indirections each
  iteration (46% of samples on `mov rcx,[rcx]`). INFERRED: pointers captured
  by reference in a lambda that may alias the output.
* Cost per element vs core best: ReLU 13x, add 25x, BN 29x (layer4 BN 79x:
  25K-element calls are dominated by the ~10 us fixed call cost).

### 3.4 Element-wise ops: the memory side (OBSERVED, `BASE/processed/layer_table.csv`)

Per stage (means over the calls):

| stage | op | calls | ms | working set (MB) | bytes into L2 per cycle | cycles stalled on L1D misses | TMA memory-bound |
|---|---|---|---|---|---|---|---|
| layer1 | add | 3 | 0.95 | 9.6 | 9.9 | **57%** | 0.49 |
| layer1 | BN | 10 | 1.76 | 3.5 | 7.6 | 21% | 0.26 |
| layer1 | ReLU | 9 | 0.71 | 3.2 | 4.6 | 25% | 0.20 |
| layer2 | add | 4 | 0.63 | 4.8 | 9.8 | 56% | 0.47 |
| layer3 | add | 6 | 0.39 | 2.4 | 8.4 | 47% | 0.37 |
| layer4 | add | 3 | 0.09 | 1.2 | 6.7 | 37% | 0.27 |

* Tensors larger than the 2 MiB L2 (layer1-2) refill L2 from L3 at ~10
  B/cycle, close to the 11 B/cycle one core gets from L3.
* **What limits that rate: the L1 fill buffers.** Cycles in which a demand
  load was blocked because all fill buffers were busy
  (`l1d_pend_miss.fb_full`): **add 70%, ReLU 70%, fc 60%**, BN 10%, convs
  5%. Average L1D misses in flight while any is pending: add 10.9, fc 10.4,
  ReLU 3.7, BN 2.7. INFERRED: element-wise ops on L2-overflowing tensors, and one
  core's L3 and DRAM bandwidth, are capped by miss-level parallelism.

### 3.5 fc: DRAM-bandwidth-bound (OBSERVED)

8.1 MB of weights read once in 0.50 ms = 16 GB/s, 87% of one core's DRAM
rate; fill buffers full 60% of cycles with 10.4 misses in flight; IPC 0.31; 69% of cycles stalled on L3 misses; L1 hit rate 33%; 90% of
samples on four `vfmadd231ps zmm` with memory operands. Cost 0.24 ns per
multiply-add = the time to fetch 4 bytes from DRAM (CALCULATED).

### 3.6 Re-layout and framework: software-created work (OBSERVED, `PC`, `BK`, `FU`)

Conv time split with the libraries' own timers (one thread, 79.3 ms of convs
+ fc): compute kernels 68.4 ms, **weight re-layout 6.5 ms** (oneDNN converts
56 MB of weights on every call), activation re-layout 2.0 ms (NCHW <->
blocked), framework around convs 2.5-2.7 ms. Python layer 1.58 ms (eager
98.63 vs traced 97.05 ms); dispatch fixed cost ~1-17 us per call, ~1.3 ms per
inference.

---

## 4. One core: memory behaviour in numbers

### 4.1 Traffic per inference (OBSERVED, `BASE`; memory-controller column from `MCS`, one core)

| into L1D | into L2 | DRAM reads (core counters) | DRAM reads+writes (memory controller) | compulsory (CALCULATED) |
|---|---|---|---|---|
| 1.79 GB | 543 MB | 94 MB | 137 MB | 426 MB |

* Weights (97.7 MiB) exceed the 52.5 MiB L3: each layer's DRAM reads equal
  its weight size (layer4 3x3 9.4 MB each, layer4.0.downsample 8.1 MB, fc
  8.1 MB). Most L3 misses: the layer4 3x3 convs (~150 K each),
  layer4.0.downsample (130 K), fc (128 K = 8.2 MB = its weights).
* Activations (largest 3.2 MB) stay on chip: 1.9 MiB of DRAM writes per
  inference (core counters).
* Average DRAM traffic 1.4 GB/s (`MCS`, 1 core) = 8% of one core's 18 GB/s.

### 4.2 On-chip reuse between operators is worth 7 ms (OBSERVED, `BASE`, standalone hot / cold passes)

Each operator re-run alone with warm caches (hot) or after flushing the
caches (cold):

| op type | in model (ms) | alone, hot | alone, cold | TMA memory-bound in model / cold | DRAM reads in model / cold (MB) |
|---|---|---|---|---|---|
| ReLU | 1.82 | 1.65 | **3.27** | 0.16 / 0.40 | 0.07 / 17.6 |
| batchnorm | 4.93 | 4.43 | **6.91** | 0.17 / 0.33 | 0.94 / 34.7 |
| add | 2.05 | 1.84 | 2.52 | 0.40 / 0.50 | 0.10 / 13.3 |
| conv 1x1 | 41.05 | 39.91 | 42.88 | 0.07 / 0.09 | 38.1 / 52.8 |
| conv 3x3 | 35.89 | 35.41 | 37.33 | 0.07 / 0.08 | 45.4 / 46.5 |
| **all operators** | **98.73** | 95.96 | **105.90** | | |

In the model, each element-wise op reads the previous operator's output from
L2/L3; started cold, it reads it from DRAM. This is the reuse that 28
independent copies lose when they share the L3 (section 6).

### 4.3 Latency is mostly hidden (OBSERVED, `INS` perf mem, `MCS`)

| data source of sampled slow loads (>= 30 cycles) | share of loads | mean latency (cycles) | share of latency |
|---|---|---|---|
| line already in flight (LFB) | 30% | 98 | 43% |
| L2 | 26% | 71 | 27% |
| L3 | 15% | 75 | 16% |
| DRAM | 2.9% | 268 | 11% |

Average L2-miss latency (Little's law on offcore occupancy): 67 ns on one
core, against 99 ns for an idle DRAM access. INFERRED: prefetches arrive late
rather than not at all.

### 4.4 Batch size on one core (OBSERVED, `MCS`)

| batch | ms per image | DRAM traffic per image (MB) | LLC misses per image (M) | FMA peak per busy cycle |
|---|---|---|---|---|
| 1 | 98.8 | 137 | 1.46 | 62% |
| 4 | 100.1 | 153 | 1.27 | 61% |
| 16 | 126.9 | 492 | 4.19 | 47% |
| 64 | **159.2** | 712 | 6.36 | 38% |

Batching never helps one core. From batch 16 the activations (3.2 MB x 16 =
51 MB per layer1 tensor) no longer fit in L3 and stream through DRAM; the
weight traffic saved (98 MB once per batch) is much smaller than the
activation traffic added (INFERRED). L3-miss stalls rise only 2.5% -> 4.4% of
cycles, so the full cause of the 61% slowdown at batch 64 is still open.

---

## 5. Actual vs reference: cost of one calculation (OBSERVED, `PC/processed/PER_CALC.md`)

| operator | unit | average | best layer | worst layer | x core peak (avg) |
|---|---|---|---|---|---|
| conv 1x1 (36) | multiply-add | 0.0193 ns | 0.0155 `layer2.0.conv1` | 0.0282 `layer4.0.downsample.0` | 1.29x |
| conv 3x3 (16) | multiply-add | 0.0194 ns | 0.0165 `layer2.3.conv2` | 0.0296 `layer4.0.conv2` | 1.30x |
| conv 7x7 (1) | multiply-add | 0.0184 ns | | | 1.23x |
| fc | multiply-add | 0.2425 ns | | | 16x |
| ReLU (49) | element | 0.188 ns | 0.146 | 0.326 `layer4.1.relu2` | 13x |
| add (16) | element | 0.367 ns | 0.296 | 0.392 `layer2.0.add` | 25x |
| batchnorm (53) | element | 0.440 ns | 0.339 | 1.179 `layer4.0.bn2` | 29x |
| avgpool | element | 0.769 ns | | | 52x |
| max-pool | comparison | 5.697 ns | | | **382x** |

Core peak = 0.0149 ns per multiply-add, compare or add (AVX-512, both ports).

---

## 6. Proof of cause: fixing each bottleneck (OBSERVED, `OPT/processed/OPTIMIZATIONS.md`)

Same run, same weights, interleaved; baseline 100.50 ms in this run.

| change | ms | speedup | mechanism confirmed by counters |
|---|---|---|---|
| max-pool on a channels-last copy | 92.09 | 1.09x | 214 -> 24 instructions per output; 0 mispredictions |
| fold BN into convs | 98.54 | 1.02x | BN -5.0 ms, but MKL 1x1 convs +2.8 ms (bias copied into each output first: `aten::copy_` 2 -> 35 calls) |
| whole model channels-last | 89.73 | 1.12x | activation re-layouts 39 -> 0; weight re-layouts remain (7.9 ms) |
| oneDNN layout end to end | 93.85 | 1.07x | all 53 convs now re-lay-out weights: 93.8 MB, 12.1 ms |
| TorchScript freeze | 84.19 | 1.19x | BN folded; 53 weight re-layouts still run (11.8 ms) |
| **torch.compile (inductor, freezing)** | **70.41** | **1.43x** | zero re-layouts (weights prepacked), BN/ReLU/add fused into convs; IPC 2.95; 87% of FMA peak |

Inductor's conv math is not faster (the same 20 convs: 34.9 vs 35.1 ms):
the whole 30.1 ms gain is the work around the convs, matching the ~28 ms the
baseline analysis judged recoverable (CALCULATED).

---

## 7. Multi-core, one image on N threads: synchronization, not memory (OBSERVED, `MCS`)

Latency = median; throughput, speedup, efficiency from mean latency.

| cores | latency ms | speedup | efficiency | IPC | cycles in OpenMP runtime | cycles in compute kernels | DRAM GB/s (% of N-core ceiling) | DRAM MB / image | L2 fills / image (MB) | avg L2-miss latency (ns) | HitM reads / image |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 98.8 | 1.00 | 100% | 2.30 | 0% | 97% | 1.4 (8%) | 137 | 541 | 67 | 0.2 K |
| 2 | 56.3 | 1.76 | 88% | 2.00 | 6% | 90% | 2.3 (6%) | 129 | 632 | 72 | 60 K |
| 4 | 32.4 | 3.05 | 76% | 1.76 | 19% | 77% | 4.6 (6%) | 150 | 608 | 86 | 175 K |
| 8 | 20.4 | 4.82 | 60% | 1.42 | 32% | 66% | 6.5 (5%) | 132 | 634 | 97 | 424 K |
| 16 | 15.4 | 6.37 | 40% | 0.87 | 45% | 54% | 8.4 (4%) | 131 | 775 | 110 | 796 K |
| 28 | 15.4 | 5.89 | 21% | 0.55 | **61%** | 36% | 8.0 (3%) | 134 | 1,173 | 110 | **1,377 K** |

(HitM = demand reads served by a line modified in another core's cache,
`MCS/xcore/`; a separate run with the same configuration. "Cycles in compute
kernels" = share of cycle samples in conv, GEMM and element-wise kernels x
the unhalted fraction; cores are 97-100% unhalted throughout because OpenMP
threads spin.)

Where one inference's time goes (`MCS/processed/split_by_threads.csv`, ms):

| part | 1 | 2 | 4 | 8 | 16 | 28 | speedup at 28 |
|---|---|---|---|---|---|---|---|
| conv kernels | 68.5 | 32.9 | 16.7 | 8.7 | 5.3 | 4.0 | 17.3x |
| weight re-layout | 6.5 | 5.4 | 2.9 | 1.8 | 1.2 | 1.3 | 5.2x |
| activation re-layout | 2.0 | 3.8 | 2.5 | 2.0 | 1.8 | 2.5 | 0.8x |
| framework around convs | 2.7 | 4.6 | 4.3 | 4.1 | 3.9 | 3.8 | 0.7x |
| BN + ReLU + add | 8.9 | 4.9 | 3.3 | 2.8 | 2.7 | 3.0 | 3.0x |
| max-pool | 10.2 | 4.7 | 2.4 | 1.2 | 0.6 | 0.5 | 20.9x |
| all operators | 98.9 | 56.3 | 32.0 | 20.7 | 15.6 | 15.1 | 6.6x |

Mechanisms, by transition:

* **1 -> 2 threads: the code changes.** PyTorch sends all 53 convs to oneDNN
  (MKL calls per inference 34 -> 1; oneDNN convs 20 -> 53;
  `MCS/raw/verbose_per_op_K*.txt`), so all 94 MB of weights are re-laid-out
  per call and activation re-layout and framework time rise.
* **2 -> 8: compute scales, the work around it does not;** threads spin in
  the OpenMP runtime (6% -> 32%) while serial or tiny regions run.
* **8 -> 28: adding cores adds waiting.** 32% -> 61% of cycles in the OpenMP
  runtime, IPC 1.42 -> 0.55, work imbalance (max/mean per core) 1.11 -> 1.33.
  At 26 threads each BN/ReLU/add call takes 22-26 us whatever its size (118
  calls = 2.8 ms, `FU`); layer4.1/4.2 3x3 convs (49 output pixels) scale only
  4.6-4.9x; ~1.2 ms of Python stays serial. Amdahl fit: ~12 ms effective
  serial part (CALCULATED).
* **Memory side:** DRAM bytes per image stay flat (129-150 MB) and L3-miss
  stalls fall (2.5% -> 1.1%), but data moves between cores: from 8 threads
  on, ~half of on-chip demand reads are HitM transfers, L2 fills per image
  double, L2-miss latency rises 67 -> 110 ns. INFERRED: each operator splits
  its output across cores differently from how the next reads it.
* Inductor: 70.1 -> 7.6 ms (throughput 9.0x at 16, 8.4x at 28), 51% of
  cycles in the OpenMP runtime at 28, and 18x fewer HitM transfers (77 K per
  image).

---

## 8. Multi-core, N independent copies: shared-L3 capacity (OBSERVED, `MCS`, `MC`)

| copies | per-copy latency ms | throughput img/s | efficiency | LLC misses / image (M) | DRAM MB / image | DRAM GB/s (% of ceiling) | L3-miss stall cycles | avg L2-miss latency (ns) | L2 fills / image (MB) |
|---|---|---|---|---|---|---|---|---|---|
| 1 | 98.8 | 10.1 | 100% | 1.46 | 137 | 1.4 (8%) | 2.5% | 67 | 541 |
| 4 | 101.2 | 39.5 | 98% | 3.35 | 300 | 11.9 (16%) | 5.2% | 78 | 539 |
| 8 | 103.7 | 77.2 | 95% | 4.41 | 409 | 31.6 (22%) | 7.2% | 85 | 539 |
| 16 | 108.8 | 147.1 | 91% | 5.60 | 528 | 77.6 (33%) | 10.5% | 99 | 537 |
| 28 | **120.4** | **231.6** | 82% | **6.28** | **586** | 135.8 (56%) | **15.4%** | **132** | 535 |

* L2 fills per image do not change, so each core's private caches behave as
  alone; the misses appear at the shared L3 (x4.3) and go to DRAM.
* DRAM writes per inference rise 11 -> 171 MB (26 copies, `MC`): INFERRED,
  BN/ReLU/add outputs that used to stay in L3 (section 4.2) now spill. Each
  copy's L3 share is ~1.9 MiB, below the largest activation (3.2 MB).
* Loaded latency explains most of the slowdown (CALCULATED): L3-miss stall
  time 2.5 -> 18.5 ms per inference = 16 of the 21.6 ms (74%).
* Copies share no data (HitM 0.7% of on-chip reads).
* Inductor copies: 26.2x on 28 cores (93%), DRAM 106 -> 178 MB per image,
  +6% per copy; fusion keeps BN/ReLU/add intermediates inside the convs.

---

## 9. Splitting cores, inter-op, batch (OBSERVED, `MCS`)

**28 cores split between intra-op threads and streams** (ms latency / img/s):

| threads x streams | 1x28 | 2x14 | 4x7 | 7x4 | 14x2 | 28x1 |
|---|---|---|---|---|---|---|
| baseline | 120 / 232 | 64.5 / 216 | 34.3 / 201 | 24.1 / 162 | 17.5 / 109 | 15.4 / 60 |
| inductor | 74.5 / 373 | 39.2 / 354 | 21.3 / 324 | 14.2 / 274 | 9.7 / 196 | 7.6 / 120 |

**Operator-level inter-op** (`MCS/interop_rerun/`): only the 4 downsample
branches (9.0 of 98.9 ms) can overlap the main path, so the limit is 1.10x
(CALCULATED). A traced model with forked branches reaches it: 98.2 -> 88.7 ms
on 2 cores (1.11x); eager PyTorch never runs two operators at once. With
`OMP_PROC_BIND=close` the inter-op threads inherit a one-core mask and gain
nothing.

**Batch x cores** (img/s): 1 core 10.1 / 10.0 / 7.9 / 6.3 at batch 1 / 4 /
16 / 64; 28 threads 59.5 / **104.3** / 65.6 / 43.7. Batch 4 helps threads
(OpenMP share 61% -> 46%); batch >= 16 hurts everywhere (DRAM per image x2.4-4.1
at 28 cores, x3.6-5.2 on one core).

---

## 10. Bottleneck migration summary

| configuration | dominant bottleneck | type | key evidence |
|---|---|---|---|
| 1 core, convs (80%) | FMA throughput | compute | 77% of peak, FMA ports 72-88% busy, 97% L1 hits |
| 1 core, max-pool (10%) | instruction count, mispredictions | compute (front-end/speculation) | 214 instr and 1.85 mispredicts per output |
| 1 core, BN/ReLU/add (9%) | misses in flight (fill buffers), AVX2 width | memory + code | fill buffers full 70% of add/ReLU cycles |
| 1 core, re-layout (8.5%) | software-created memory traffic | memory (software) | 56 MB rewritten per inference |
| 1 core, fc (0.5%) | DRAM bandwidth | memory | 87% of one core's DRAM rate |
| 2-4 threads | backend switch + non-scaling work | software | all convs to oneDNN; framework time x1.7 |
| 8-28 threads | synchronization, too little work per operator | software / parallelism | 32-61% of cycles in OpenMP runtime |
| 8-28 threads (memory side) | cross-core transfers | memory (on chip) | ~54% of on-chip reads HitM; L2-miss latency 110 ns |
| 16-28 copies | shared-L3 capacity -> DRAM traffic, loaded latency | memory | LLC misses x4.3, L2-miss latency 132 ns, 56% of ceiling |
| batch >= 16 | activations spill to DRAM | memory | DRAM per image x3.6-5.2 (1 core) |
| operator inter-op | graph dependencies | structure | 1.10x limit, reached |

DRAM **bandwidth** is the limit only for fc. Even the heaviest configuration
(28 baseline copies) uses 56% of the measured ceiling.

---

## 11. VTune (Intel VTune Profiler 2026.4, `VT/`)

`scripts/run_vtune.sh` runs `uarch-exploration` (full top-down hierarchy) and
`memory-access` under `experiments/vtune_run.py`, which labels every PyTorch
operator as an ITT task. Collected: one core (both analyses) and 28 threads
(uarch only) (`VT/processed/*_by_task.csv`, analysis
`analysis/analyze_vtune.py` -> `VT/processed/VTUNE.md`). One core: 1,200
inferences (uarch) and 600 (memory), quiet machine (other users <= 28% of one
core). **Caveat:** the account is not in the `vtune` group, so collection is
driverless and the TMA events are multiplexed in one run. Rows whose level-1
fractions are far from 100% (ReLU 157%, oneDNN re-layout 140%, fc 130%) are
not used below; the oneDNN conv row (111%) is used only for ratios inside the
front-end and port metrics, and its front-end conclusion rests on perf's
exact numbers.

### 11.1 Cross-check against the exact perf measurement (OBSERVED, `VT/processed/crosscheck_tma_level1.csv`)

| operator | retiring perf / VTune | bad spec | front-end | memory | core |
|---|---|---|---|---|---|
| whole inference | 43.1 / 43.2 | 4.3 / 0.0 | 10.1 / 10.6 | 9.7 / 12.4 | 32.9 / 37.1 |
| conv 1x1 (MKL) | 47.4 / 45.3 | 0.3 / 2.5 | 2.4 / 1.6 | 9.4 / 6.6 | 40.6 / 44.0 |
| max-pool | 31.4 / 31.4 | 36.8 / 39.7 | 27.5 / 24.7 | 0.2 / 0.0 | 4.9 / 4.2 |
| batchnorm | 33.3 / 38.1 | 2.4 / 2.4 | 12.5 / 4.8 | 24.3 / 23.8 | 27.5 / 31.0 |
| add | 14.2 / 15.2 | 0.4 / 12.9 | 5.0 / 0.5 | 45.1 / 33.3 | 35.2 / 38.1 |
| oneDNN convs (perf: 16 3x3; VTune: 20 incl. 7x7, strided 1x1) | 46.8 / 51.6 | 0.6 / 0.0 | 13.9 / 12.7 | 7.0 / 4.2 | 31.7 / 42.9 (VTune sum 111%) |

Two tools, two methods: the whole inference, MKL convs, max-pool and BN
agree within ~5 points; add and the oneDNN convs differ by up to ~12 points
(multiplexing, and different operator sets for the oneDNN row).

### 11.2 What VTune adds (one core, OBSERVED unless labelled)

| finding | numbers | where |
|---|---|---|
| **The L2's request queue to the rest of the chip is also full**, not only the L1 fill buffers: one core's miss-handling hardware at both L1 and L2 is the limit for streaming ops | super-queue full: add 48%, BN 22% of clockticks; fill buffers full: add 81%, BN 14% (perf's exact counter: add 70%, BN 10%) | `uarch_1t_by_task.csv` |
| **oneDNN conv kernels are partly front-end-bound because of code size** | only 44% of their uops come from the decoded-uop cache (DSB), vs 90% for MKL's kernels (VTune, indicative). The exact perf measurement agrees on the effect: front-end bound 13.9% for 3x3 convs vs 2.4% for 1x1. INFERRED: the JIT kernels are heavily unrolled (2,972 static instructions in the 3x3 kernel, `INS`) | `uarch_1t_by_task.csv` |
| **Port 0 (an FMA unit) is the busiest port in the convs** | port 0 busy 87% (oneDNN) / 78% (MKL) of cycles; 3+ ports busy in 71% / 53% of cycles; vector capacity used 100% | `uarch_1t_by_task.csv` |
| **Element-wise code uses half the vector width** | vector capacity usage BN 47%, add 50% (AVX2 on 512-bit units) vs convs 100% | `uarch_1t_by_task.csv` |
| **Max-pool's slots go to mispredicted branches** | branch mispredict 41% of slots; port 6 (branch unit) busy 50% | `uarch_1t_by_task.csv` |
| **Average load latency per operator** (memory-access, sampled) | convs 6.3-6.6 cycles (L1), max-pool 4.6, BN 9.0, ReLU 41.6, **add 69.7** (L3 level), **fc 190** (DRAM level); whole inference 7.8. PEBS load-latency samples, unaffected by multiplexing; ReLU and fc have few samples (0.1 and 0.04 s of CPU) | `memory_by_operator_1t.csv` |
| **For oneDNN convs, weights come from DRAM inside the re-layout step** | sampled LLC misses per inference: re-layout 102 K, MKL 1x1 convs 85 K, oneDNN conv kernels 8.5 K, fc 17 K, of 221 K. INFERRED: oneDNN reads the 9.4 MB weight tensors from DRAM while converting them, then the kernel reads the converted copy from cache (demand-load counts; they undercount streaming traffic) | `memory_by_operator_1t.csv` |
| DRAM bandwidth over the run | average 0.79 GB/s, observed maximum 17.3 GB/s (96% of one core's 18 GB/s, in short bursts), 0% of time at high utilization of the 238 GB/s platform maximum VTune measured | `memory_1t_summary.txt` |

### 11.3 28 threads, one image (OBSERVED, `VT/processed/tma_by_category_28t.csv`)

ITT tasks exist only on the main thread, so all 28 threads' cycles are
grouped by function. **Caveat:** at 28 threads the per-operator ITT labels
cost a lot: VTune's collector library took 10.7% of all clockticks and the
median inference rose from 15.4 to 21.9 ms (one core: 98.8 -> 103.7 ms). The
category shares below exclude the collector, but the slower main thread
lengthens the other threads' waits, so the OpenMP share (79%) overstates the
unperturbed value (61%, section 7).

| function category | share of clockticks (excl. collector) | memory-bound | contested accesses (HitM) | data sharing | slow pause |
|---|---|---|---|---|---|
| OpenMP runtime (`libgomp`) | 78.8% | 19% | 2% | 0% | **70%** |
| oneDNN conv kernels (JIT) | 13.1% | **28%** (4% on one core) | **44%** | **42%** | 0% |
| ATen element-wise, dispatch, copies | 1.8% | 40% | 43% | 22% | 0% |
| batchnorm | 1.2% | 97% | 99% | 6% | 0% |
| max-pool | 1.2% | 1% | 0% | 0% | 0% |
| oneDNN re-layout | 0.9% | 47% | 0% | 14% | 0% |
| MKL GEMM | 0.1% | | | | |

* **The waiting threads spin:** 70% of the OpenMP runtime's clockticks are
  "slow pause" (PAUSE instructions in spin-wait loops), confirming that the
  61% OpenMP share in section 7 is spinning, not useful work.
* **The cross-core transfers of section 7 happen inside the conv kernels:**
  at 28 threads 44% of the oneDNN conv kernels' clockticks are attributed to
  contested accesses (loads of lines another core modified), and their
  memory-bound share rises from 4% to 28%. This locates the HitM traffic
  measured in `MCS/xcore/`: the kernels read activations that other cores
  wrote in the previous operator.
* **The backend switch, confirmed:** MKL GEMM is 0.1% of clockticks at 28
  threads (one core: 21.6%); all convs run oneDNN.
* Not collected: memory-access at 28 threads and both analyses for 28
  copies. The 28-thread uarch result alone was 6.9 GB, and the shared disk
  reached 95%, so the queue was stopped; re-running them needs a shorter run
  or `-knob sampling-interval=20`.

---

## 12. Measurement validity

* **Counters validated on known-answer kernels**
  (`results/2026-10-06_counter_validation/processed/COUNTER_VALIDATION.md`):
  a DRAM pointer chase retires 1.0000 `mem_load_retired.l3_miss` and 0.9999
  `ocr.demand_data_rd.dram` per load; L1/L2/L3 chases hit their level
  1.011 / 1.001 / 0.969 per load. Memory-controller counts are 1.12x (they
  include prefetch and other tenants).
* **No multiplexing** in any perf pass (every group checked to count 100% of
  the time); VTune's driverless runs do multiplex (section 11).
* **Top-down** from general-purpose TMA events; level-1 fractions sum to
  1.000 +- 0.005 over 175 operators.
* **Quiet gate:** every run waits for other users < 1 core and low DRAM
  traffic, and is redone if contended (contended runs kept as noise examples
  with `_CONTENDED` suffix).
* **Repeatability:** sd 0.14% of the median at one core.
* **Known undercount:** `mem_load_retired.l3_miss` misses ~2x of streaming
  DRAM traffic (L2 prefetch arrives first); traffic is measured with
  `l2_lines_in`, `ocr.*` and memory-controller counters instead.
* Memory-controller traffic is socket-wide: background (0.15 GB/s read idle)
  is subtracted per operator.

---

## 13. Open questions and not done

* Why batch 64 costs 61% more per image on one core while L3-miss stalls
  rise only 2 points.
* Cost of one HitM transfer (counts measured, latency not).
* BF16 with AMX and INT8: would raise the compute peak several-fold and may
  move the convs toward memory-bound (hypothesis, not measured).
* SMT: supported but switched off in Linux; enabling needs root.
* PyTorch source build (priority 19): not started.
* VTune deep TMA levels are multiplexed estimates; its exact multi-run mode
  needs the account in the `vtune` group (`sudo usermod -aG vtune $USER`).

---

## 14. Reproducing

| result | command |
|---|---|
| microbenchmarks | `scripts/run_microbench.sh` |
| per-operator counters | `scripts/run_resnet_baseline.sh` |
| instruction profile, perf mem | `scripts/run_instruction_profile.sh` |
| backend path | `scripts/run_backend_probe.sh` |
| ISA probe | `scripts/run_isa_probe.sh` |
| per-calculation cost | `scripts/run_per_calc.sh` |
| optimizations | `scripts/run_optimizations.sh` |
| multi-core study | `taskset -c 27 .venv/bin/python scripts/mc_study.py --out DIR`, `analysis/analyze_mc_study.py DIR` |
| inter-op re-run | `scripts/run_interop_rerun.sh DIR` |
| cross-core traffic | `experiments/xcore_traffic.py --out DIR --configs ...` |
| VTune | `scripts/run_vtune.sh`, `analysis/analyze_vtune.py DIR` |

Full question-by-question write-up: `docs/RESULTS.md`; run history:
`docs/RESEARCH_LOG.md`.
