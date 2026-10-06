# Experiment guide

How to run, read and reason about every experiment in this repository.
Companion documents:
[HARDWARE_GUIDE](HARDWARE_GUIDE.md) (the machine),
[PERF_GUIDE](PERF_GUIDE.md) (the tools),
[INTERPRETATION_GUIDE](INTERPRETATION_GUIDE.md) (combining counters),
[RESULTS](RESULTS.md) (what we found), [RESEARCH_LOG](RESEARCH_LOG.md) (when and how).

Every experiment follows the same contract:

* It is started by one script in `scripts/` and writes a new directory
  `results/<YYYY-MM-DD>_<name>/` (a `_HHMMSS` suffix is added if that
  directory exists, so nothing is ever overwritten).
* Inside: `raw/` (unaggregated measurements, one row per repetition),
  `processed/` (CSV/JSON summaries and Markdown reports), `plots/` (PNG),
  and sometimes `raw_large/` (perf.data files; git-ignored).
* Every claim is labelled **OBSERVED** (measured), **CALCULATED**
  (arithmetic on measurements or shapes), **INFERRED** (interpretation) or
  **UNKNOWN** (not measurable with what we have).

## Contents

0. [Before you start: environment and noise](#0-before-you-start)
1. [System discovery](#1-system-discovery)
2. [Perf event discovery](#2-perf-event-discovery)
3. [Native microbenchmarks (Level 6 baselines)](#3-native-microbenchmarks-level-6)
4. [Counter validation](#4-counter-validation)
5. [Level 0: end-to-end latency](#5-level-0-end-to-end-latency)
6. [Level 1: operator timing](#6-level-1-operator-timing)
7. [Level 2: CPU counters per operator](#7-level-2-cpu-counters-per-operator)
8. [Level 3: top-down microarchitecture](#8-level-3-top-down-microarchitecture)
9. [Level 5: memory hierarchy per operator](#9-level-5-memory-hierarchy-per-operator)
10. [Backend path: what PyTorch really calls](#10-backend-path)
11. [Level 4: instruction-level profiling](#11-level-4-instruction-level-profiling)
12. [Python / dispatch overhead](#12-python--dispatch-overhead)
13. [Level 7: roofline and bottleneck model](#13-level-7-roofline-and-bottleneck-model)
14. [Optimization experiments](#14-optimization-experiments)

Run everything: `BENCH_CPU=6 scripts/run_all.sh` (about an hour).

---

## 0. Before you start

```bash
scripts/setup_env.sh            # .venv with CPU-only torch/torchvision (pinned in requirements.txt)
make -C microbench              # native benchmarks (g++ -O2 -march=native)
cat /proc/loadavg; mpstat -P ALL 1 3   # is anyone else using the machine?
```

**Single-core configuration.** Every PyTorch experiment imports
`cpuinf/runtime.py` first, which sets `OMP_NUM_THREADS=MKL_NUM_THREADS=1`
*before* torch loads, then calls `torch.set_num_threads(1)`,
`torch.set_num_interop_threads(1)` and pins the process to `--cpu`
(`os.sched_setaffinity`, the same as `taskset -c`). `environment_record()`
saves the affinity, thread counts and `/proc/self/task` count in every
result so you can verify it (OBSERVED: 1 thread).

**Choosing the CPU.** `BENCH_CPU` (default 6). CPUs 0 and 27 receive more
interrupts on this machine (`/proc/interrupts`), so avoid them. The machine
is shared (CloudLab, other users log in): pinning protects the core, but the
L3 and DRAM are shared by all 28 cores. Each experiment records
`/proc/loadavg` at start and end; the DRAM experiment measures background
DRAM traffic. If load is high, wait.

**Frequency.** This machine runs `intel_pstate` with governor `performance`
and turbo disabled, so cores run at the 2.1 GHz base frequency
(OBSERVED: turbostat `Bzy_MHz=2100`; cycles/ref-cycles = 2.095 GHz in every
experiment, including AVX-512). This makes cycles and time interchangeable
(1 ms = 2.1 M cycles). We did not change any frequency setting. If you run
elsewhere and turbo is on, frequency will vary with load and vector width;
always record `cycles/ref-cycles`.

---

## 1. System discovery

| | |
|---|---|
| **What** | CPU model, topology, cache geometry, frequency policy, DIMMs, kernel, compilers, Python/PyTorch build, perf version and permissions, PMU devices, background DRAM traffic. |
| **Why** | Every number later depends on this context: you cannot interpret "16 cycles" without knowing the L2 size, or "18 GB/s" without the DRAM configuration. |
| **Where** | `lscpu`, `/proc/cpuinfo`, `/sys/devices/system/cpu/*/cache`, `/sys/devices/system/cpu/*/cpufreq`, `/sys/devices/system/cpu/intel_pstate`, `dmidecode`, `turbostat`, `/proc/sys/kernel/perf_event_*`, `/sys/bus/event_source/devices`. |
| **Command** | `scripts/collect_system_info.sh` |
| **Output** | `results/<date>_system/SYSTEM.md`, `system.json`, `raw/*.txt` |

**Numbers that matter** (OBSERVED here): Xeon Gold 5512U (family 6 model 207),
28 cores, SMT off, 1 socket / 1 NUMA node; L1d 48 KiB, L2 2 MiB private,
L3 52.5 MiB shared; 2.1 GHz fixed; 8 x DDR5-4800 channels -> 307 GB/s
theoretical socket peak (CALCULATED); `perf_event_paranoid=-1` (all events
available to us), `kptr_restrict=1` (kernel symbols hidden in perf report).

**Not justified:** treating the nominal cache sizes as the capacity one core
can effectively use (the L3 is shared and its effective capacity for one
core is measured in section 3), or the theoretical DRAM peak as what one
core can reach (it is ~16x lower; section 3).

Serial numbers, asset tags and MAC addresses are redacted before saving.

---

## 2. Perf event discovery

| | |
|---|---|
| **What** | Which PMU events exist and work on this kernel/CPU, how they are encoded, and their scope (per-thread vs socket-wide). |
| **Why** | Event names differ between CPU generations and kernels; using a non-existent event either fails or (worse) silently reports nonsense. Nothing is hard-coded: candidates in `cpuinf/events.py` are tested. |
| **Where** | `perf list --details`, `/sys/bus/event_source/devices/cpu/{events,format}`, test counts via `perf stat` *and* via our in-process `perf_event_open` path. |
| **Command** | `.venv/bin/python scripts/discover_perf_events.py` |
| **Output** | `results/perf_events.json`, `results/perf_events.md` |

OBSERVED: 72/72 catalog events supported. perf's built-in Top-Down metric
formulas (`perf stat -M TopdownL1`, `--topdown`) are **UNAVAILABLE** for this
CPU model in perf 6.8, but the hardware Top-Down events
(`slots`, `topdown-*`) work; we compute the fractions ourselves
(`cpuinf/metrics.py`). Unsupported events are written as `UNAVAILABLE`,
never as 0.

Counter-scheduling constraints are discovered at run time:
`cpuinf/perfcounters.plan_groups()` greedily packs events into groups that
open **and** run without multiplexing (it verifies `time_enabled ==
time_running`). OBSERVED: at most 4 `MEM_LOAD_RETIRED.*`/`MEM_INST_RETIRED.*`
events fit together; several other memory events have similar restrictions.

---

## 3. Native microbenchmarks (Level 6)

These build the **reference frame**: what this core can do under controlled
conditions, so that ResNet numbers can be compared against something.

| | |
|---|---|
| **Command** | `scripts/run_microbench.sh` (~5 min; `quick` for a short version) |
| **Source** | `microbench/src/{compute,memlat,membw,intensity}.cpp`, `flags_kernels.c` |
| **Output** | `results/<date>_microbench/` -> `processed/machine_model.json` (the summary every later analysis uses), `plots/*.png`, `asm/*.asm` (objdump of every binary) |

Every row of raw CSV is one repetition with `ns`, `cycles`, `ref_cycles`,
`instructions` measured around the timed region only (in-process
`perf_event_open`), plus the amount of `work` (ops, loads, bytes, FLOPs).

### 3a. Compute: latency vs throughput (`compute`)

* **What:** time per instruction for chains of dependent instructions
  (scalar int add/imul, scalar FP add/mul/FMA, SSE/AVX2/AVX-512 FMA, AVX-512
  add/mul), with K = 1..16 independent chains.
* **Why:** K=1 exposes the **latency** of the instruction; large K exposes
  the **throughput** of the execution units. Their product is how much
  independent work a kernel needs to keep the units busy.
* **How it prevents cheating:** each operation is one inline-asm
  instruction (no constant folding or vectorization by the compiler);
  accumulators are kept in registers (verified: zero stack memory operands in
  the hot loops of `asm/compute.asm`).
* **Numbers that matter (OBSERVED):** FMA latency 4 cycles at every width;
  2 FMA/cycle at every width once K >= 8; therefore peak FP32 =
  2 x 16 lanes x 2 FLOP = **64 FLOP/cycle (measured 63.9) = 134 GFLOP/s** with
  AVX-512, 32 with AVX2, 16 with SSE, 4 with scalar FMA. No AVX-512 frequency
  drop (2.095 GHz).
* **Indicates a bottleneck when:** a real kernel's FLOP/cycle is far below
  64, its vector width is < 512, or it lacks enough independent accumulators
  (latency-bound FMA chains).
* **Not justified:** "the machine does 64 FLOP/cycle" for anything but FMA
  with 512-bit vectors and >= 8 independent chains and data in registers.

### 3b. Memory latency (`memlat`)

* **What:** a pointer chase over a working set of 4 KiB..1 GiB; every load's
  address depends on the previous load, so only one miss is ever in flight.
  Patterns: random (Sattolo cycle; defeats prefetchers) and sequential;
  pages: 4 KiB and 2 MiB (THP via `madvise`).
* **Numbers (OBSERVED, random, 2 MiB pages):** L1 5 cycles (2.4 ns),
  L2 16 cycles (7.7 ns), L3 ~63 cycles (30 ns), DRAM ~208 cycles (99 ns).
  With 4 KiB pages the L3 and DRAM plateaus are higher (TLB misses add page
  walks: ~123 ns at 1 GiB). Sequential chase: ~3-5 ns at any size
  (prefetchers fetch ahead).
* **Read the plot** `memory_latency_vs_ws.png`: plateaus = levels; steps =
  *apparent* transitions. OBSERVED: the L3 plateau ends around 32-46 MiB, not
  at the nominal 52.5 MiB -- an empirical observation (shared, non-inclusive,
  hashed L3; other tenants), not a measured capacity.
* **Not justified:** reading exact cache sizes off the plot; using pointer
  chase latency as the cost of loads in code that has many independent loads
  (see bandwidth).

### 3c. Memory bandwidth (`membw`)

* **What:** GB/s and bytes/cycle for read, write, non-temporal write, copy,
  triad and independent random reads vs working set.
* **Numbers (OBSERVED, read):** L1 ~120 B/cycle (2 x 64 B loads/cycle),
  L2 ~50 B/cycle, L3 ~11 B/cycle (23 GB/s), DRAM ~8.8 B/cycle (18.5 GB/s).
  Non-temporal stores: ~23 GB/s at every size (they always go to memory).
* **Key insight:** one core's bandwidth beyond L2 is limited by how many
  cache-line misses it can keep in flight (Little's law: bandwidth =
  outstanding lines x 64 B / latency), so it is ~16x below the socket's
  theoretical peak, and L3 is barely faster than DRAM for one core.
* **Not justified:** "the workload is DRAM-bandwidth-bound" because it moves
  a lot of data -- compare the *rate* (bytes/cycle) with these limits.

### 3d. Arithmetic intensity (`intensity`) -- the empirical roofline

* **What:** stream an array (L1/L2/L3/DRAM-sized), apply F FMAs per element
  in registers, F = 0..64. AI = (2F+1)/4 FLOP/byte.
* **Numbers (OBSERVED):** peak 63.2 FLOP/cycle reached at AI >= ~4 (L1/L2),
  >= ~16-32 (DRAM). Low-F points sit on the bandwidth roofs.
* **Use:** `roofline_microbench.png` shows the ridge points. A ResNet
  operator with AI below a level's ridge cannot reach peak if its data comes
  from that level.

### 3e. Compiler options (`flags_*`)

Same C source (`saxpy`, `dot`, `relu`) built five ways. OBSERVED
(cycles/element, L1-resident): `-O2` scalar (1.35 / 1.95 / 2.62);
`-O3` SSE (0.31 / 1.93 / 0.31); `-O3 -march=native` AVX2 -- GCC prefers
256-bit vectors on this CPU by default (0.21 / 1.93 / 0.18);
`-mprefer-vector-width=512` AVX-512 (0.09 / **3.22** / 0.11);
`+ -ffast-math` (0.08 / 0.18 / 0.09).
`dot` is a reduction: without `-ffast-math` the compiler must add in source
order, so it cannot keep vector partial sums; with 512-bit vectors it emits a
`vmulps zmm` followed by 16 dependent `vaddss` (see `asm/flags_O3_native_zmm.asm`)
-- vectorized *and slower*. Lesson: check the assembly, not the flags.

---

## 4. Counter validation

| | |
|---|---|
| **What** | Run microbenchmarks whose correct counter values are known by construction, counting events only around the timed region (`PERF_EXTRA`, `microbench/src/common.h`). |
| **Why** | Before we say "this ResNet layer's loads came from L3", we check that `mem_load_retired.l3_hit` really reports ~1 per load on a kernel where every load hits L3. |
| **Command** | `scripts/run_counter_validation.sh` |
| **Output** | `results/<date>_counter_validation/processed/COUNTER_VALIDATION.md` |

Checks: pointer chases pinned to L1/L2/L3/DRAM (load-source counters),
DRAM attribution (`ocr.demand_data_rd.dram`, uncore CAS), page walks with
4 KiB vs 2 MiB pages, streaming read/write/non-temporal write (line fills,
RFO traffic, prefetch effect on demand-miss counters), FMA counting
(each 512-bit FMA = 2 counts of `fp_arith_inst_retired.512b_packed_single`).
See RESULTS.md for the outcomes; use them to decide which counters to trust.

---

## 5. Level 0: end-to-end latency

| | |
|---|---|
| **What** | Wall-clock time of one complete ResNet-50 forward pass (batch 1, 3x224x224, FP32, one core). |
| **Why** | The top-line number every lower level must add up to. |
| **Where** | `time.perf_counter_ns()` around `model(x)` under `torch.inference_mode()`, plus in-process cycles/instructions/page-faults for the same region. |
| **Command** | `experiments/e2e_latency.py --cpu 6 --iters 300 --warmup 30 --out DIR [--impl torchvision] [--weights imagenet] [--no-counters]` (all four variants are run by `scripts/run_resnet_baseline.sh`) |
| **Output** | `raw/e2e_iters_<tag>.csv` (every iteration), `processed/e2e_summary_<tag>.json` |

Phases are separated: import (~2.4 s), model construction (~0.17 s), weight
init/load (~0.3 s), input creation, warm-up (the first inference is ~30%
slower: oneDNN primitive creation, allocator growth, cold caches), then the
timed iterations. Only the timed iterations count as "inference latency".

**Numbers that matter:** median (the headline), p5/p95 and stddev (noise),
min (best case), IPC, frequency, page faults per inference (0 means the
allocator is reusing memory), context switches / migrations (must be ~0 / 0).

**Controls:** `torchvision` model vs our explicit model (must match:
structural equivalence), ImageNet vs random weights (value-independence of
dense kernels), counters on/off (measurement overhead).

**Not justified:** comparing numbers from runs with different load on the
machine; attributing a 0.1-0.2% difference to anything without repeated runs.

---

## 6. Level 1: operator timing

| | |
|---|---|
| **What** | Time of each of the 175 leaf operators (conv, BN, ReLU, maxpool, add, avgpool, flatten, linear), per bottleneck block and per stage. |
| **Why** | `perf stat python resnet.py` mixes interpreter start-up, imports, model build and 175 different operators; we need per-operator attribution. |
| **Where** | Forward pre/post hooks on every leaf module (`experiments/op_profile.py`). |
| **Command** | `experiments/op_profile.py --cpu 6 --out DIR --iters 30 --reps 7` (or `scripts/run_resnet_baseline.sh`) |
| **Output** | `raw/inmodel_time.csv`, `raw/inmodel_blocktime.csv`, `processed/manifest.csv`, `processed/layer_table.csv`, `processed/by_operation.csv`, `by_stage.csv`, `by_block.csv`, `plots/01_layer_runtime.png`, `02_runtime_share.png` |

Three contexts are measured for every operator:

* **inmodel**: inside a real forward pass (realistic cache contents).
* **standalone_hot**: the same module and weights on a copy of the same
  input, called back-to-back (`--hot-min-ms` per sample): best case, data
  cache-resident if it fits.
* **standalone_cold**: one call after streaming 256 MiB through the caches:
  worst case for data movement.

Compare them in `plots/16_inmodel_vs_standalone.png`: operators much slower
cold than in-model are sensitive to where their data is (weights or
activations not cache-resident); operators equal in all three are
insensitive to caching (compute- or overhead-bound).

**The manifest** (`processed/manifest.csv`) is CALCULATED from shapes: FLOPs
(2 per multiply-accumulate), parameter count, input/weight/output bytes,
compulsory traffic (input + weights + output, each moved once) and
arithmetic intensity. It also gives each conv's equivalent GEMM shape
(M = output pixels, N = output channels, K = Cin x kh x kw).

**Validation:** `cpuinf/resnet.validate_against_torchvision()` checks the
explicit model has identical parameter names/shapes and identical output
(OBSERVED: 25,557,032 parameters, max |diff| = 0.0). The sum of per-operator
times is compared to forward() time; the difference is Python glue between
modules plus hook overhead (reported in REPORT.md).

**Not justified:** reading tiny operator times (< 20 us) to better than the
measured floor; assuming in-model time equals standalone time.

---

## 7. Level 2: CPU counters per operator

| | |
|---|---|
| **What** | cycles, instructions, IPC/CPI, branches/misses, LLC references/misses, page faults, context switches, migrations, retired FP instructions by width (-> measured FLOPs), per operator. |
| **Where** | In-process `perf_event_open` (`cpuinf/perfcounters.py`): the pre-hook starts all counters with one `prctl(PR_TASK_PERF_EVENTS_ENABLE)`, the post-hook stops them. Counting is per-thread, user + kernel. |
| **Passes** | `core`, `sw`, `flops` (and more below). One pass per counter set, each verified not to multiplex. Each pass re-runs the forward pass `--iters` times; medians are used. |

**The floor.** An empty start/stop costs ~5-10 K cycles and ~12-18 K
instructions (Python + ctypes + syscall). It is measured per pass
(`op_profile_meta.json`) and subtracted. Operators below ~50 K cycles
(~25 us) are dominated by measurement uncertainty; for them, prefer the
standalone_hot numbers (many calls per measurement).

**Numbers that matter and how to read them:** see
[INTERPRETATION_GUIDE](INTERPRETATION_GUIDE.md). Start with FLOP/cycle
(CALCULATED FLOPs / MEASURED cycles) against the 64 FLOP/cycle peak, then IPC,
then `flops_measured / flops` (does the kernel do extra arithmetic, e.g.
padding or recomputation?), then vector-width shares
(`fp_inst_512_share`).

---

## 8. Level 3: top-down microarchitecture

| | |
|---|---|
| **What** | Fraction of the core's 6 issue slots per cycle that were Retiring / Bad Speculation / Frontend Bound / Backend Bound (L1), with L2 splits (heavy vs light ops, mispredicts vs machine clears, fetch latency vs bandwidth, memory vs core bound). Also execution-port utilisation (`ports`), stall cycles by outstanding miss level (`stalls`), uop delivery source (`frontend`). |
| **Where** | Hardware TMA counters (`slots`, `topdown-*`; must be read as a group led by `slots`), computed in `cpuinf/metrics.py`. |
| **Output** | `tma_*` columns in `layer_table.csv`; `plots/15_topdown_by_operation.png`; `processed/topdown_by_operation.csv` |

**How to read:** Retiring high (> 0.7) = the pipeline is busy doing work;
whether it is *useful* work depends on FLOPs/instruction. Backend/Memory
Bound high = waiting for data; Backend/Core Bound = waiting for execution
units or dependency chains (e.g. FMA latency). Frontend bound = the core
cannot fetch/decode instructions fast enough (large or JIT'd code, Python).
**Not justified:** naming a bottleneck from L1 alone; see the decision
flow in INTERPRETATION_GUIDE.

---

## 9. Level 5: memory hierarchy per operator

| | |
|---|---|
| **What** | Where retired loads got their data (`mem_load_retired.{l1_hit,fb_hit,l2_hit,l3_hit,l3_miss}`), line fills into L1/L2 (`l1d.replacement`, `l2_lines_in.all`), L2 write-backs, demand reads served by DRAM (`ocr.demand_data_rd.dram`), stall cycles with misses outstanding, memory-level parallelism (`l1d_pend_miss.pending / pending_cycles`), and socket DRAM traffic (uncore IMC CAS counts). |
| **Passes** | `loads`, `traffic`, `stalls`, `dram` |
| **Output** | columns in `layer_table.csv`; `plots/08_layer_cache_misses.png`, `10_layer_bandwidth.png`; perf mem summary in the instruction profile (section 11) |

**DRAM numbers are socket-wide.** The IMC counters see every core. The
`dram` pass measures the idle background rate for 2 s first and subtracts
`rate x operator duration` (`dram_read_net`, `dram_write_net`). OBSERVED
background on this machine: ~0.1 GB/s read when quiet, up to several GB/s
when other users run jobs -- check `op_profile_meta.json`.

**Not justified:** "this operand came from DRAM" for a specific instruction
(perf cannot say that); "LLC misses = DRAM demand stalls" (misses include
prefetches; check `stalls_l3_miss` and `tma_memory_bound`); per-operator DRAM
bytes for operators shorter than ~0.1 ms (background noise dominates).

---

## 10. Backend path

| | |
|---|---|
| **What** | The ATen dispatch chain under every operator, the oneDNN primitives (with implementation names like `jit:avx512_core`) and MKL BLAS calls they reach, their memory formats, and per-call times. |
| **Command** | `scripts/run_backend_probe.sh` |
| **Output** | `results/<date>_backend/processed/BACKEND.md`, `raw/aten_chain_per_layer.csv`, `raw/backend_per_layer.csv`, `raw/verbose_onednn_mkl.log`, symbol lists |

Evidence sources: `torch.profiler` (ATen op tree under a
`record_function("LEAF::<name>")` per module), `ONEDNN_VERBOSE=1`,
`MKL_VERBOSE=1`, `nm` on `libtorch_cpu.so`. See RESULTS.md for the actual
path per operator type (it differs between 1x1 and 3x3 convolutions).

---

## 11. Level 4: instruction-level profiling

| | |
|---|---|
| **What** | Which shared libraries and symbols the cycles land in, and which instructions inside the hottest kernels. |
| **Command** | `scripts/run_instruction_profile.sh` (`LAYERS="..."` to choose operators) |
| **How** | `perf record -k 1 -e cycles:P -c 200003 --call-graph lbr` on `experiments/infer_loop.py` (full inference, or `--layer NAME` for one standalone operator). oneDNN JIT code is made visible with `ONEDNN_JIT_PROFILE=6` + `perf inject --jit`; Python frames with `python -X perf`. Then `perf annotate -M intel` of the hottest symbols; `analysis/analyze_instructions.py` classifies instructions (FMA, vector loads, broadcasts, stores, shuffles, scalar FP, integer/address, branches). `perf mem` samples load latencies and data sources. |
| **Output** | `processed/INSTRUCTIONS.md`, `annotate/*.annotate.txt`, `plots/instruction_mix_by_operator.png` |

**Read with care:** cycles:P samples land on the instruction that was
*waiting* or the one after it ("skid"), so an instruction right after a
long-latency load often carries that load's cost. Weighted (sample) mix says
where time goes; static mix says what the code is made of.

---

## 12. Python / dispatch overhead

| | |
|---|---|
| **What** | Cost per call of an empty Python function, `nn.Identity`, and ReLU/add/BN/conv/maxpool on tensors of 1..4M elements; linear fit `cycles = fixed + per_element x N`. |
| **Command** | `scripts/run_dispatch_overhead.sh` |
| **Output** | `processed/DISPATCH.md`, `dispatch_fits.csv`, `plots/dispatch_overhead.png` |

The intercept estimates size-independent overhead (Python, argument
parsing, dispatcher, allocation, primitive lookup). Multiply by the number
of operator calls per inference (175 leaf modules) for an order-of-magnitude
estimate of total overhead, and compare with the "unattributed" time and the
time of the smallest operators. **Not justified:** treating the intercept as
an exact per-call dispatch cost inside the model (caches and branch
predictors are in a different state there).

---

## 13. Level 7: roofline and bottleneck model

`analysis/analyze_resnet.py` combines everything:

* `plots/11_roofline.png`: every operator at (CALCULATED arithmetic
  intensity, MEASURED FLOP/cycle) under the measured roofs.
* Classification in `REPORT.md` (empirical approximation): compute-bound if
  >= 50% of measured peak FLOP/cycle; bandwidth-bound if compulsory
  bytes/cycle >= 50% of the measured single-core bandwidth of the level its
  working set fits in; otherwise "below both roofs" = neither arithmetic nor
  bandwidth explains the time (latency, overhead, poor code).
* Then explain each class with Levels 2-5: e.g. a convolution at 77% of peak
  with high Retiring and few memory stalls is close to its limit; an
  elementwise op "below both roofs" with low IPC and high fixed cost is
  overhead-bound.

---

## 14. Optimization experiments

Only after the baseline is understood. Each lives in
`experiments/opt_*.py` and writes `results/<date>_opt_<name>/`:

1. State the hypothesis and the baseline evidence for it.
2. Make one minimal change.
3. Measure end-to-end and per-operator time with the same scripts.
4. Re-run the relevant counter passes.
5. Decide whether the change addressed the measured bottleneck (not merely
   whether it was faster).

See RESULTS.md section "Optimization experiments" for the ones run so far.
