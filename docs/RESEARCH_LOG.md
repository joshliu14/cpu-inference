# Research log

Chronological record of experiments. Each entry: date, commit, command,
machine configuration, hypothesis, methodology, raw result location, key
metrics, interpretation, limitations, next experiment. Labels: OBSERVED /
CALCULATED / INFERRED / UNKNOWN.

Machine for all entries unless noted: CloudLab Dell PowerEdge C6620, Intel
Xeon Gold 5512U (28 cores, SMT off, 1 socket), turbo off, governor
performance, 2.1 GHz, Ubuntu 24.04.4, Linux 6.8.0-138, GCC 13.3, Python
3.12.3, torch 2.14.1+cpu (oneDNN v3.12.0, MKL 2024.2), perf 6.8.12.
Measurement CPU: 6. The machine is shared with other users.

---

## 2026-10-05 -- E0: environment and system discovery

* **Commit:** 12099ad
* **Command:** `scripts/collect_system_info.sh`, `scripts/discover_perf_events.py`
* **Hypothesis:** none (inventory).
* **Methodology:** read-only probes (lscpu, sysfs, dmidecode via passwordless
  sudo, turbostat, perf). Event discovery tests each candidate with
  `perf stat` and in-process `perf_event_open`.
* **Results:** `results/2026-10-05_system/`, `results/perf_events.json`
* **Key observations:**
  * OBSERVED: turbo disabled, scaling max = base = 2.1 GHz; turbostat busy
    frequency 2100 MHz. Cycles convert directly to time.
  * OBSERVED: `perf_event_paranoid=-1` and passwordless sudo -> no permission
    blockers. `kptr_restrict=1` hides kernel symbols (irrelevant for user-space
    kernels).
  * OBSERVED: perf 6.8 has no TMA metric formulas for this CPU model
    (`-M TopdownL1` fails), but hardware `slots`/`topdown-*` events work
    (L1 fractions sum to 0.99995 of slots; slots/cycle = 6.000).
  * OBSERVED: 72/72 catalogued events count. The first discovery run
    falsely marked the `topdown-*` events unavailable because they were
    tested outside a `slots`-led group -- fixed and re-run.
  * OBSERVED: another user's parallel build was running at the start
    (load ~5); background DRAM traffic varied from ~0.06 to ~5 GB/s.
* **Limitations:** shared machine; L3/DRAM contention from other tenants
  cannot be prevented without affecting them.
* **Next:** native baselines.

## 2026-10-05 -- E1: native microbenchmarks (Level 6)

* **Commit:** af7c4cf
* **Command:** `scripts/run_microbench.sh` (BENCH_CPU=6)
* **Hypothesis:** the core sustains 2 x 512-bit FMA/cycle (64 FP32
  FLOP/cycle) if two FMA units are present; latency/bandwidth steps appear at
  48 KiB, 2 MiB and ~52 MiB.
* **Methodology:** inline-asm dependency chains (K = 1..16), pointer chase
  (Sattolo random cycle, 4 KiB and 2 MiB pages), AVX-512 bandwidth kernels,
  adjustable-intensity kernel, one C source under five compiler-flag sets.
  In-process cycles/instructions around timed regions; 5-7 repetitions.
* **Results:** `results/2026-10-05_microbench/` (`processed/machine_model.json`)
* **Key metrics (OBSERVED):** FMA latency 4 cycles; 2 FMA/cycle at all
  widths -> 63.9 FLOP/cycle (134 GFLOP/s); no AVX-512 frequency drop.
  Latency L1 5 / L2 16 / L3 63 / DRAM 208 cycles (2 MiB pages). Read
  bandwidth L1 120 / L2 50 / L3 11 / DRAM 8.8 bytes/cycle.
* **Interpretation (INFERRED):** single-core bandwidth beyond L2 is limited by
  outstanding misses per core, not by DRAM (socket peak 307 GB/s CALCULATED
  vs 18.5 GB/s achieved). L3 is barely faster than DRAM for one core.
* **Problems found and fixed during the experiment:** the first build of
  `compute` kept FMA accumulators on the stack (a `"r,m"` asm constraint
  forced them to memory), which would have inflated latency by
  store-forwarding; detected by inspecting the assembly, fixed with
  register-only sinks, verified zero stack operands.
* **Limitations:** plateau windows are chosen inside nominal capacities;
  apparent L3 capacity (~32-46 MiB) is an observation only.
* **Next:** ResNet-50 baseline.

## 2026-10-05 -- E2: ResNet-50 end-to-end, first baseline (out-of-place Add)

* **Commit:** (working tree after af7c4cf; kept as control)
* **Command:** `scripts/run_resnet_baseline.sh`
* **Results:** `results/2026-10-05_control_outofplace_add/` (see NOTE.md)
* **Key metrics (OBSERVED):** explicit model 99.77 ms median vs torchvision
  98.38 ms.
* **Interpretation (INFERRED, then confirmed by E3):** the explicit model's
  residual `Add` allocated a new tensor (`a + b`) while torchvision adds in
  place (`out += identity`). Changed `Add` to in-place.
* **Problem found:** the `loads` counter pass failed with EINVAL: at most 4
  `MEM_*_RETIRED` events fit in one group on this PMU. Fixed by
  `plan_groups()` (verified-schedulable sub-passes). While fixing it we also
  found (a) fds leaked by a failed group open were later re-enabled by
  `prctl(PR_TASK_PERF_EVENTS_ENABLE)` and caused silent multiplexing, and
  (b) unclosed uncore events made every start/stop cost ~150 K cycles of
  IPIs. Both fixed and verified (floor back to ~9 K cycles, no multiplexing).

## 2026-10-06 -- E3: ResNet-50 canonical baseline (Levels 0-3, 5)

* **Command:** `scripts/run_resnet_baseline.sh` (300 timed iterations
  e2e; 30 iterations per counter pass; 7 reps standalone)
* **Results:** `results/2026-10-06_resnet_baseline/`
* **Key metrics (OBSERVED):** explicit 98.57 ms, torchvision 98.55 ms,
  ImageNet weights 98.32 ms, counters off 98.51 ms; stddev 0.13-0.24 ms;
  0 page faults per steady-state inference; 1 thread.
* **Per-operator results (OBSERVED, `results/2026-10-06_resnet_baseline/processed/REPORT.md`, `layer_table.csv`):**
  conv1x1 41.6% of time at 49.3 FLOP/cycle, conv3x3 36.4% at 49.1,
  maxpool 10.3% at 0.075 FLOP/cycle, batchnorm 5.0%, conv7x7 2.2%, add 2.1%,
  relu 1.8%, fc+avgpool+flatten 0.6%. 80% of the time is in operators at
  >= 50% of FMA peak. layer4 is the least efficient stage (35.9 FLOP/cycle).
  fc is the only DRAM-bandwidth-bound operator (7.9 B/cycle, IPC 0.31).
  DRAM reads per layer equal the layer's weight size; ~94 MB DRAM reads and
  ~1.9 MiB writes per inference.
* Per-operator top-down: the perf-metrics `topdown-*` pass gave the same split
  for every operator (cumulative 8-bit PERF_METRICS fractions); replaced by
  the general-purpose `tdgp` pass. A first `tdgp` run overlapped another
  user's all-core job (load ~26, ~65 GB/s DRAM); re-measured on a quiet
  machine (memory-bound fractions differed by only 0.01-0.02). Contended data
  kept in `raw/contended_tdgp_run/`.

## 2026-10-06 -- E4: counter validation on known-answer kernels

* **Commit:** 00e1cf5. **Command:** `scripts/run_counter_validation.sh` (quiet gate)
* **Hypothesis:** each counter used for ResNet counts what its name says, to
  within a few %, on kernels whose answer is known.
* **Results:** `results/2026-10-06_counter_validation/processed/COUNTER_VALIDATION.md`
* **Key metrics (OBSERVED):** pointer chase at each level -> 1.011 /
  1.0009 / 0.969 / 1.0000 hits per load at L1 / L2 / L3 / DRAM; DRAM chase
  -> `ocr.demand_data_rd.dram` 0.9999 per load, IMC CAS read 1.12 per load;
  sequential read -> `l2_lines_in.all` 1.005 and IMC CAS 1.003 per line, but
  `mem_load_retired.l3_miss` only 0.47 per line (prefetcher); regular stores
  -> CAS read 0.99 + write 0.96 per line (RFO), NT stores -> 0.01 + 1.003;
  4 KiB pages at 1 GiB -> 0.995 page walks per load, 2 MiB pages -> 0;
  512-bit FMA loop -> FP_ARITH 2.0000 per FMA instruction (an FMA counts
  twice), ports 0 and 5 0.50 uops each per FMA.
* **Interpretation:** the counters are trustworthy for ResNet; DRAM traffic
  must come from `l2_lines_in` / IMC / OCR, not from `l3_miss` load counts.
* **Limitations:** a first run overlapped another user's all-core job and
  turned the 16 MiB L3 chase into DRAM misses; kept as
  `_CONTENDED` and re-run after adding the quiet gate.

## 2026-10-06 -- E5: backend path (which library runs each operator)

* **Commit:** 00e1cf5. **Command:** `scripts/run_backend_probe.sh`
* **Methodology:** torch.profiler ATen call chains, ONEDNN_VERBOSE and
  MKL_VERBOSE for one inference; symbol names from perf.
* **Results:** `results/2026-10-06_backend_003851/processed/BACKEND.md`
* **Key observations (OBSERVED):** 33 unstrided 1x1 convs ->
  `aten::thnn_conv2d` -> MKL SGEMM (33.3 ms); 3x3, 7x7 and 3 strided 1x1 convs
  -> `aten::mkldnn_convolution` -> oneDNN JIT avx512_core (35.4 ms) plus 59
  reorder primitives per inference (8.8 ms); fc -> MKL SGEMV; BN, ReLU, add,
  max-pool, avgpool -> ATen native kernels (no library call).
* **Interpretation:** "PyTorch on CPU" is three code bases here (MKL,
  oneDNN JIT, ATen native) chosen per operator by shape heuristics.

## 2026-10-06 -- E6: instruction-level profile (Level 4)

* **Commit:** 00e1cf5 (analysis fixed in 7088916).
  **Command:** `scripts/run_instruction_profile.sh`
* **Methodology:** `perf record -e cycles:P` with LBR call stacks on a
  steady-state inference loop; oneDNN JIT code resolved with
  `ONEDNN_JIT_PROFILE=6` jitdump + `perf inject --jit`; `perf annotate` of
  the 3 hottest symbols of 12 standalone operators; `perf mem` load sampling.
* **Results:** `results/2026-10-06_instruction_profile/processed/INSTRUCTIONS.md`,
  `plots/instruction_mix_by_operator.png`
* **Key observations (OBSERVED):** convs: 94-98% of samples on
  `vfmadd231ps zmm`; max-pool: scalar `vmovss`/`vcomiss`/`ja` loop with an
  `isnan` check in double precision, no FP arithmetic; BN: one ymm FMA per 8
  elements plus two pointer reloads per iteration (46% of samples on GPR
  loads); ReLU/add/avgpool: ymm (AVX2) loops; fc: zmm FMA with memory
  operands (waiting on the weight stream).
* **Problem found and fixed (2026-10-06 15:00):** the `perf mem` table
  showed a "100% N/A" row (the `mem-loads-aux` group leader) and its
  percentages were read as sample shares. Now parsed per sample: of sampled
  slow loads, LFB 30% (98 cycles mean), L1 27% (9), L2 26% (71), L3 14% (75),
  DRAM 2.9% (268). The instruction-mix plot hid GPR loads inside "other";
  regrouped.

* Method change (from E4 on): every measurement waits for
  `scripts/wait_quiet.sh` (load <= 4, socket DRAM <= 2 GB/s) because the
  machine is shared.

## 2026-10-06 -- E7: ISA probe (why ATen elementwise kernels are AVX2)

* **Commit:** c836940. **Command:** `scripts/run_isa_probe.sh` (instruction
  counts are load-independent; run on CPU 20 while the machine was busy)
* **Hypothesis:** ReLU/add/BN run AVX2 code because no AVX512 build of those
  kernels exists, not because of the runtime capability.
* **Results:** `results/2026-10-06_isa_probe/`
* **Key observations (OBSERVED):** with capability unset (AVX512) or forced
  `avx512`, relu_/add_/batchnorm/avgpool retire only 256-bit FP instructions
  (relu_: exactly elements/8); forced `default` makes them scalar; exp is
  512-bit under every setting. `libtorch_cpu.so` has AVX2 and DEFAULT, but no
  AVX512, instantiations of add_kernel, clamp_min_scalar, mul_kernel,
  vectorized_inner_sum.
* **Interpretation (INFERRED):** kernels without an AVX512 build fall back
  to AVX2 on AVX-512 CPUs; no runtime switch changes this.

## 2026-10-06 -- E8: dispatch overhead

* **Commit:** ae97d8d. **Command:** `scripts/run_dispatch_overhead.sh` (quiet)
* **Hypothesis:** fixed per-call software cost is a few µs per operator and
  a small share of a 98 ms inference.
* **Methodology:** cycles/instructions/ns per call for 1..4 M-element inputs;
  smallest-call cost as the direct overhead measurement; linear fits over
  L2-resident sizes as a cross-check.
* **Results:** `results/2026-10-06_dispatch_overhead/processed/DISPATCH.md`
* **Key metrics (OBSERVED):** empty Python call 38 ns; nn.Identity 1.0 µs;
  torch.relu (1 element) 1.28 µs; nn.ReLU module 2.94 µs; BatchNorm2d 9.7 µs
  (66 K instructions); conv1x1 (MKL) 8.0 µs; conv3x3 (oneDNN) 17.6 µs.
  CALCULATED: ~1.3 ms fixed cost per inference (1.3%).
* **Problem found:** the linear fit gives a negative intercept for the NCHW
  max-pool (per-element cost varies with size); flagged as invalid, and the
  smallest-call table added.

## 2026-10-06 -- E9: single-core optimizations

* **Commit:** ae97d8d. **Command:** `scripts/run_optimizations.sh` (quiet;
  other users' CPU 3% throughout, `results/machine_load_2026-10-06.log`)
* **Hypotheses (from E3-E6):** NCHW max-pool is instruction/branch bound
  (~10 ms recoverable); BN folding saves ~4.9 ms; per-call reorders cost
  ~8.8 ms; a compiler that fuses and prepacks removes most of the non-conv
  time.
* **Methodology:** 9 variants from the same weights (`cpuinf/variants.py`),
  output checked against baseline, timed in rotating blocks of 10 until 100
  each; per-op hooks; max-pool counters per output; oneDNN verbose and
  torch.profiler census per variant.
* **Results:** `results/2026-10-06_optimizations/processed/OPTIMIZATIONS.md`
* **Key metrics (OBSERVED):** baseline 100.5, fold_bn 98.5, mkldnn_layout
  93.8, maxpool_chlast 92.1, channels_last 89.7, fold_bn+channels_last 86.4,
  jit_freeze 84.2, inductor 70.4 ms (1.43x; 87% of FMA peak).
* **Interpretation:** max-pool hypothesis confirmed (214 -> 24
  instructions/output, mispredicts -> 0). BN folding only -2 ms: the MKL 1x1
  path copies the bias into the output (aten::copy_ 2 -> 35). Weight
  reorders (56 MB eager, 94 MB with all-oneDNN convs) are the expensive
  reorders; only inductor (prepacked weights, post-op fusion) removes them.
  Conv math time is unchanged across variants; the gains come from work
  around the convs.
* **Limitation:** the in-run baseline (100.5 ms) is 2% slower than the
  canonical 98.57 ms (same instructions, more cycles) because nine models are
  resident and interleaved; speedups are relative to the in-run baseline.

## 2026-10-06 -- E10: multi-core scaling (threads and independent instances)

* **Command:** `scripts/run_multicore.sh results/2026-10-06_optimizations`
  (user request: run multi-core after single-core, keep the unmodified
  baseline as reference). Variants: baseline, fold_bn+channels_last,
  inductor. Cores 1, 2, 4, 8, 16, 26 (CPUs 1..N).
* **Hypotheses:** (a) intra-op threading of batch-1 inference scales
  sub-linearly (small layers, per-op synchronisation); (b) independent copies
  scale nearly linearly until shared L3/DRAM interfere.
* **Methodology:** threads: one process, OMP threads bound to CPUs 1..N,
  60 timed inferences, socket IMC CAS around the loop. Instances: N pinned
  single-thread processes, common start, 20 s window, IMC CAS over the window.
  Other users' CPU sampled before/during each configuration from CPU 27;
  configurations re-run if other users exceed one core.
* **Results:** `results/2026-10-06_multicore/processed/MULTICORE.md`
* **Key metrics (OBSERVED; 36/36 configurations clean):** threads at 26
  cores: baseline 15.3 ms (6.5x, 25% efficiency), fold_bn+channels_last 9.9
  ms, inductor 7.6 ms (13x vs baseline on 1 core); scaling flattens after 16
  cores. Instances at 26 cores: baseline 221 inf/s (+19% per-copy latency;
  DRAM per inference 137 -> 408 MB read, 11 -> 171 MB write), inductor 352
  inf/s (+5.4%; 24 MB write per inference).
* **Interpretation (INFERRED):** copies interfere through the shared L3:
  activations spill to DRAM when each copy's L3 share shrinks to ~2 MiB;
  fused (inductor) graphs write far fewer intermediates and barely
  interfere. Thread scaling is not bandwidth-limited (<= 16 GB/s).
* **Problem found and fixed:** the first attempt started 10 s before another
  user's job restarted (the 1-minute load average lags); contention inverted
  thread scaling. Kept as `results/2026-10-06_multicore_CONTENDED/`; the
  launcher now checks instantaneous other-user CPU per configuration.
  The other user's job is itself agent-driven and backed off when it saw
  this run (their log: "joshliu multicore.py running; resume when quiet").

## 2026-10-06 -- E11: follow-ups (Python share; what limits thread scaling)

* **Command:** `scripts/run_followups.sh` (quiet; other users' CPU <= 6%)
* **Results:** `results/2026-10-06_followups/`
* **Key metrics (OBSERVED):** eager 98.63 ms, eager with GC off 98.57 ms
  (0 collections per inference), TorchScript trace of the same ops 97.05 ms
  -> Python layer 1.58 ms / 5.8 M instructions per inference. At 26 threads
  the baseline spends 46% in 1x1 convs (5.9x speedup), 19% in 118 small
  BN/ReLU/add calls (22-26 µs each; ReLU 1.9x), 7% in serial Python between
  operators; layer4 7x7-map 3x3 convs scale only 4.6-4.9x.
* **Interpretation (INFERRED):** batch-1 thread scaling is limited by
  per-call fixed costs and small work items, not by bandwidth.

## 2026-10-06 -- E12: multi-core study with counters; inter-op re-run; cross-core traffic

* **Commands:** `taskset -c 27 .venv/bin/python scripts/mc_study.py --out results/2026-10-06_mc_study --plan membw,intra,split,interop,matrix,batch --variants baseline,inductor`;
  `scripts/run_interop_rerun.sh results/2026-10-06_mc_study/interop_rerun`;
  `experiments/xcore_traffic.py --out results/2026-10-06_mc_study/xcore --configs ...`
  (other users' CPU <= 14% in every window; all counter passes 100% counted)
* **Results:** `results/2026-10-06_mc_study/` (`processed/MC_STUDY.md`,
  `mc_configs.csv`, `split_by_threads.csv`, `interop_rerun/`, `xcore/`);
  `docs/RESULTS.md` section 24.
* **Key metrics (OBSERVED):** DRAM ceiling 18 -> 244 GB/s (1 -> 28 cores).
  One image on 28 threads: 15.4 ms, 61% of busy cycles in the OpenMP
  runtime, DRAM 3% of ceiling; conv kernels scale 17x, re-layout and
  framework do not; all convs move to oneDNN at >= 2 threads. Cross-core
  HitM reads 0 -> 1.38 M per image (54% of on-chip demand reads at 28
  threads). 28 copies: 22.9x (baseline) / 26.2x (inductor); LLC misses and
  DRAM bytes per image 4.3x, L2-miss latency 67 -> 132 ns, 56% of ceiling.
  Operator inter-op: 1.10x dependency bound, reached only without
  `OMP_PROC_BIND` (bound inter-op threads inherit a one-core mask).
  Batch 4 helps 28 threads (1.75x); batch >= 16 hurts everywhere.
* **Interpretation (INFERRED):** threading loses to synchronisation and
  non-scaling work around the convs, plus core-to-core activation transfers;
  copies lose to shared-L3 capacity, which turns into DRAM traffic and loaded
  latency. Neither is limited by DRAM bandwidth.
* **Harness fixes:** inter-op runs no longer bind threads; throughput =
  batch / mean batch latency (window counts were quantized for large batches).

## 2026-10-06 -- E13: Intel VTune Profiler; master bottleneck file

* **Commands:** `scripts/run_vtune.sh results/2026-10-06_vtune` (gated; the
  first one-core attempt was discarded when other users reached 2,682% CPU),
  `analysis/analyze_vtune.py results/2026-10-06_vtune`.
* **Results:** `results/2026-10-06_vtune/processed/` (VTune CSV reports,
  `VTUNE.md`, `tma_by_operator_1t.csv`, `memory_by_operator_1t.csv`,
  `crosscheck_tma_level1.csv`); raw VTune results in `raw_large/` (not
  committed). Master write-up: `docs/BOTTLENECKS.md`.
* **Method notes (OBSERVED):** driverless collection (account not in the
  `vtune` group): no multi-run, TMA events multiplexed; call-stack collection
  lost ~70% of samples in a test, so stacks are off; software sampling needs
  `ptrace_scope=0` (not changed). A 30-inference test gave level-1 sums of
  110%; runs were lengthened to 1,200 / 600 inferences on one core.
* **Key metrics (OBSERVED):** whole-inference TMA level 1 within ~4 points of
  the exact perf measurement; super queue full 48% (add) / 22% (BN); fill
  buffers full 81% (add); oneDNN conv DSB coverage 44% vs MKL 90%; load
  latency add 70 / fc 190 / convs 6-7 cycles; oneDNN weight DRAM reads in the
  re-layout step (102 K of 221 K LLC misses).
* **Interpretation (INFERRED):** one core's streaming bandwidth is capped by
  its miss queues at L1 and L2; the oneDNN front-end cost is code size.
* **28 threads (uarch):** OpenMP runtime 70% PAUSE spin; oneDNN conv kernels
  44% contested accesses, 28% memory-bound; MKL 0.1%. ITT labels cost 10.7% of
  clockticks at 28 threads (median 15.4 -> 21.9 ms). Queue stopped at 18:50
  (disk 95% after the 6.9 GB uarch_28t result); memory_28t and 28-copy runs
  not collected.
