# Session summary and resume point (2026-10-06 ~00:50 UTC)

This file records what is done, what was found, the exact state of the
repository, and the next steps in order. **To resume, start at "Update
2026-10-06 ~18:00 UTC" directly below.**

## Update 2026-10-06 ~18:00 UTC

**Read the user's briefs first:** `docs/briefs/BRIEF_2026-10-05_single_core.md`
(original brief: ROLE, LEVELS 0-7, the 20 RESULTS questions) and
`docs/briefs/BRIEF_2026-10-06_multi_core.md` (multi-core brief + 21-item
PRIORITY list). Priority items 8-10 (actual vs reference, causal explanation)
are specified by the single-core brief's LEVEL 6 CONTROLLED BASELINES and
BASELINE-FIRST METHODOLOGY. `docs/briefs/` is local only (not committed) until
the user says whether their notes may go to GitHub.

Two Claude sessions worked in parallel this afternoon: the "closed" session
(64e3af0f) kept running in the background daemon and committed the
multi-core study (ee2e4af, RESULTS.md section 24); a second session
(d5d4797f) added the inter-op re-run, the cross-core traffic measurement, and
a throughput fix. Check `ListAgents` / `ps` before launching experiments, so
two sessions never measure at once.

Done (all FP32, batch 1 unless stated; RESULTS.md sections 1-24):
* Multi-core study with counters: `results/2026-10-06_mc_study/`
  (`processed/MC_STUDY.md`, `mc_configs.csv`, `split_by_threads.csv`).
* Inter-op re-run with and without `OMP_PROC_BIND` (the bound run inherited a
  one-core mask): `MCS/interop_rerun/`; `scripts/mc_study.py` no longer binds
  the inter-op runs.
* Cross-core HitM traffic per image vs threads: `MCS/xcore/` (RESULTS 24.8).
* Throughput = sum over streams of batch / mean batch latency (fixes batch
  quantization: batch 64 on 1 core is 6.3 img/s, not 5.8).
* Findings document for the user (Claude Docs): "ResNet-50 CPU Bottleneck
  Findings", https://claude.ai/code/artifact/52b8bc6a-52a1-4158-8f15-e973d8320db6

Open, in order of value:
1. BF16 / AMX and INT8 (priority 15-16): would move the bottleneck (AMX raises
   compute peak several-fold, convs may become memory-bound). Needs accuracy
   checks.
2. Why batch 16-64 costs 28-61% more per image on one core (L3-miss stalls
   only 2.5 -> 4.4% of cycles): per-operator split at batch 64.
3. Cost of one cross-core HitM transfer (perf mem on the 28-thread run).
4. SMT (priority 21): supported but off in Linux
   (`/sys/devices/system/cpu/smt/control = off`); enabling needs root on a
   shared machine: the user's decision.
5. VTune / PyTorch source build (priority 19-20): not started.

## Completed

| Milestone | Where | Status |
|---|---|---|
| System discovery (CPU, caches, freq, DIMMs, PMU, toolchain, PyTorch build) | `results/2026-10-05_system/` | done, committed |
| Perf event discovery: 82/82 catalog events count (incl. general-purpose top-down) | `results/perf_events.json` | done |
| In-process `perf_event_open` library + group planner | `cpuinf/perfcounters.py` | done; bugs found and fixed (see RESEARCH_LOG) |
| Native microbenchmarks (compute, latency, bandwidth, intensity, compiler flags) | `results/2026-10-05_microbench/` | done, committed |
| Explicit ResNet-50 (== torchvision, max abs diff 0.0) + layer manifest | `cpuinf/resnet.py`, `cpuinf/manifest.py` | done, committed |
| Level 0 end-to-end latency (+ torchvision / ImageNet-weights / no-counter controls) | `results/2026-10-06_resnet_baseline/processed/e2e_summary_*.json` | done |
| Levels 1-3, 5 per operator: time, core, sw, flops, loads, traffic, stalls, ports, frontend, DRAM; in-model, standalone hot, standalone cold | `results/2026-10-06_resnet_baseline/` (`processed/layer_table.csv`, `REPORT.md`, `plots/`) | done |
| Per-operator top-down re-measured with general-purpose events on a quiet machine | same dir, `raw/inmodel_tdgp.*.csv` | done (contended run kept in `raw/contended_tdgp_run/`) |
| Counter validation on known-answer kernels (quiet) | `results/2026-10-06_counter_validation/` | done; all counters pass |
| Backend path (ATen chain, oneDNN/MKL verbose, symbols), quiet run | `results/2026-10-06_backend_003851/` | done |
| Level 4 instruction profile (perf record + LBR + oneDNN jitdump + annotate of 12 operators + perf mem) | `results/2026-10-06_instruction_profile/` (`processed/INSTRUCTIONS.md`) | done; analysis ran; plot not yet reviewed |
| Docs: EXPERIMENT_GUIDE, HARDWARE_GUIDE, PERF_GUIDE, INTERPRETATION_GUIDE, RESEARCH_LOG (partial) | `docs/` | drafted; RESULTS.md NOT yet written |
| Optimization harness written, not run | `experiments/opt_variants.py`, `experiments/opt_threads.sh`, `scripts/run_optimizations.sh`, `analysis/analyze_opt.py` | ready |
| Dispatch-overhead experiment written, not run | `experiments/dispatch_overhead.py`, `scripts/run_dispatch_overhead.sh`, `analysis/analyze_dispatch.py` | ready |

## Key findings so far (all OBSERVED unless labelled)

**Machine (one core, 2.1 GHz fixed, turbo off):** FMA latency 4 cycles, 2 FMA/cycle
at every width -> peak 63.9 FP32 FLOP/cycle (134 GFLOP/s) with AVX-512; no
AVX-512 frequency drop. Load latency L1 5 / L2 16 / L3 ~63-68 / DRAM ~209
cycles (2 MiB pages; 4 KiB pages add ~57 cycles of page walk at 1 GiB). Read
bandwidth L1 120 / L2 50 / L3 11 / DRAM 8.8 B/cycle (18.5 GB/s; socket
theoretical 307 GB/s CALCULATED). Single-core bandwidth beyond L2 is limited
by misses in flight (INFERRED).

**Level 0:** 98.57 ms median (sd 0.14 ms) for the explicit model; torchvision
98.55 ms; ImageNet weights 98.32 ms; counters off 98.51 ms. IPC 2.30,
0 page faults per steady-state inference, 1 thread. Compute floor at measured
peak: 61.3 ms for 8.22 GFLOP (CALCULATED) -> overall 62% of FMA peak.

**Level 1 (time share):** conv1x1 41.6% (49.3 FLOP/cycle), conv3x3 36.4%
(49.1), maxpool 10.3% (0.075 FLOP/cycle), batchnorm 5.0%, conv7x7 2.2%,
add 2.1%, relu 1.8%, fc+avgpool 0.6%. Stage: layer4 is least efficient
(35.9 FLOP/cycle vs ~48-49 for layer2/3).

**Backend path:** 33 unstrided 1x1 convs -> `aten::thnn_conv2d` ->
`_slow_conv2d_forward` -> **MKL SGEMM** (`mkl_blas_avx512_sgemm_kernel_*`);
3x3, 7x7 and the 3 strided 1x1 convs -> `aten::mkldnn_convolution` ->
**oneDNN JIT** `jit:avx512_core` / `jit_1x1:avx512_core`, with per-call
layout reorders (NCHW <-> nChw16c, and **weights reordered every inference**):
~8.8 ms of reorders per inference (~9%); fc -> MKL `xsgemv` (AVX-512);
BN / ReLU / add / maxpool / avgpool -> ATen native kernels. ReLU, add and
avgpool run the **AVX2 (ymm)** build of ATen kernels although the ATen
capability is AVX512 (symbols `at::native::AVX2::VectorizedLoop2d...`).

**Instruction level:** conv kernels are essentially all zmm (oneDNN JIT
2920/2972 static instructions zmm; MKL kernel zmm). 100% of conv FP
instructions are 512-bit; convs retire 1.42 (3x3) to 1.63 (1x1) zmm FMA per
cycle out of 2; ports 0 and 5 ~0.8 busy; >95% of loads hit L1; stalls 8-10%
of cycles -> **FMA-throughput (core) bound**, ~71-81% of peak. Measured FP ops
of padded 3x3 convs are 0.82x (7x7 maps) / 0.91x (14x14) of the textbook count:
oneDNN skips padding taps ((19/21)^2, (40/42)^2 -- CALCULATED match).

**MaxPool (biggest inefficiency):** `cpu_max_pool<float,false>` (NCHW path)
is scalar: per window element `vmovss` load, `vcomiss`, data-dependent `ja`
(12.3% of samples), `vcvtss2sd`+`vucomisd` for isnan, loop invariants
reloaded from the stack; ~214 instructions and ~1.9 branch mispredicts per
output; top-down 37% bad speculation, 28% frontend; 0 FP_ARITH; loads 99.9%
L1 hits -> neither compute- nor memory-bound: instruction/branch-bound
(10.2 ms for 1.6 M comparisons). It also computes int64 argmax indices that
inference discards.

**Memory:** DRAM reads per inference ~100 MiB net ~= the 97.7 MiB of weights;
DRAM writes ~1.9 MiB -> activations stay on chip, weights stream from DRAM
every inference (INFERRED: weights > 52.5 MiB L3). Only **fc** is
DRAM-bandwidth-bound (7.9 B/cycle ~ 90% of single-core DRAM BW, IPC 0.31,
69% of cycles stalled on L3 misses). layer1 elementwise ops (BN/ReLU/add on
3.2 MB tensors > 2 MiB L2) refill L2 at ~10 B/cycle ~ L3 bandwidth: add is
memory-bound (TMA memory 0.44, MLP 11.5, 54% of cycles stalled on L1D miss).

**Top-down (general-purpose events, slot-weighted, all ops):** Retiring 0.43,
Core bound 0.33, Frontend 0.10, Memory 0.10, Bad spec 0.04.

**Measurement-method findings (important for anyone reusing the tools):**
1. perf-metrics `topdown-*` events give the whole-run average fraction for
   short regions (8-bit cumulative PERF_METRICS); use general-purpose TMA
   events (`tdgp` pass). GP L1 sums: 1.000 +- 0.005 over 175 operators.
2. MEM_LOAD_RETIRED/MEM_INST_RETIRED: max 4 per group; `plan_groups()`
   verifies schedulability (no multiplexing anywhere).
3. A leaked fd from a failed group open + `prctl` enable caused silent
   multiplexing; open uncore events made every start/stop cost ~150K cycles
   of IPIs. Both fixed.
4. `mem_load_retired.l3_miss` undercounts DRAM traffic of streams ~2x (L2
   prefetcher); use `l2_lines_in` / IMC CAS for traffic.
5. kernel.perf_event_max_sample_rate was auto-lowered to 1000/s: sample
   with `-c 2500003` (not changed system-wide).
6. The machine is shared: another user's job (all 28 cores, ~65 GB/s DRAM)
   turned a 16 MiB L3-resident chase into DRAM misses. All measurements now
   go through `scripts/wait_quiet.sh` (load <= 4, DRAM <= 2 GB/s).

## Repository state at hand-off

* Last pushed commit before this summary: 2ec680c. This summary's commit
  adds: docs/, clean tdgp data, counter validation, backend, instruction
  profile (perf.data files in `raw_large/` are git-ignored, ~100 MB, kept
  locally), quiet gate, optimization + dispatch harnesses.
* No background jobs are running. No system settings were changed.

## Update 2026-10-06 ~16:00 UTC (second session)

Done since the hand-off above (commits 7088916, c836940, ae97d8d, a1e7fd6):
dispatch overhead (`results/2026-10-06_dispatch_overhead/`), ISA probe
(`results/2026-10-06_isa_probe/`), single-core optimizations
(`results/2026-10-06_optimizations/`), multi-core scaling at the user's
request with the unmodified baseline always included
(`results/2026-10-06_multicore/`), instruction-profile fixes (perf mem
parsing, plot grouping), `docs/RESULTS.md` sections 1-23, research log
E3-E10. Headline: inductor 70.4 ms on one core (1.43x, 87% of FMA peak);
7.6 ms on 26 cores (threads); 352 inferences/s with 26 independent copies.

## Next steps, in order

All planned experiments are done (follow-ups: `results/2026-10-06_followups/`,
RESULTS.md 22-23.3, research log E11). Optional extensions:

1. Re-run the instruction profile without `-X perf` (interpreter share in a
   normal run; the direct measurement already gives 1.6%).
2. Batch > 1 throughput (weight reuse should cut DRAM per image).
3. BF16/AMX or INT8 variants (outside the FP32 brief; needs accuracy checks).

The original next steps below are complete.

## Original next steps (2026-10-06 00:50, all done)


1. **Dispatch overhead** (not yet run):
   `scripts/wait_quiet.sh && scripts/run_dispatch_overhead.sh`
   then review `results/<date>_dispatch_overhead/processed/DISPATCH.md` and
   `plots/dispatch_overhead.png`.
2. **Review the instruction-mix plot**
   `results/2026-10-06_instruction_profile/plots/instruction_mix_by_operator.png`
   and `processed/INSTRUCTIONS.md` (perf mem section: ldlat=30 samples only
   slow loads; check `raw/mem_by_level.txt`). Confirm from annotations that
   relu/add/avgpool use ymm (AVX2) and that BN's hot loop width is as claimed.
3. **Optimization experiments** (hypotheses grounded in the findings above):
   `SKIP_THREADS=0 scripts/run_optimizations.sh`
   * maxpool_chlast -- vectorized, branch-free channels-last max-pool
     (expect ~10 ms saved; conversion cost to be measured)
   * fold_bn -- removes 53 BN ops (~4.9 ms) and their memory traffic
   * channels_last / mkldnn_layout -- remove oneDNN per-call reorders (~8.8 ms)
   * thread scaling 1..26 threads (separate from the single-core baseline)
   Then re-run the relevant counter passes on the winning variants
   (`experiments/op_profile.py --passes time,core,tdgp,flops,branch...`) and
   check that the change removed the measured bottleneck.
4. **Write `docs/RESULTS.md`** answering the 20 questions from the brief,
   using the findings above and the result directories (every claim with its
   label and file path). Update `docs/RESEARCH_LOG.md` with entries E3-E8
   (counter validation, backend, instruction profile, dispatch, optimizations)
   and fill in the per-operator part of E3.
5. Run `analysis/analyze_resnet.py results/2026-10-06_resnet_baseline` once
   more and review plots 02-09 (only 01, 10, 11, 15, 16 were visually checked).
6. Commit + push each milestone (`git status`, `git diff`, `git log -n 5`
   first; never commit `raw_large/`).
