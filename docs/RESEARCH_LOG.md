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
* (per-operator results: see RESULTS.md, filled from this run)
* Per-operator top-down: the perf-metrics `topdown-*` pass gave the same split
  for every operator (cumulative 8-bit PERF_METRICS fractions); replaced by
  the general-purpose `tdgp` pass. A first `tdgp` run overlapped another
  user's all-core job (load ~26, ~65 GB/s DRAM); re-measured on a quiet
  machine (memory-bound fractions differed by only 0.01-0.02). Contended data
  kept in `raw/contended_tdgp_run/`.

## 2026-10-06 -- E4-E6: counter validation, backend path, instruction profile

* Results: `results/2026-10-06_counter_validation/` (quiet; contended run kept
  as `_CONTENDED` noise example), `results/2026-10-06_backend_003851/`,
  `results/2026-10-06_instruction_profile/`.
* Key metrics and interpretation: see `docs/SESSION_SUMMARY.md` ("Key
  findings"); RESULTS.md to be written from them.
* Method change: every measurement now waits for `scripts/wait_quiet.sh`
  (load <= 4, socket DRAM <= 2 GB/s) because the machine is shared.
* Next: dispatch overhead, optimization experiments, RESULTS.md.
