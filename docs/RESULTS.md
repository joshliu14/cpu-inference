# Results: ResNet-50 inference on one CPU core

Batch 1, 3x224x224, FP32, inference, one thread pinned to one core of an
Intel Xeon Gold 5512U at a fixed 2.1 GHz. PyTorch 2.14.1 (oneDNN 3.12, MKL
2024.2), eager mode unless a section says otherwise.

Every claim carries a label and a source:

* **OBSERVED**: measured directly in this project (file path given).
* **CALCULATED**: arithmetic on measurements or on tensor shapes.
* **INFERRED**: the most likely explanation that fits several observations;
  not measured directly.
* **UNKNOWN / UNAVAILABLE**: not measured, or not measurable here.

Paths are relative to the repository root. `BASE` =
`results/2026-10-06_resnet_baseline`, `MB` = `results/2026-10-05_microbench`,
`INS` = `results/2026-10-06_instruction_profile`, `BK` =
`results/2026-10-06_backend_003851`, `OPT` = the optimization result
directory (section 21), `DSP` = the dispatch-overhead directory (section 22).

---

## The short version

1. **One inference takes 98.6 ms** (median of 300; stddev 0.14 ms). That is
   **62% of the core's FMA peak** over the whole network: the 8.22 GFLOP
   would take 61.3 ms at the measured 63.9 FLOP/cycle. OBSERVED / CALCULATED,
   `BASE/processed/e2e_summary_explicit.json`, `BASE/processed/REPORT.md`.
2. **Convolutions are 80% of the time and run well**: 49 FLOP/cycle (77% of
   peak), 100% 512-bit FMA, >95% of loads hit L1. They are limited by FMA
   throughput, not by memory. OBSERVED, `BASE/processed/layer_table.csv`.
3. **The other 20% is where the waste is.** A single max-pool takes **10.2 ms
   (10.3%) for 0.03% of the FLOPs**. It runs a scalar, branchy loop with 214
   instructions and 1.9 branch mispredictions per output. BatchNorm, ReLU and
   add take another 8.8 ms, and run 256-bit (AVX2) code on an AVX-512
   machine. oneDNN re-lays-out convolution weights on every call (~8 ms).
   OBSERVED, `INS/processed/INSTRUCTIONS.md`, `BK/processed/BACKEND.md`.
4. **Memory is not the bottleneck for this model on one core.** Activations
   stay on chip (1.9 MiB of DRAM writes per inference). The 98 MiB of weights
   stream from DRAM every inference, at only ~1 GB/s on average, against
   18.5 GB/s available to one core. Only the final fc layer is
   DRAM-bandwidth-bound (0.5 ms). OBSERVED / INFERRED, section 15.
5. **Fixing the measured inefficiencies works, and the diagnosis predicts
   the gain.** On the same core, `torch.compile` (inductor, freezing) runs
   in **70.4 ms (1.43x)**, at 87% of FMA peak. It removes all weight
   reorders and fuses BN, ReLU and add into the convs. A channels-last
   max-pool alone saves 8.4 ms (instructions per output 214 -> 24). The
   ~28 ms of inefficiency identified in the baseline matches the 30 ms the
   compiler saves. OBSERVED, section 21, `results/2026-10-06_optimizations/`.
6. **Why more cores don't give N times more speed (section 24, measured
   with counters on 1-28 cores).** One inference on 28 threads is only 6.4x
   faster (23% efficient): 61% of busy cycles are threads spinning in the
   OpenMP runtime while serial work runs (layout conversions, framework
   code, small BN/ReLU/add ops). Conv math itself scales 17x. PyTorch also
   switches the 1x1 convs from MKL to oneDNN once more than one thread is
   used. Memory bandwidth is not the limit there (3.6% of the measured
   244 GB/s ceiling). 28 independent copies scale 22.9x (baseline) and 26.3x
   (inductor): their loss is on the memory side. Copies compete for the
   shared L3, so DRAM traffic per image grows 4.3x, DRAM reaches 56% of the
   ceiling, and L2-miss latency doubles (67 -> 132 ns). Operator-level
   inter-op parallelism is capped at 1.10x by ResNet's dependencies.

---

## 1. What CPU / hardware was used?

OBSERVED, `results/2026-10-05_system/SYSTEM.md`.

| | |
|---|---|
| CPU | Intel Xeon Gold 5512U (Emerald Rapids, Golden Cove-class cores), 28 cores, 1 socket, SMT off |
| Frequency | turbo off, governor `performance` -> fixed 2.1 GHz (turbostat busy MHz 2100; measured cycles/ref-cycles 2.095 GHz during inference) |
| Caches | L1D 48 KiB / core, L1I 32 KiB, L2 2 MiB / core, L3 52.5 MiB shared |
| Memory | 8 x DDR5-4800 (theoretical socket peak 307 GB/s, CALCULATED) |
| ISA | AVX-512 (F/BW/VL/VNNI/BF16/FP16), AMX (unused: FP32 model) |
| Software | Ubuntu 24.04, Linux 6.8, GCC 13.3, Python 3.12, PyTorch 2.14.1+cpu, perf 6.8 |
| Measurement CPU | core 6, one thread (`OMP_NUM_THREADS=1`, `torch.set_num_threads(1)`) |

The machine is shared. Every measurement after 2026-10-06 00:00 waits for
`scripts/wait_quiet.sh` (load <= 4, socket DRAM traffic <= 2 GB/s). A
contended run is kept as a noise example
(`results/2026-10-06_counter_validation_CONTENDED/`).

## 2. What is its measured baseline compute performance?

OBSERVED, `MB/processed/compute_summary.csv`, `MB/processed/machine_model.json`.

* FMA latency **4 cycles** at every width (scalar, SSE, AVX2, AVX-512).
* **2 FMA instructions per cycle** at every width, so peak FP32 throughput is
  **63.9 FLOP/cycle = 134 GFLOP/s** with 512-bit FMA, 31.9 with 256-bit and
  4 with scalar.
* No AVX-512 frequency drop: 2.095 GHz with the 512-bit FMA loop running.
* Compiler flags matter more than anything else for simple loops
  (`MB/processed/flags_summary.csv`): ReLU over an L1-resident array costs
  2.62 cycles/element at `-O2` (scalar) and 0.18 at `-O3 -march=native`.
  That is a 15x difference from the same C source.

## 3. What is its measured memory performance?

OBSERVED, `MB/processed/membw_summary.csv`, `MB/processed/memlat_summary.csv`.

Single-core read bandwidth (AVX-512 streaming loads):

| level | bytes/cycle | GB/s |
|---|---|---|
| L1 | 120 | 252 |
| L2 | 50 | 105 |
| L3 | 11 | 23 |
| DRAM | 8.8 | 18.5 |

One core reaches only 6% of the socket's theoretical 307 GB/s (CALCULATED).
INFERRED: single-core bandwidth beyond L2 is limited by how many misses one
core can have in flight, not by the DRAM channels. L3 is barely faster than
DRAM for one core.

## 4. What is the cost of each memory level?

OBSERVED, dependent-load pointer chase with random order, 2 MiB pages,
`MB/processed/memlat_summary.csv`. Validated with counters: each step of the
DRAM chase retires exactly 1.0000 `mem_load_retired.l3_miss`.
`results/2026-10-06_counter_validation/processed/COUNTER_VALIDATION.md`.

| level | latency (cycles) | ns |
|---|---|---|
| L1 | 5 | 2.4 |
| L2 | 16 | 7.7 |
| L3 | 63-68 | 30-32 |
| DRAM | 208-209 | 99 |

With 4 KiB pages the DRAM latency rises to 259 cycles at 1 GiB. The extra
~50 cycles is page-walk cost (OBSERVED difference; INFERRED cause).

## 5. What is the cost of ResNet inference?

OBSERVED, `BASE/processed/REPORT.md` (Level 0), 300 timed iterations after 30
warm-up iterations.

| run | median ms | stddev | p5 / p95 | IPC |
|---|---|---|---|---|
| explicit model (canonical) | **98.57** | 0.137 | 98.44 / 98.80 | 2.30 |
| torchvision.models.resnet50 | 98.55 | 0.174 | 98.38 / 98.86 | 2.30 |
| ImageNet weights | 98.32 | 0.131 | 98.20 / 98.58 | 2.31 |
| counters off | 98.50 | 0.242 | 98.36 / 99.17 | n/a |

* The explicit model (every op a hookable module) matches torchvision to
  0.02 ms, and its output matches bit for bit (max abs diff 0.0).
* Weights' values do not matter (random vs ImageNet: 0.25 ms).
* The counters cost nothing measurable (0.07 ms).
* 206.5 M cycles and 475.2 M instructions per inference (instruction count
  varies by 0.005%); 0 page faults in steady state; first inference 126.5 ms.
* CALCULATED: 8.22 GFLOP -> 83.4 GFLOP/s achieved; **62% of the 134 GFLOP/s
  peak**. Compute floor 61.3 ms.

## 6. Which layers dominate runtime?

OBSERVED, in-model forward hooks, `BASE/processed/REPORT.md` (Level 1),
`BASE/plots/02_runtime_share.png`.

| operator type | count | ms | % time | % FLOPs | FLOP/cycle | IPC |
|---|---|---|---|---|---|---|
| conv 1x1 | 36 | 41.05 | 41.6 | 51.6 | 49.3 | 2.85 |
| conv 3x3 | 16 | 35.89 | 36.4 | 45.0 | 49.1 | 1.92 |
| **max-pool** | **1** | **10.22** | **10.3** | **0.03** | **0.075** | 1.99 |
| batchnorm | 53 | 4.93 | 5.0 | 0.3 | 2.1 | 2.05 |
| conv 7x7 | 1 | 2.17 | 2.2 | 2.9 | 51.7 | 1.90 |
| add (residual) | 16 | 2.05 | 2.1 | 0.1 | 1.3 | 0.92 |
| relu | 49 | 1.82 | 1.8 | 0.1 | 2.4 | 1.41 |
| fc + avgpool + flatten | 3 | 0.60 | 0.6 | 0.05 | 3.3 | 0.47 |

The single most expensive operator is the max-pool (10.2 ms). The next is a
layer4 3x3 conv (3.4 ms). By stage, layer3 takes 29%, layer4 22%, layer2
20%, layer1 15%, and the stem (conv1 + bn + relu + max-pool) 13%. The stem's
time is mostly the max-pool.

## 7. Which layers are compute-intensive?

CALCULATED from shapes (`BASE/processed/manifest.csv`), checked against
measured FP instruction counts (`fp_arith_inst_retired.*`): the measured
total is 8.196 GFLOP vs the 8.217 GFLOP calculated. The difference is
explained below.

* Each 3x3 conv does ~231 MFLOP, conv1 (7x7) 236 MFLOP, and 1x1 convs
  103-206 MFLOP. Convolutions are 99.4% of all FLOPs.
* Arithmetic intensity (FLOP per compulsory byte): 3x3 convs 23-166, 1x1
  convs 16-71, elementwise ops 0.08-0.25, max-pool 0.4
  (`BASE/plots/09_layer_arithmetic_intensity.png`). Every conv is above the
  DRAM ridge point (7.3 FLOP/byte); every non-conv op is far below it.
* OBSERVED + CALCULATED: oneDNN's padded 3x3 convs on 7x7 and 14x14 maps
  execute 0.82x and 0.91x of the textbook FLOPs. The ratios equal (19/21)^2
  and (40/42)^2, which means oneDNN skips multiply-adds with the zero padding.

## 8. Which layers move lots of data?

OBSERVED, `l2_lines_in.all` x 64 B (fills into L2, including prefetches) and
`ocr.reads_to_core.dram` (core reads served by DRAM), in-model,
`BASE/processed/layer_table.csv`.

Per inference: 1.79 GB filled into L1D, 543 MB into L2, 94 MB read from DRAM.
The compulsory traffic (each operator's inputs + weights + outputs, each moved
once) is 426 MB (CALCULATED).

| operator | ms | MB into L2 | MB from DRAM | note |
|---|---|---|---|---|
| layer4.0.downsample.0 (1x1, 1024->2048) | 2.89 | 31.6 | 8.1 | weights 8.4 MB |
| layer4.0.conv2 (3x3, 512) | 3.42 | 30.2 | 9.4 | weights 9.44 MB |
| layer4.1.conv2 / layer4.2.conv2 | 3.16 | 29.7 | 9.3 | weights 9.44 MB |
| fc (2048->1000) | 0.50 | 8.5 | 8.1 | weights 8.2 MB |

Each layer's DRAM reads equal the size of its weight tensor. INFERRED:
weights (97.7 MiB in total) do not fit in the 52.5 MiB L3, so they are
streamed from DRAM on every inference. Activations (largest: 3.2 MB) stay in
L2/L3. DRAM writes are only ~1.9 MiB per inference.

By type, the elementwise ops move the most data **per unit of work**:
batchnorm fills 7.6 bytes/cycle into L2 and add 9.5 bytes/cycle, against
2.3 for convolutions.

## 9. Which layers have the most cache misses?

OBSERVED, `BASE/plots/08_layer_cache_misses.png`, `BASE/processed/REPORT.md`.

* Most L3 misses (`LONGEST_LAT_CACHE.MISS`): the layer4 3x3 convs
  (~150 K each), layer4.0.downsample (130 K) and fc (128 K). These are the
  layers with the largest weight tensors. 128 K misses x 64 B = 8.2 MB, which
  is fc's weight size (CALCULATED).
* Lowest L1 hit rate of loads: fc 33%, layer4.0.downsample 86%, the
  strided downsample 1x1 convs 85-89%; all other convs are 96-99%. Over the
  whole inference, 95.8% of retired loads hit L1 (97.1% within convs).
* Caveat: `mem_load_retired.l3_miss` undercounts DRAM traffic of streaming
  access about 2x, because L2 prefetches bring the lines in before the demand
  load. Traffic is therefore measured with `l2_lines_in` and offcore/IMC
  counters (`docs/PERF_GUIDE.md`).

## 10. Which layers have the lowest IPC?

OBSERVED, `BASE/plots/06_layer_ipc.png`.

| operator | IPC | why (evidence in section 13/15) |
|---|---|---|
| fc | 0.31 | 69% of cycles stalled on an L3 miss: DRAM-bandwidth-bound GEMV |
| residual adds | 0.85-0.87 (layer1/2), 1.1-1.3 (layer3/4) | 54% of cycles stalled on L1D misses; streaming 3 tensors |
| relu (layer1) | 1.13 | 29% of cycles stalled on L1D misses |
| conv3x3 | 1.7-2.0 | high IPC isn't the goal here: 1.4 FMA (16-wide) per cycle |
| conv1x1 (MKL) | 2.8-3.4 | |

Low IPC is not the same as slow. The convs have IPC ~2 but deliver 49
FLOP/cycle, because each instruction does 32 FLOP. The max-pool has IPC 2.0
but delivers 0.075 FLOP/cycle, because it executes 214 instructions per
output.

## 11. Which instructions dominate?

OBSERVED, `perf record` (cycles:P, oneDNN JIT code resolved with jitdump)
and `perf annotate` of each operator's hottest symbol, `INS/processed/INSTRUCTIONS.md`,
`INS/plots/instruction_mix_by_operator.png`.

* Whole inference (`INS/raw/full_symbols.txt`, `full_dso.txt`): MKL SGEMM
  kernels 29.7% of samples (+2.4% MKL packing copies), oneDNN JIT conv kernels
  34.1%, `cpu_max_pool<float,false>` 9.9%, oneDNN JIT reorder kernels 6.5%,
  `batch_norm_cpu_kernel` 3.7%, the AVX2 elementwise loops 3.2%; the
  `python3.12` binary 4.0%, libc 1.1% (allocation), `libtorch_python` 0.3%.
* Convolutions: 94-98% of samples land on `vfmadd231ps zmm` (conv1, 3x3)
  or FMA + broadcast + load (1x1 SGEMM). 2920 of 2972 static instructions in
  the 3x3 kernel are zmm.
* Max-pool: no FP arithmetic at all. The loop is `vmovss` (scalar load),
  `vcomiss`, a data-dependent `ja` (12.3% of samples), `vcvtss2sd` +
  `vucomisd` (an `isnan` check done in double precision), and loop invariants
  reloaded from the stack. That is 214 instructions, 39 branches and
  1.9 mispredictions per output.
* BatchNorm: the hot loop does one `vfmadd132ps ymm` per 8 elements. It also
  reloads its data pointers through two memory indirections on every
  iteration (`mov rcx,[rcx]` x2: 46% of samples). INFERRED: the compiler
  cannot hoist the pointers because they are captured by reference in a
  lambda and may alias the output.
* fc: four `vfmadd231ps zmm` with memory operands take 90% of samples:
  a GEMV waiting on its weight stream.

## 12. Is AVX2 / AVX-512 being used?

OBSERVED: `fp_arith_inst_retired.*` counters per operator
(`BASE/processed/layer_table.csv`) and register widths of the sampled hot
instructions (`INS/processed/instruction_mix.json`).

| code | width | evidence |
|---|---|---|
| all convolutions (oneDNN JIT and MKL SGEMM), fc (MKL SGEMV) | **512-bit (zmm)** | 99.999% of conv FP instructions are 512-bit packed |
| batchnorm, relu, add, avgpool (ATen native) | **256-bit (ymm)** | symbols `at::native::AVX2::VectorizedLoop2d...`; hot loops use ymm |
| max-pool, NCHW path (ATen native) | **scalar** | `vmovss`/`vcomiss`; 0 FP_ARITH instructions |

Why ATen's elementwise kernels are AVX2 on an AVX-512 machine
(`results/2026-10-06_isa_probe/`, `scripts/run_isa_probe.sh`):

* OBSERVED (counters, each op run on ResNet-sized tensors under each
  `ATEN_CPU_CAPABILITY` setting, `raw/isa_counters_*.json`):

  | op | capability unset (= AVX512) | forced `avx512` | forced `avx2` | forced `default` |
  |---|---|---|---|---|
  | relu_, add_, batchnorm, avgpool | 256-bit | **256-bit** | 256-bit | scalar / SSE |
  | max-pool (NCHW) | no FP arithmetic | same | same | same |
  | exp (control) | 512-bit | 512-bit | 512-bit | 512-bit |

  e.g. relu_ on 802,816 elements retires exactly 100,352 256-bit FP ops
  (= 802,816 / 8) and zero 512-bit ops, even when AVX-512 is forced.
* OBSERVED (symbols, `raw/isa_symbols.json`): `libtorch_cpu.so` contains
  AVX2 and DEFAULT instantiations of `add_kernel` (28 / 37 symbols),
  `clamp_min_scalar` (ReLU, 9 / 10), `mul_kernel` and `vectorized_inner_sum`
  (avgpool), and **zero AVX512 instantiations** of any of them. Kernels such as
  `exp_kernel`, `tanh_kernel` and `copy_kernel` do have AVX512 builds. Of the
  dispatched `*_kernel` functions, 36 have an AVX512 build and 48 have AVX2
  only.
* INFERRED: this PyTorch build compiles AVX512 versions only for kernels
  that opt in. Kernels without an AVX512 build fall back to their AVX2 build
  when the capability is AVX512, so no runtime setting can make ResNet's
  ReLU/add/BN loops 512-bit.

## 13. Which execution resources appear limiting?

OBSERVED, `uops_dispatched.port_*` per operator, `BASE/raw/inmodel_ports.0.csv`
(summed by type here), and top-down level 1-2 (`BASE/processed/topdown_by_operation.csv`).

| type | port 0 | port 5 | port 1 | load ports | top-down (retiring / core / memory / frontend / bad spec) |
|---|---|---|---|---|---|
| conv1x1 | 0.83 | 0.88 | 0.02 | 1.01 | 0.47 / 0.41 / 0.09 / 0.02 / 0.00 |
| conv3x3 | 0.72 | 0.83 | 0.10 | 1.74 | 0.47 / 0.32 / 0.07 / 0.14 / 0.01 |
| batchnorm | 0.21 | 0.29 | 0.20 | 1.12 | 0.33 / 0.28 / 0.24 / 0.13 / 0.02 |
| add | 0.16 | 0.08 | 0.16 | 0.50 | 0.14 / 0.35 / **0.45** / 0.05 / 0.00 |
| max-pool | 0.31 | 0.40 | 0.24 | 0.95 | 0.31 / 0.05 / 0.00 / **0.28** / **0.37** |

(Units: uops dispatched per cycle. Ports 0 and 5 hold the two 512-bit FMA
units; port 1's vector unit is fused into port 0 while 512-bit uops run.)

* Convolutions: **the two FMA ports** (0 and 5) are 72-88% busy and
  "core bound" is the largest non-retiring category. They are FMA-throughput
  bound at 71-81% of peak (INFERRED from port use + FMA rate + few stalls).
* Max-pool: branch misprediction (37% bad speculation) and the frontend
  (28%), with ports mostly idle.
* add / batchnorm / relu: the memory subsystem (L1D misses for tensors that
  do not fit in L2).

## 14. Is the workload compute-bound?

**Mostly yes, and the compute part runs well.** OBSERVED / CALCULATED,
`BASE/processed/REPORT.md` (roofline classification), `BASE/plots/11_roofline.png`.

* 80% of the time (53 operators, all convolutions) runs at >= 50% of the FMA
  peak. Their average is 49 FLOP/cycle = 77% of peak.
* The remaining 20% is neither compute- nor bandwidth-bound: max-pool (10%)
  and the BN/ReLU/add ops (9%).
* Whole network: 62% of peak. If every non-conv op took zero time, the
  convs alone would take 79.1 ms (CALCULATED from the table above). Getting
  below that requires faster convolutions, not removing overhead.

## 15. Is it memory-bandwidth-bound?

**No, except for fc.** OBSERVED, `BASE/processed/layer_table.csv`.

* fc: 8.1 MB of weights read from DRAM in 0.50 ms = 7.9 B/cycle, which is
  90% of the measured single-core DRAM bandwidth (8.8 B/cycle). IPC 0.31; 69%
  of cycles stalled with an L3 miss outstanding. DRAM-bandwidth-bound.
* layer1 elementwise ops (3.2 MB tensors, larger than the 2 MiB L2) refill
  L2 at ~10 B/cycle, close to the measured L3 bandwidth (11 B/cycle). add has
  top-down memory-bound 0.45 and is L3-bandwidth-bound (INFERRED from these
  two observations).
* layer4 convs read their 9.4 MB of weights from DRAM in ~3.2 ms. That is
  ~2.9 GB/s, 16% of the single-core DRAM bandwidth (CALCULATED), and
  L3-miss stalls are only ~5.5% of their cycles. Not bandwidth-bound.
* Average DRAM read rate over an inference: ~94 MB / 98.6 ms ≈ 1 GB/s
  (CALCULATED).

## 16. Is memory latency important?

**Only in a few places.** OBSERVED.

* Convolutions: cycles stalled with an L3 miss outstanding are 2.4-2.8% of
  their cycles. With an L1D miss outstanding: 6-7%. Latency is hidden by
  blocking and prefetching (`BASE/processed/layer_table.csv`,
  `stalls_l3_miss`, `stalls_l1d_miss`).
* fc: 69% of cycles stalled on L3 misses. Its limit is bandwidth (see 15),
  reached only through many misses in flight.
* Elementwise ops on L2-overflowing tensors: add 54%, relu 29%, BN 22% of
  cycles stalled on L1D misses.
* `perf mem` (PEBS load-latency, `INS/processed/INSTRUCTIONS.md`): among
  sampled slow loads, 30% hit a line already in flight (LFB, 98 cycles mean)
  and 2.9% came from DRAM (268 cycles mean). The DRAM loads account for 11%
  of the sampled load latency. INFERRED: most slow loads are prefetches
  that had not yet arrived, not demand misses.

## 17. What evidence supports each conclusion?

Every answer above cites its file. The supporting method checks:

* **Counter correctness**: known-answer kernels (pointer chases at each
  level, streams, a 512-bit FMA loop). Every counter used is within a few %
  of the known count
  (`results/2026-10-06_counter_validation/processed/COUNTER_VALIDATION.md`).
* **No multiplexing**: every counter pass is a schedulable group set, checked
  by `plan_groups()` (`cpuinf/perfcounters.py`). Floors are subtracted
  (~9 K cycles per start/stop).
* **Top-down validity**: the per-operator top-down comes from
  general-purpose TMA events, whose level-1 fractions sum to 1.000 ± 0.005
  over all 175 operators. The fixed-counter `topdown-*` metrics are invalid
  for short regions (see `docs/PERF_GUIDE.md`).
* **Model correctness**: explicit model == torchvision (max abs diff 0.0).
* **Hook overhead**: sum of per-operator times 98.73 ms vs 98.57 ms
  end-to-end; 1.4% unattributed.
* **Noise control**: quiet gate; repeated measurements; stddev 0.14% of the
  median.

## 18. What measurements are unavailable?

* **Per-operator DRAM traffic from the memory controller** is socket-wide
  (uncore IMC): it includes other tenants. Background is subtracted, and
  core-side `ocr.*.dram` counts are used as a cross-check.
* **TMA level-3 metrics** (e.g. ports-utilization breakdowns, DRAM vs L3
  bound split): perf 6.8 has no metric formulas for this CPU model. Levels
  1-2 were built from raw events.
* **Kernel symbols** (`kptr_restrict=1`): irrelevant here, since all hot
  code is user-space.
* **AMX**: not exercised (FP32 model); `amx_busy` is 0.
* **Microcode-level port binding** of the JIT code: we infer from port
  counters, not from a per-instruction port trace.
* **The dispatch rule behind the AVX2 fallback** (section 12): the missing
  AVX512 builds are observed in the binary; the registration rule that causes
  them is inferred, not read from the PyTorch source.

## 19. What are the major inefficiencies?

Ranked by measured time. Each comes from the evidence above.

| # | inefficiency | cost per inference | evidence |
|---|---|---|---|
| 1 | NCHW max-pool is a scalar, branchy loop (and computes int64 argmax indices that inference discards) | 10.2 ms (10.3%) | 214 instr / 1.9 mispredicts per output; bad spec 0.37 |
| 2 | oneDNN reorders conv weights (and NCHW<->blocked activations) on every call | ~8.8 ms (~9%) | `BK/processed/BACKEND.md`: 59 reorders / inference |
| 3 | BatchNorm runs as 53 separate passes over memory (foldable into the convs at inference) | 4.9 ms (5%) | 0.3% of FLOPs, 22% L1D-miss stalls, pointer reloads |
| 4 | ReLU and add are separate memory passes at AVX2 width | 3.9 ms (4%) | top-down memory 0.22-0.45 |
| 5 | layer4 convs run at 36 FLOP/cycle vs 49 elsewhere | ~4 ms vs layer2/3 efficiency | small spatial size (7x7) + weight reorders each call (INFERRED) |
| 6 | Python / module-call glue between operators | ~1.4 ms | sum-of-ops vs forward() |

## 20. What optimizations are worth investigating next?

Measured first (section 21). Ranked by what the measurements support:

| option | measured / expected effect | evidence | cost |
|---|---|---|---|
| `torch.compile` with inductor freezing | **measured 1.43x** (100.5 -> 70.4 ms); 87% of FMA peak | 21.5 | one line; ~10-30 s compile; output diff 9e-5 |
| channels-last model + folded BN (eager) | **measured 1.16x** (86.4 ms) | 21.3, 21.2 | two lines, no compiler |
| channels-last max-pool only | **measured 1.09x** (8.4 ms), bit-identical | 21.1 | a few lines |
| Prepacked (cached) conv weights in eager mode | ~8 ms expected: removes the 56 MB of per-call weight reorders | 21.3, 21.4 | needs oneDNN weight caching (e.g. inductor, IPEX); not available through plain eager PyTorch here |
| Remaining 9 ms to the FMA floor (inductor 70.4 vs 61.3 ms) | at most 13% | 21.5 | better conv blocking for small layer4 maps (7x7), which run at 36 FLOP/cycle in eager |
| Lower precision: BF16 with AMX, or INT8 with VNNI/AMX (the CPU supports both) | not measured; changes numerics | `results/2026-10-05_system/` (amx_bf16, amx_int8, avx512_vnni flags) | accuracy validation needed; out of scope of the FP32 brief |
| Multi-core: N independent copies (throughput) | **measured 352 inferences/s** with 26 inductor copies (24.7x) | 23.2 | 74 ms latency per image |
| Multi-core: threads (latency) | **measured 7.6 ms** per image (inductor, 16-26 cores) | 23.1 | scaling stops at ~16 cores |

Not worth pursuing on this model: reducing Python/dispatch overhead (1.3% of
time, section 22), and DRAM-bandwidth tuning on one core. Only fc (0.5 ms) is
bandwidth-bound; weights stream at ~1 GB/s of an available 18.5 GB/s.

---

## 21. Optimization experiments (measured)

`OPT` = `results/2026-10-06_optimizations/` (quiet machine: other users'
CPU 3% for the whole run, `results/machine_load_2026-10-06.log`).
`experiments/opt_variants.py` builds every variant from the same weights
(`cpuinf/variants.py`), checks its output against the baseline, warms up,
then times all variants in rotating blocks of 10 until each has 100 timed
inferences. Per-operator time comes from forward hooks (eager variants only).
`experiments/opt_mechanisms.py` re-measures the targeted mechanism:
max-pool counters, oneDNN primitive census, ATen call census.
Files: `OPT/processed/OPTIMIZATIONS.md`, `opt_comparison.csv`,
`opt_breakdown_ms.csv`, `onednn_reorder_split.csv`, `maxpool_mechanism.csv`,
`OPT/plots/opt_latency.png`, `opt_breakdown.png`.

**Headline (OBSERVED, one core):**

| variant | median ms | speedup | max abs diff vs baseline |
|---|---|---|---|
| baseline (unmodified) | 100.50 | 1.00x | 0 |
| fold_bn | 98.54 | 1.02x | 2.3e-5 |
| mkldnn_layout | 93.85 | 1.07x | 4.0e-5 |
| maxpool_chlast | 92.09 | 1.09x | 0 (bit-identical) |
| fold_bn+chlast_pool | 90.00 | 1.12x | 2.3e-5 |
| channels_last | 89.73 | 1.12x | 3.1e-5 |
| fold_bn+channels_last | 86.37 | 1.16x | 3.1e-5 |
| jit_freeze (TorchScript freeze + optimize_for_inference) | 84.19 | 1.19x | 8.4e-5 |
| **inductor (torch.compile, freezing on)** | **70.41** | **1.43x** | 9.2e-5 |

The in-run baseline is 100.5 ms, vs 98.57 ms in the canonical run. The
instruction count is identical (475.0 M); the extra 4 M cycles come from
keeping nine models resident and switching between them every 10
inferences. With only the baseline loaded, the same harness gives 98.8 ms
(`experiments/multicore.py`, 1 thread). All speedups above compare
variants measured under the same interleaved conditions.

### 21.1 Max-pool on a channels-last copy (`maxpool_chlast`)

* **Hypothesis (from sections 11 and 19):** the 10.2 ms comes from the scalar
  NCHW kernel, not from the work itself. ATen's channels-last kernel
  vectorizes across channels, so pooling a channels-last copy should cost
  < 1 ms plus the two layout conversions.
* **Change:** convert the input to channels-last, pool, convert back. No other
  operator changes.
* **Result (OBSERVED):** 92.09 ms (**-8.4 ms**). Max-pool operator 10.19 ->
  1.81 ms. Output bit-identical.
* **Mechanism (OBSERVED, `OPT/processed/maxpool_mechanism.csv`, per pooled
  output):**

  | path | cycles | instructions | branch misses | loads | IPC |
  |---|---|---|---|---|---|
  | NCHW (baseline) | 105.8 | 213.6 | 1.85 | 62.1 | 2.02 |
  | channels-last pool | 6.4 | 23.6 | 0 | 9.1 | 3.70 |
  | + NCHW -> channels-last copy | 8.4 | 28.7 | 0 | 4.0 | 3.42 |
  | + channels-last -> NCHW copy | 3.4 | 7.1 | 0 | 1.0 | 2.10 |
  | oneDNN pooling (blocked layout) | 5.0 | 9.5 | 0 | 2.9 | 1.91 |

  Instructions per output drop 9x, and mispredictions disappear. The two
  conversions now cost more than the pooling itself. Neither path executes
  FP-arithmetic instructions: the vectorized kernel implements max as
  compare + blend, which `fp_arith_inst_retired` does not count.
* **Verdict:** the measured bottleneck (instruction count + branch
  misprediction) was the cause. Fixing it recovers 8.4 of the 10.2 ms.

### 21.2 Fold BatchNorm into the convolutions (`fold_bn`)

* **Hypothesis:** in inference BN is an affine map. Folding it into the
  preceding conv's weights and bias removes 53 memory passes (~4.9 ms).
* **Result (OBSERVED):** 98.54 ms (**only -2.0 ms**). BN time 5.02 -> 0 ms,
  but the 1x1 convs got 2.8 ms slower (41.36 -> 44.17 ms).
* **Mechanism (OBSERVED, ATen census):** `aten::copy_` calls rise from 2 to
  35 per inference. The 33 unstrided 1x1 convs run
  `aten::_slow_conv2d_forward` (MKL path). Once they have a bias, that path
  first copies the bias into the whole output tensor, then runs the GEMM
  accumulating on top. That is a new full write pass per conv. The oneDNN
  convs (3x3, 7x7) apply the bias inside the kernel and got no slower.
* **Verdict:** BN's cost is removed, but the MKL conv path re-adds a memory
  pass for the bias. Folding pays off only where the conv backend fuses the
  bias.

### 21.3 Whole model channels-last (`channels_last`)

* **Hypothesis:** with NHWC activations, oneDNN uses them directly (no
  activation reorders, ~2 ms), and the max-pool takes the vectorized
  channels-last kernel (~9.5 ms).
* **Result (OBSERVED):** 89.73 ms (**-10.8 ms**, IPC 2.26 -> 2.66).
  Max-pool 10.19 -> 0.61 ms. Activation reorders 39 -> 0 (-2.0 ms). But
  weight reorders rose from 6.5 to 7.9 ms, and BN got 0.6 ms slower.
* **Verdict:** both hypotheses confirmed. The weight reorders remain
  (20 per inference, 56 MB re-laid-out).

### 21.4 oneDNN layout end-to-end (`mkldnn_layout`, `torch.utils.mkldnn.to_mkldnn`)

* **Hypothesis:** keeping tensors in oneDNN's blocked layout removes all
  reorders.
* **Result (OBSERVED):** 93.85 ms (-6.7 ms). Activation reorders go to 0 and
  max-pool runs oneDNN pooling (0.24 ms). But all 53 convs now run in
  oneDNN, including the 33 former MKL 1x1 convs, and **each still
  converts its weights on every call**: 53 reorders, 93.8 MB, 12.1 ms per
  inference. The residual add doubled (2.06 -> 4.11 ms).
* **Verdict:** wrong mechanism removed. Weights, not activations, are the
  expensive reorders.

### 21.5 TorchScript (`jit_freeze`) and torch.compile (`inductor`)

* **jit_freeze (OBSERVED):** 84.19 ms (1.19x). BN folded, ReLU and max-pool
  in oneDNN, but **53 weight reorders (93.8 MB, 11.8 ms) still run on every
  inference**. Freezing does not prepack the weights in this PyTorch build.
* **inductor (OBSERVED):** 70.41 ms (**1.43x**). The oneDNN census shows
  **zero reorders** (weights prepacked once at compile time). All 53 convs
  run in oneDNN (`mkldnn::_convolution_pointwise`), with BN folded into the
  weights. The verbose log shows `attr-post-ops:eltwise_relu` on 33 convs and
  `sum+eltwise_relu` (residual add + ReLU) on the 16 block-final convs; the 4
  downsample convs are plain. The conv kernels take 68.6 ms of 70.4 ms
  (profiler self time); everything else (max-pool, avgpool, fc, Python)
  takes ~1.8 ms. IPC 2.95, 147.5 M cycles.
* **Conv math itself did not get faster.** With NHWC activations, oneDNN
  picks its brgemm kernels (`brg_conv_fwd`, `brgconv_1x1`) instead of the
  direct JIT kernels (`jit:avx512_core`), for channels_last and inductor
  alike. On the same 20 convs these take 34.9 vs 35.1 ms. Inductor's 53 convs
  take 66.3 ms of oneDNN time, including their fused epilogues. The
  baseline's 68.3 ms of conv kernels (35.1 oneDNN + 33.2 MKL) excludes
  reorders, BN, ReLU and add. INFERRED: the whole gain comes from removing
  work around the convs.
* CALCULATED: 8.22 GFLOP / (70.41 ms x 2.1 GHz) = **55.6 FLOP/cycle = 87% of
  the measured FMA peak** for the whole network, vs 62% for the baseline.
  The remaining gap to the 61.3 ms compute floor is 9.1 ms.
* CALCULATED check of the inefficiency inventory (section 19): max-pool
  (~9.5 recoverable) + reorders (8.5) + BN (4.9) + ReLU/add (3.9) + fixed
  software costs (~1.3) ≈ 28 ms, vs the 30.1 ms that inductor saved. The
  baseline analysis accounts for almost all of the compiler's gain.

### 21.6 What this says about the baseline

Every optimization moved the counters the way the baseline diagnosis
predicted, and two produced surprises:

* folding BN can move the cost into a bias-copy pass (21.2);
* re-laying-out *weights* (not activations) is the expensive part of
  oneDNN's layout handling, and only a compiler that prepacks weights
  removes it (21.4, 21.5).


## 22. Python / dispatch overhead (measured)

`DSP` = `results/2026-10-06_dispatch_overhead/` (quiet machine;
`experiments/dispatch_overhead.py`). Each callable is timed over many
back-to-back calls at sizes from 1 element to 4 M elements, with cycles and
instructions per call (`DSP/raw/dispatch_overhead.csv`,
`DSP/plots/dispatch_overhead.png`).

OBSERVED, cost of the smallest call (almost all of it is fixed software cost,
`DSP/processed/dispatch_smallest_call.csv`):

| call | time | cycles | instructions |
|---|---|---|---|
| empty Python function | 38 ns | 80 | 511 |
| `nn.Identity()(x)`: nn.Module call machinery only | 1.0 µs | 2,110 | 9,600 |
| `torch.relu(x)`, 1 element: Python -> C++ binding -> dispatcher -> allocate -> kernel | 1.28 µs | 2,690 | 8,100 |
| `x.add_(y)`, in place (no allocation) | 1.04 µs | 2,170 | 6,900 |
| `torch.add(x, y)`, allocates the output | 1.44 µs | 3,020 | 9,000 |
| `nn.ReLU()(x)`, 1 element | 2.94 µs | 6,170 | 19,900 |
| `nn.BatchNorm2d(64)`, 64 elements | 9.7 µs | 20,200 | 65,500 |
| conv1x1 64->64 on a 1x1 map (MKL path) | 8.0 µs | 16,800 | 49,800 |
| conv3x3 64->64 on a 1x1 map (oneDNN path, incl. weight reorder) | 17.6 µs | 37,000 | 111,500 |

* The **Python language** itself is cheap (38 ns per call). The
  **nn.Module wrapper** costs ~1 µs per call, and the **PyTorch operator
  path** (binding, dispatcher, output allocation) another ~1-1.5 µs.
* BatchNorm's fixed cost (9.7 µs, 66 K instructions) is 3x ReLU's module
  call. OBSERVED: its ATen chain (`BK/processed/BACKEND.md`) passes through
  `_batch_norm_impl_index` and makes 6 `aten::empty`/`empty_like` calls.
  INFERRED: most of these are the save-mean/inv-std buffers that only
  training needs.
* The fixed cost stops mattering once a tensor has more than ~10^4
  elements. Every ResNet-50 activation tensor has 10^5 to 8x10^5 elements
  (shaded band in the plot).

CALCULATED, fixed cost per inference = calls per inference x smallest-call cost
(`DSP/processed/dispatch_per_inference_estimate.csv`): 33 MKL convs x 8.0 µs +
20 oneDNN convs x 17.6 µs + 53 BN x 9.7 µs + 49 ReLU x 2.9 µs + 35 other
module calls x ~1 µs ≈ **1.3 ms per inference = 1.3% of 98.6 ms**. The hook
measurement independently finds 1.4 ms of time between operators (section 17).
**At batch 1, ResNet-50 on this core is not framework-overhead-bound.** A
model with ~10x smaller layers would be.

Direct check (OBSERVED, `results/2026-10-06_followups/processed/python_overhead.json`,
interleaved blocks, 200 inferences each, quiet): the eager model takes
98.63 ms. A TorchScript trace of it executes the identical ATen operator
sequence with no Python frame or nn.Module call per operator, and takes
97.05 ms. **The Python layer costs 1.58 ms (1.6%) and 5.8 M instructions
(1.2%) per inference**, matching the 1.3 ms estimate above. Disabling
Python's garbage collector changes nothing (98.57 ms): no collections run
during steady-state inference. The 4.0% of samples in `python3.12` in the
instruction profile is inflated by the `-X perf` trampolines used to name
Python frames.

## 23. Multi-core (measured; separate from the single-core baseline)

`MC` = `results/2026-10-06_multicore/` (`scripts/run_multicore.sh`). The
unmodified baseline is always included, next to the fastest eager variant
(fold_bn+channels_last) and the fastest overall (inductor). Before and during
every configuration, the launcher samples other users' CPU from core 27 (not
used by any configuration); a configuration is re-run if other users exceed
one core. **36/36 configurations ran clean** (`MC/raw/contention_summary.csv`).
A first attempt overlapped another user's job and is kept as a noise example
(`results/2026-10-06_multicore_CONTENDED/NOTE.md`): there, contention
*inverted* thread scaling (8 threads slower than 2).

Two ways to use N cores (CPUs 1..N):

* **threads**: one inference at a time, split across N intra-op OpenMP
  threads (`OMP_PROC_BIND=close`). Measures the latency of one image.
* **instances**: N independent single-threaded copies, one per core, measured
  over the same 20 s window. Measures total throughput and interference.

### 23.1 Latency: one inference on N cores (OBSERVED, `MC/processed/thread_scaling.csv`, `MC/plots/thread_scaling.png`)

| cores | 1 | 2 | 4 | 8 | 16 | 26 |
|---|---|---|---|---|---|---|
| baseline (ms) | 98.9 | 56.4 | 32.0 | 20.5 | 15.6 | **15.3** |
| fold_bn+channels_last (ms) | 85.1 | 47.3 | 26.3 | 15.3 | 10.6 | **9.9** |
| inductor (ms) | 70.1 | 37.4 | 20.2 | 11.8 | 7.8 | **7.6** |
| baseline parallel efficiency | 100% | 88% | 77% | 60% | 40% | 25% |
| inductor parallel efficiency | 100% | 94% | 87% | 74% | 56% | 35% |

* All variants stop improving between 16 and 26 cores. The fastest single
  image is **7.6 ms (inductor, 26 cores) = 13x faster than the single-core
  baseline**.
* It is not memory bandwidth: socket DRAM reads stay at 90-140 MB per
  inference and peak at 16 GB/s, 5% of the theoretical 307 GB/s. The
  weights still stream from DRAM every inference, even with 26 cores' L2
  (52 MiB) plus L3 (52.5 MiB).
* Which operators stop scaling: see 23.3 (follow-up breakdown).

### 23.2 Throughput: N independent copies (OBSERVED, `MC/processed/instance_scaling.csv`, `MC/plots/throughput_scaling.png`, `MC/plots/instances_memory.png`)

| copies (= cores) | 1 | 2 | 4 | 8 | 16 | 26 |
|---|---|---|---|---|---|---|
| baseline: inferences/s | 10.2 | 20.1 | 39.6 | 77.2 | 148 | **221** |
| baseline: per-copy latency (ms) | 98.8 | 99.6 | 101.2 | 103.6 | 108.3 | 117.9 |
| baseline: DRAM read / write per inference (MB) | 137 / 11 | 174 / 29 | 233 / 70 | 301 / 114 | 371 / 150 | 408 / 171 |
| fold_bn+channels_last: inferences/s | 11.8 | 23.1 | 45.8 | 89.8 | 172 | **261** |
| inductor: inferences/s | 14.3 | 28.3 | 56.4 | 112 | 221 | **352** |
| inductor: per-copy latency (ms) | 70.1 | 70.7 | 71.0 | 71.6 | 72.3 | 74.0 |
| inductor: DRAM read / write per inference (MB) | 106 / 4 | 121 / 4 | 128 / 7 | 139 / 15 | 144 / 19 | 151 / 24 |

* **For throughput, independent copies beat threading by 3.4x** (baseline
  at 26 cores: 221 vs 65.5 inferences/s; inductor: 352 vs 131). The cost is
  latency: each image takes 74-118 ms instead of 7.6-15 ms.
* With 26 copies, **each baseline copy is 19% slower than alone, and DRAM
  traffic per inference triples** (reads 137 -> 408 MB, writes 11 -> 171
  MB). INFERRED: each copy's share of the 52.5 MiB shared L3 shrinks to
  ~2 MiB, so intermediate activation tensors (BN, ReLU and add outputs up to
  3.2 MB) no longer stay on chip and are written to and re-read from DRAM.
* **Inductor copies slow down by only 5.4%**, with 24 MB of DRAM writes per
  inference instead of 171. Its fused convolutions never write the
  BN/ReLU/add intermediates (section 21.5), so there is far less data to
  spill. INFERRED from the write traffic. Scaling efficiency is 95% (24.7x
  on 26 cores).
* Total DRAM bandwidth at 26 baseline copies is 128 GB/s (90 read + 38
  write), 42% of the theoretical peak. Not saturated, but growing fastest for
  the eager variants.

### 23.3 What limits thread scaling (OBSERVED, `results/2026-10-06_followups/raw/breakdown_*.json`)

Per-operator time (forward hooks, median of 30) of the baseline at 1, 4, 16
and 26 threads (`experiments/multicore_breakdown.py`; other users' CPU <= 6%
throughout, `raw/contention.csv`):

| operator type | calls | 1 thread (ms) | 26 threads (ms) | speedup | share of time at 26 |
|---|---|---|---|---|---|
| conv 1x1 (33 MKL + 3 oneDNN) | 36 | 40.87 | 6.89 | 5.9x | 46% |
| conv 3x3 | 16 | 35.92 | 4.38 | 8.2x | 29% |
| batchnorm | 53 | 4.98 | 1.48 | 3.4x | 10% |
| relu | 49 | 1.81 | 0.93 | **1.9x** | 6% |
| max-pool | 1 | 10.18 | 0.49 | 20.9x | 3% |
| add | 16 | 2.03 | 0.41 | 5.0x | 3% |
| conv 7x7, fc, avgpool | 4 | 2.77 | 0.36 | 7.7x | 2% |
| between operators (e2e - sum of ops) | | ~1.2 | 1.15 | ~1x | 7% |

* **Small operators hit a fixed per-call floor.** At 26 threads, a BN, ReLU
  or add call takes 22-26 µs regardless of tensor size: 118 calls ≈ 2.8 ms
  (19%). The per-call software cost measured in section 22 (1-10 µs) plus
  waking 26 OpenMP threads per call sets that floor (INFERRED). ReLU barely
  speeds up at all (1.9x).
* **Serial Python between operators stays at ~1.2 ms** (7% at 26 threads).
* **1x1 convs** (mostly MKL SGEMM) scale only 5.9x and become 46% of the
  time.
* **The 7x7-map layer4 3x3 convs scale 4.6-4.9x** (layer4.1/4.2.conv2:
  3.16 -> 0.65-0.68 ms). layer4.0.conv2 has the same weights and output size
  but a 14x14 input with stride 2, and scales 12.6x (3.43 -> 0.27 ms).
  INFERRED: with only 49 output pixels there is too little independent work
  for 26 threads in oneDNN's direct-conv decomposition.
* Going from 16 to 26 threads makes conv3x3, BN and ReLU slower
  (3.94 -> 4.38, 1.40 -> 1.48, 0.89 -> 0.93 ms). Only conv1x1 gains
  (7.92 -> 6.89).
* CALCULATED (Amdahl fit to 98.9 -> 15.3 ms): an effective serial part of
  ~12 ms. Time above perfect scaling at 26 threads breaks down as: 1x1 convs
  +5.3 ms, 3x3 convs +3.0 ms, BN/ReLU/add +2.5 ms, Python +1.1 ms
  (≈ 12 ms).
* fold_bn+channels_last at 26 threads (10.47 ms): no BN, max-pool 0.06 ms,
  convs scale 8.6x (1x1) and 10.8x (3x3); ReLU+add still ~0.9 ms.

## 24. Multi-core study with hardware counters (single core vs intra-op vs inter-op vs combinations)

`MCS` = `results/2026-10-06_mc_study/` (`scripts/mc_study.py`, analysis
`analysis/analyze_mc_study.py`, tables `MCS/processed/MC_STUDY.md` and
`mc_configs.csv`). For every configuration: S worker processes on disjoint
core sets of K cores (`experiments/mc_run.py`), one common window with two
`perf stat -a -C <cores>` counter passes (checked: 100% counting, no
multiplexing), socket DRAM traffic (uncore IMC), and a `perf record` profile
classified by library. Other users' CPU was sampled before and during every
window: **all 53 configurations ran clean** (one was contaminated and re-run
automatically). The unmodified baseline is in every comparison; `inductor`
(torch.compile) is the optimized reference. FLOPs per image measured by the
FP counters stay at 8.0-8.2 G in every configuration (sanity check).

**Topology / SMT (OBSERVED):** 1 socket, 28 physical cores, 1 NUMA node,
SMT disabled (`/sys/devices/system/cpu/smt/control = off`, CPUs 28-55
offline). An SMT comparison would need a system-wide change on a shared
machine, so it was not done (priority 21).

### 24.1 The memory system's ceiling (OBSERVED, `MCS/raw/membw_ceiling.json`)

n concurrent AVX-512 read streams of 1 GiB each:

| cores streaming | 1 | 2 | 4 | 8 | 16 | 28 |
|---|---|---|---|---|---|---|
| DRAM GB/s | 18.1 | 37.5 | 74.5 | 140.9 | 235.2 | **244.2** |

Linear to 8 cores, saturating at ~16. 244 GB/s = 80% of the 307 GB/s
theoretical (CALCULATED). One core gets only 7% of the socket.

### 24.2 Intra-op scaling: one inference on N cores (OBSERVED, `MCS/processed/MC_STUDY.md`)

Baseline (eager, FP32, batch 1), inter-op = 1:

| Cores | Intra-op | Inter-op | Latency ms | Throughput img/s | Speedup T1/TN | Efficiency | IPC | Memory BW GB/s | LLC misses / image | CPU util (unhalted / useful work) | OpenMP spin share | L2-miss latency | Bottleneck (INFERRED) |
|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---|
| 1 | 1 | 1 | 98.8 | 10.1 | 1.00 | 100% | 2.30 | 1.4 | 1.46 M | 100% / 97% | 0% | 67 ns | compute (FMA) in convs; max-pool/BN/re-layout overhead |
| 2 | 2 | 1 | 56.3 | 17.8 | 1.76 | 88% | 2.00 | 2.3 | 1.40 M | 100% / 90% | 6% | 72 ns | backend switch + serial re-layout/framework |
| 4 | 4 | 1 | 32.4 | 30.9 | 3.05 | 76% | 1.76 | 4.6 | 1.56 M | 100% / 77% | 19% | 86 ns | serial work around convs |
| 8 | 8 | 1 | 20.5 | 48.8 | 4.83 | 60% | 1.42 | 6.5 | 1.43 M | 100% / 66% | 32% | 97 ns | synchronisation: threads wait at barriers |
| 16 | 16 | 1 | 15.4 | 64.5 | 6.40 | 40% | 0.87 | 8.4 | 1.40 M | 100% / 54% | 45% | 110 ns | synchronisation / too little parallel work |
| 28 | 28 | 1 | 15.4 | 59.6 | 6.41 | 23% | 0.55 | 8.0 | 1.55 M | 97% / 37% | **61%** | 110 ns | synchronisation / too little parallel work |

inductor: 70.1, 37.4, 20.2, 11.8, 7.8, **7.6 ms** (9.25x, 33% efficient at 28
cores); OpenMP spin 0 -> 51%; IPC 2.96 -> 1.02.

WHERE / WHAT / HOW / WHY of each transition:

* **1 -> 2 cores (WHAT: the code changes).** HOW: MKL calls per inference
  fall from 34 to 1 and oneDNN convolutions rise from 20 to 53 (verbose
  census, `MCS/raw/verbose_per_op_K*.txt`); the MKL share of samples drops
  from 34% to 0 (`MCS/plots/mc_migration_baseline.png`). WHY: PyTorch's
  convolution dispatch routes 1x1 convs to oneDNN instead of MKL whenever
  more than one thread is used (OBSERVED behaviour; rule INFERRED). Every
  conv now converts its weights (94 MB per inference) and activations on
  every call.
* **2 -> 8 cores (WHAT: compute scales, the work around it does not).**
  HOW (per-layer library timers, `MCS/processed/split_by_threads.csv`):
  conv kernels 68.5 -> 8.7 ms (7.8x on 8 cores), but activation re-layout
  2.1 -> 2.0 ms (no speedup), framework around convs 2.7 -> 4.1 ms (gets
  slower), BN+ReLU+add 8.9 -> 2.8 ms (3.2x). WHY: these parts run serially
  on the main thread or in tiny parallel regions; while they run, the other
  threads spin (OpenMP spin share 6% -> 32%).
* **8 -> 16 -> 28 cores (WHAT: adding cores adds only waiting).** HOW:
  latency 20.5 -> 15.4 -> 15.4 ms; the OpenMP runtime takes 32% -> 45% -> 61%
  of busy cycles; IPC falls 1.42 -> 0.55 (spin loops); useful-work
  utilisation 66% -> 37%; per-core work imbalance (max/mean of work samples)
  1.11 -> 1.33; FLOP rate per busy cycle 36% -> 13% of peak. Conv kernels
  still speed up (12.9x at 16, 17.3x at 28) but the non-scaling parts are
  now 74% of the time. WHY: Amdahl. Of the 15.1 ms at 28 threads, conv math
  is 4.0 ms; re-layout 3.8 ms, framework 3.8 ms, small elementwise ops
  3.0 ms barely parallelise.
* **It is not memory bandwidth.** DRAM traffic peaks at 8.4 GB/s (3.6% of the
  244 GB/s ceiling) and DRAM bytes per image stay at ~130 MB; LLC misses per
  image are flat (1.4-1.6 M); cycles stalled on L3 misses fall from 2.5% to
  1.1%.
* **Memory latency does rise: 67 -> 110 ns per L2 miss (Little's law on
  offcore occupancy) at 16-28 cores, although DRAM bandwidth stays tiny.**
  HOW: L2 fills per image double (543 -> 1172 MB) while DRAM bytes per image
  stay flat. INFERRED: with intra-op threading, each core reads activations
  written by other cores in the previous operator, so data moves core-to-core
  across the mesh (slower than a local L3 hit); this is on-chip data
  movement, not DRAM.

### 24.3 Inter-op parallelism inside one inference (OBSERVED, `MCS/interop_rerun/raw/`)

| setting | eager | traced, 4 downsample branches forked |
|---|---|---|
| intra 1, inter 1 | 98.8 ms | 98.2 ms |
| intra 1, inter 2 (unbound threads) | 98.7 | **88.7 ms (1.11x)** |
| intra 1, inter 4 (unbound) | 98.6 | 88.7 |
| intra 2, inter 2 (unbound) | 56.2 | **50.0 (1.12x)** |
| intra 4, inter 2 (unbound) | 32.1 | 32.0 |
| intra 2, inter 2, `OMP_PROC_BIND=close` | 56.4 | **109.7 (worse)** |

* Eager PyTorch executes operators one after another: inter-op threads
  change nothing (98.8 vs 98.6 ms).
* ResNet's dependencies limit useful overlap: only the 4 downsample branches
  (8.9 ms of work) can run beside the main path, so the bound is 1.10x
  (CALCULATED from per-branch hook times in the same process). The traced,
  forked model reaches it (1.11-1.12x; the extra percent is the removed
  Python layer). More inter-op threads (4) add nothing: there is never more
  than one branch to overlap.
* **Thread binding breaks it.** With `OMP_PROC_BIND=close`, every thread,
  including PyTorch's inter-op pool, inherits the main thread's binding
  (`thread_cpus` in the JSON: all threads allowed only on core 1, or 1-2):
  the forked branch competes for the same cores, and intra 2 / inter 2
  becomes 2x slower (109.7 ms). The first inter-op run of the study
  (`MCS/raw/interop_*.json`) had this binding and is superseded by the
  re-run.

### 24.4 Inter-op across independent requests: N streams (OBSERVED)

N single-threaded copies, one per core (baseline / inductor):

| streams (cores) | 1 | 4 | 8 | 16 | 28 |
|---|---|---|---|---|---|
| baseline img/s | 10.1 | 39.7 | 77.0 | 146.9 | **230.9** (22.9x, 82%) |
| baseline per-stream latency ms | 98.8 | 101.2 | 103.7 | 108.8 | 120.4 (+22%) |
| baseline DRAM GB/s (% of ceiling) | 1.4 (8%) | 11.9 (16%) | 31.6 (22%) | 77.6 (33%) | **135.8 (56%)** |
| baseline DRAM MB / image | 137 | 299 | 410 | 529 | 588 |
| baseline LLC misses / image | 1.46 M | 3.34 M | 4.42 M | 5.61 M | 6.30 M |
| baseline L2-miss latency | 67 ns | 78 | 85 | 99 | **132 ns** |
| baseline cycles stalled on L3 miss | 2.5% | 5.2% | 7.2% | 10.5% | 15.4% |
| inductor img/s | 14.2 | 56.2 | 111.4 | 221.7 | **373.1** (26.3x, 94%) |
| inductor DRAM MB / image | 106 | 130 | 154 | 165 | 178 |
| inductor L2-miss latency | 66 ns | 78 | 82 | 85 | 96 ns |

* **Here memory is the bottleneck, and it migrates with core count.** At
  1-4 streams each copy runs as if alone (compute-bound convs). From 8
  streams on, the copies compete for the shared 52.5 MiB L3: each copy's
  share shrinks to ~2 MiB, LLC misses per image grow 4.3x, and activations
  that stayed on chip now go to DRAM (DRAM bytes per image 4.3x). At 28
  streams DRAM traffic reaches 136 GB/s, 56% of the ceiling; L2-miss latency
  doubles (67 -> 132 ns) as the memory controllers queue requests (loaded
  latency), and stalls on L3 misses rise to 15% of cycles. Result: each copy
  is 22% slower. INFERRED from these counters.
* **inductor copies interfere much less** (+6% per copy, 178 MB DRAM per
  image, 96 ns): fusion keeps BN/ReLU/add intermediates inside the conv
  kernels, so there is less data to spill.

### 24.5 How to divide the cores between intra-op and streams (OBSERVED, `MCS/plots/mc_matrix.png`)

28 cores (latency ms / throughput img/s):

| intra-op x streams | 1 x 28 | 2 x 14 | 4 x 7 | 7 x 4 | 14 x 2 | 28 x 1 |
|---|---|---|---|---|---|---|
| baseline | 120 / **231** | 64.5 / 215 | 34.3 / 201 | 24.1 / 162 | 17.5 / 109 | **15.4** / 60 |
| inductor | 74.5 / **373** | 39.2 / 354 | 21.3 / 323 | 14.2 / 274 | 9.7 / 196 | **7.6** / 120 |

* Throughput always prefers more streams; latency always prefers more
  intra-op threads. The trade is not symmetric: going from 1x28 to 4x7 costs
  only 13% (baseline) / 13% (inductor) of throughput but cuts latency 3.5x.
  Past ~8 threads per stream, OpenMP spin exceeds 30% and throughput falls
  fast.
* Rule of thumb from these measurements: for throughput, 1-2 threads per
  stream; for latency, at most ~8-14 threads per inference (beyond 16 adds
  nothing); a balanced point is 4 threads x 7 streams (inductor: 21 ms,
  323 img/s).

### 24.6 Batch size x cores (OBSERVED; baseline, one process, intra-op = cores)

| | B=1 | B=4 | B=16 | B=64 |
|---|---|---|---|---|
| 1 core: img/s (batch latency) | 10.1 (99 ms) | 10.1 (0.40 s) | 8.4 (2.0 s) | 5.8 (10.2 s) |
| 8 cores | 48.8 (20 ms) | 55.6 (72 ms) | 44.0 (0.37 s) | 34.2 (2.0 s) |
| 28 cores | 59.6 (15 ms) | **104.5** (34 ms) | 65.7 (0.24 s) | 43.7 (1.5 s) |
| 1 core: DRAM MB / image | 137 | 151 | 461 | 769 |
| 1 core: FLOP rate (% of peak per busy cycle) | 62% | 61% | 47% | 38% |

* Small batches help multi-core (28 cores: B=4 gives 1.75x the throughput of
  B=1: more work per parallel region, OpenMP spin 61% -> 46%).
* Large batches hurt on this CPU in eager mode: per-image throughput falls
  at every core count for B >= 16. HOW: DRAM bytes per image grow 5.6x at
  B=64 on one core and the FLOP rate falls to 38% of peak. INFERRED: a
  B=64 activation tensor is up to 205 MB, so eager layer-by-layer execution
  streams every activation through DRAM; and the weights saved (read once per
  batch) are far smaller than the activation traffic added.
* So the model has enough parallel work per image only up to ~4-8 cores at
  batch 1; latency-oriented serving should use few threads per request,
  throughput-oriented serving should use streams (24.4) rather than large
  batches.

### 24.7 Why isn't it N times faster? (summary)

| configuration | loss of efficiency at 28 cores | cause (evidence) |
|---|---|---|
| one inference, 28 threads | 77% lost (6.4x) | **synchronisation / insufficient parallel work + serial overhead** (61% of busy cycles spinning in OpenMP; re-layout, framework and small ops do not scale; IPC 0.55) -- not bandwidth (3.6% of ceiling) |
| 28 independent copies | 18% lost (22.9x) | **shared L3 capacity + loaded DRAM latency** (LLC misses/image 4.3x, DRAM 56% of ceiling, L2-miss latency 2x) |
| 28 inductor copies | 6% lost (26.3x) | same mechanism, much smaller because fusion avoids intermediates |
| operator-level inter-op | capped at 1.10x | **dependencies** (only 4 branches can overlap) |

Bottleneck migration (baseline, one inference): compute-bound convs at 1
core -> backend switch + serial re-layout/framework at 2-4 cores ->
synchronisation (threads idle-spinning) from 8 cores on. For independent
streams it migrates the other way, toward memory: compute at 1-4 copies ->
shared-L3/DRAM contention at 16-28 copies.

---

## Appendix: reproducing every number

| result | command | output |
|---|---|---|
| system inventory | `scripts/collect_system_info.sh` | `results/2026-10-05_system/` |
| compute / latency / bandwidth | `scripts/run_microbench.sh` | `MB/` |
| counter validation | `scripts/run_counter_validation.sh` | `results/2026-10-06_counter_validation/` |
| end-to-end + per-operator | `scripts/run_resnet_baseline.sh` | `BASE/` |
| backend path | `scripts/run_backend_probe.sh` | `BK/` |
| instruction profile | `scripts/run_instruction_profile.sh` | `INS/` |
| dispatch overhead | `scripts/run_dispatch_overhead.sh` | `DSP/` |
| optimizations | `scripts/run_optimizations.sh` | `OPT/` |
| ISA probe | `scripts/run_isa_probe.sh` | `results/2026-10-06_isa_probe/` |
| multi-core | `scripts/run_multicore.sh` | `MC/` |
| follow-ups (Python overhead, per-op thread scaling) | `scripts/run_followups.sh` | `results/<date>_followups/` |
| per-calculation cost (core vs operator) | `scripts/run_per_calc.sh` | `results/2026-10-06_per_calc/` |
| multi-core study with counters | `taskset -c 27 .venv/bin/python scripts/mc_study.py --out DIR` | `results/2026-10-06_mc_study/` |
| inter-op re-run (with/without binding) | `scripts/run_interop_rerun.sh DIR` | `results/2026-10-06_mc_study/interop_rerun/` |

Prefix each measurement with `scripts/wait_quiet.sh` on a shared machine.
