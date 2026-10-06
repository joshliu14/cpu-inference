# Using `perf` on this machine

A practical guide to hardware performance counters for this project: single-core, batch-1, FP32 ResNet-50
inference in PyTorch on an Intel Xeon Gold 5512U. It assumes you can program and know basic architecture, but are
still learning `perf`.

Every event name here exists on this machine (see [`results/perf_events.md`](../results/perf_events.md) and
`results/2026-10-05_system/raw/perf_list.txt`). Blocks marked **observed** were captured here on 2026-10-06 with
tiny workloads pinned to CPU 20:
- a Python one-liner, or
- `toy`, a 0.2 s C program with an L2-resident float sum (`stream_sum`) and an L3-resident pointer chase (`chase`).

Long output is trimmed with `...`. Labels follow the project convention: OBSERVED / CALCULATED / INFERRED /
UNKNOWN. See also [HARDWARE_GUIDE](HARDWARE_GUIDE.md) (what the hardware units are),
[INTERPRETATION_GUIDE](INTERPRETATION_GUIDE.md) (reading the results) and
[EXPERIMENT_GUIDE](EXPERIMENT_GUIDE.md) (running the experiments).

## Contents

1. [Ground rules for this shared machine](#1-ground-rules-for-this-shared-machine)
2. [The PMU on this machine](#2-the-pmu-on-this-machine)
3. [Counting vs sampling](#3-counting-vs-sampling)
4. [perf stat](#4-perf-stat): event names, groups, multiplexing, constrained events, region of interest
5. [What the counters measure](#5-what-the-counters-measure): cycles/IPC, caches, FLOPs, top-down, uncore
6. [perf record and perf report](#6-perf-record-and-perf-report): sample rate, throttling, skid
7. [perf annotate](#7-perf-annotate)
8. [Call graphs: fp, dwarf, lbr](#8-call-graphs-fp-dwarf-lbr)
9. [perf mem](#9-perf-mem)
10. [Symbol resolution: kernel, Python, oneDNN JIT](#10-symbol-resolution-kernel-python-onednn-jit)
11. [The project's own tools](#11-the-projects-own-tools)
12. [Common mistakes](#12-common-mistakes)
13. [Cheat sheet](#13-cheat-sheet)

---

## 1. Ground rules for this shared machine

- **CPU 6 is for benchmarks** (`BENCH_CPU` in `scripts/common.sh`). When experimenting, pin to another CPU:
  `taskset -c 20 ...`.
- **While a benchmark runs, don't use `perf top`, or `-a` with core events.**
  - `perf stat -a` and `perf record -a` open counters on every CPU, including CPU 6.
  - `perf top` is system-wide by default.
  - Either way, sampling interrupts land on the benchmark's core.
- **Uncore (memory-controller) events are the exception.** They are socket-wide anyway, so `-a` is fine
  (section 5.5). But any DRAM traffic *you* cause shows up in the benchmark's DRAM numbers.
- **Clean up afterwards.**
  - `perf.data` files are gitignored. Write them under `/tmp/<you>/` and delete them when done.
  - `python -X perf` and oneDNN profiling leave `/tmp/perf-<pid>.map` files; delete those too.

## 2. The PMU on this machine

The PMU (performance monitoring unit) is the set of hardware counters in each core. Socket-level units such as the
memory controllers have their own "uncore" PMUs.

| Item | Value | Source |
|---|---|---|
| perf / kernel | perf 6.8.12, Linux 6.8 | `perf --version` |
| Core PMU | `cpu`, `pmu_name=sapphire_rapids` (Emerald Rapids uses the SPR event tables) | `/sys/bus/event_source/devices/cpu/caps/` |
| General-purpose (GP) counters | **8** per core (SMT off) | OBSERVED: `instructions` + 8 GP events fit in one group |
| Fixed counters | `instructions`, `cycles`, `ref-cycles`, `slots` (+ PERF_METRICS register behind `topdown-*`) | Intel SDM |
| NMI watchdog | `nmi_watchdog=1`. A user `cycles` event uses one of the 8 GP counters. | OBSERVED: `{cycles,instructions,`8 GP`}` fails, with 7 GP it works. INFERRED: the watchdog holds the fixed cycles counter. |
| `max_precise` | 3 (so `:P` means `:ppp`) | `caps/max_precise` |
| LBR depth | 32 entries | `caps/branches` |
| `perf_event_paranoid` | -1. Normal users may count the kernel, use `-a` and use uncore PMUs. | sysctl |
| `kptr_restrict` | 1. Kernel symbol addresses are hidden from normal users. | sysctl |
| `perf_event_max_sample_rate` | **1000** samples/s per CPU. Faster sampling is throttled. | sysctl |
| `perf_event_mux_interval_ms` | 1. Multiplexing rotates every 1 ms. | `cpu/perf_event_mux_interval_ms` |
| perf TMA metric tables | **none** for this CPU model | `perf stat -M TopdownL1` fails |
| Core frequency | fixed 2.1 GHz (turbo off); 2.095 GHz OBSERVED during ResNet runs | `results/2026-10-06_resnet_baseline` |
| Issue slots per cycle | 6 | OBSERVED: `slots / cycles = 6.000` |

## 3. Counting vs sampling

| | Counting | Sampling |
|---|---|---|
| Tools | `perf stat`, `cpuinf/perfcounters.py` | `perf record`, `perf mem` (+ `perf report`, `perf annotate`) |
| Mechanism | A counter increments; you read the total at the end | Every N events the counter overflows and interrupts; the kernel records the instruction pointer (+ stack, data address) |
| Answers | *How many* events happened in this window? | *Where* in the code did they happen? |
| Accuracy | Exact, unless multiplexed | Statistical; affected by skid, throttling and sample count |
| Overhead | Tiny (start, stop, read) | Proportional to the sample rate |

Count first, to learn whether the limit is memory, the frontend or FLOPs. Then sample the dominant event to find
the instructions responsible.

---

## 4. perf stat

### 4.1 First run

**observed**
```
$ taskset -c 20 perf stat -e cycles,instructions -- sleep 0.1
         1,043,439      cycles
         1,155,780      instructions                     #    1.11  insn per cycle
       0.100198172 seconds time elapsed
```
This run took 0.1 s of wall time but only ~1M cycles. Counters count only while the task is **on a CPU**, so cycles
measure CPU time, not elapsed time.

Without `-e`, perf uses a default set: task-clock, context-switches, cpu-migrations, page-faults, cycles,
instructions, branches and branch-misses. The `#` column holds metrics that perf derives, e.g. `2.094 GHz` =
cycles / task-clock.

### 4.2 Naming events

| Kind | Examples | Where the name comes from |
|---|---|---|
| Generic hardware | `cycles`, `instructions`, `ref-cycles`, `branches`, `branch-misses`, `cache-references`, `cache-misses` | The kernel maps them to model-specific encodings |
| Kernel PMU (sysfs) | `slots`, `topdown-retiring`, `mem-loads`, `mem-stores` | `/sys/bus/event_source/devices/cpu/events/` |
| perf JSON tables | `mem_load_retired.l3_miss`, `fp_arith_inst_retired.512b_packed_single` | Intel's event list for this model, built into perf |
| Raw | `cpu/event=0xd1,umask=0x20/` (= `mem_load_retired.l3_miss`) | `perf list --details <name>` |
| Uncore | `uncore_imc/cas_count_read/` | `/sys/bus/event_source/devices/uncore_imc_*/events/` |
| Software | `task-clock`, `page-faults`, `context-switches`, `cpu-migrations` | Kernel counters (not PMU counters) |

**Modifiers:** `:u` counts user mode only, and `:k` kernel mode only. `:p`, `:pp`, `:ppp` and `:P` set sampling
precision (section 6.2).

**Finding events:** search with `perf list 'mem_load_retired.*'`, and see encodings with `perf list --details
longest_lat_cache`. Prefer the curated `results/perf_events.md`, where every event was test-counted both by
`perf stat` and in-process. Avoid the generic `L1-dcache-*`, `LLC-*` and `dTLB-*` events: a hidden kernel table
maps them, so you can't easily tell what they count.

### 4.3 Event groups `{...}`

Braces make a **group**, which the kernel schedules atomically: all members are on counters at the same moments,
or none are. Ratios between members of one group (IPC, hit rates, top-down fractions) therefore stay exact, even
when the group as a whole is multiplexed.
```
perf stat -e '{cycles,instructions},{slots,topdown-retiring,topdown-be-bound}' -- CMD
```
- **A group that doesn't fit is not counted at all.** You get `<not counted>` or `<not supported>` for every
  member (section 4.5).
- **Software events use no PMU counters.** They may join a hardware group (`{cycles,instructions,page-faults}`
  worked, OBSERVED). The project's tools put them in a separate group anyway.
- **`topdown-*` events need a group led by `slots`.**
  - `topdown-retiring` alone gives `<not supported>`.
  - For `{topdown-retiring,slots}`, perf 6.8 reorders the group itself and prints
    `WARNING: events were regrouped to match PMUs` (OBSERVED).

### 4.4 Multiplexing and scaling

If you ask for more events than there are counters, the kernel **time-multiplexes**. It rotates which events are on
the hardware (every 1 ms here) and tracks two times per event:
- `time_enabled`: how long the event should have counted.
- `time_running`: how long it was actually on a counter.

`perf stat` then **scales** each count to `raw x time_enabled / time_running`. The trailing `(xx.xx%)` column shows
`time_running / time_enabled`. **No percentage column means 100%, i.e. no multiplexing.**

**observed**, 13 ungrouped events (more than the PMU holds):
```
$ taskset -c 20 perf stat -e cycles,instructions,branches,branch-misses,cache-references,cache-misses,\
l1d.replacement,l2_rqsts.miss,l2_lines_in.all,uops_issued.any,uops_executed.thread,\
mem_inst_retired.all_loads,mem_inst_retired.all_stores -- python3 -c 'sum(range(10**7))'
       383,067,378      cycles                                                    (53.28%)
     2,361,157,575      instructions          #    6.16  insn per cycle           (61.43%)
       ...
       613,938,129      mem_inst_retired.all_loads                                (60.75%)
       349,363,875      mem_inst_retired.all_stores                               (45.56%)
```
A rerun with only 4 events (no multiplexing) gave 596,990,725 loads and 338,754,247 stores. The scaled estimates were
about 3% high; part of that is run-to-run variation, and the two can't be separated. A steady loop like this is the
*best* case. Why multiplexing matters:
- **Scaling assumes uniform behaviour.** A ResNet forward changes operator every fraction of a millisecond. An event
  that counted 45% of the time can have seen a different operator mix than one that counted 61%.
- **Ratios mix time windows.** The IPC above divides `instructions` (61%) by `cycles` (53%).
- **Fixed counters don't protect you.** `instructions` has its own fixed counter, yet ran only 61%. The kernel
  schedules the event list in order and stops at the first event that doesn't fit.
- **Short regions can be missed entirely.** A 0.3 ms operator may never see a given event scheduled.

Two useful options:
- `--no-scale` prints raw counts.
- `-x,` prints CSV with these fields: value, unit, event, running ns, % running, metric, metric unit. With `-r N`, a
  stddev field follows the event name. **observed:**
  ```
  381799162,,cycles,98761083,53.00,,
  2328372170,,instructions,113677456,61.00,6.10,insn per cycle
  ```

**Rule:** a number you publish must come from a run where `time_enabled == time_running`. To get more events, use
more passes (section 11).

### 4.5 Constrained events: "8 counters" is not "any 8 events"

Some events can only use certain counters. On this PMU, the precise memory events `MEM_LOAD_RETIRED.*` and
`MEM_INST_RETIRED.*` allow **at most 4 per group** (OBSERVED). A fifth makes the whole group fail. **observed:**
```
$ taskset -c 20 perf stat -e '{cycles,mem_load_retired.l1_hit,mem_load_retired.l1_miss,\
mem_load_retired.l2_hit,mem_load_retired.l3_hit,mem_load_retired.l3_miss}' -- python3 -c 'sum(range(10**6))'
     <not counted>      cycles
     <not counted>      mem_load_retired.l1_hit
     ...
   <not supported>      mem_load_retired.l3_miss
Some events weren't counted. Try disabling the NMI watchdog:
```
The watchdog hint is generic advice and **misleading here**: turning the watchdog off would not create more
counters that can hold these events. With 4 memory events the command counts normally. The limit is shared across
both families: 2 `mem_inst_retired.*` + 3 `mem_load_retired.*` also fails. In-process, the failure is `EINVAL`
from `perf_event_open`.

Other events have restrictions too: `memory_activity.*`, `cycle_activity.*`, `l1d_pend_miss.*`, and `ocr.*` (there
are only 2 offcore-response registers). These rules are poorly documented, so `cpuinf/perfcounters.py:
plan_groups()` finds groupings **by trial**. It keeps adding events to a group while the group still counts without
multiplexing, and starts a new pass when it doesn't.

Counter budget, OBSERVED:

| Events | Result |
|---|---|
| `instructions` + 8 plain GP events | fits |
| `cycles` + `instructions` + 8 GP events | `<not counted>`: `cycles` takes a GP counter here |
| `{cycles,instructions,`7 GP`}` + `{slots,`8 `topdown-*}` (18 events) | all at 100%; `slots`/`topdown-*` use no GP counters |

### 4.6 Repeats, intervals, user vs kernel

`-r N` repeats the command and reports mean +/- stddev. `:u` and `:k` split user from kernel mode. **observed**, on
a run that touches 16 MiB of fresh memory:
```
$ taskset -c 20 perf stat -r 5 -e cycles:u,cycles:k,instructions:u,instructions:k,page-faults \
    -- python3 -c 'x=b"\1"*(16<<20)'
        41,239,718      cycles:u                         ( +-  0.43% )
        18,261,273      cycles:k                         ( +-  3.95% )
        55,854,712      instructions:u   #  1.35  insn per cycle   ( +-  0.04% )
        32,389,866      instructions:k   #  1.77  insn per cycle   ( +-  0.35% )
             5,185      page-faults                      ( +-  0.01% )
```
30% of the cycles were kernel time, mostly page faults (INFERRED from the 5,185 faults). Plain `cycles` counts both
modes here (`perf_event_paranoid=-1`).

`-I <ms>` prints counts at a fixed interval, which exposes phases. **observed** (`toy`, reformatted to one line per
interval; the phase labels are INFERRED):
```
$ taskset -c 20 perf stat -I 40 -e cycles,instructions,mem_load_retired.l2_miss -- ./toy
  0.040   90,301,249 cycles   46,445,620 instr  # 0.51 IPC   797,022 l2_miss  (init + shuffle)
  0.080   83,914,738 cycles    4,721,746 instr  # 0.06 IPC   993,477 l2_miss  (pointer chase)
  0.160   83,915,262 cycles   73,535,164 instr  # 0.88 IPC       327 l2_miss  (L2-resident sum)
```

### 4.7 Counting only a region of interest

`perf stat CMD` counts the **whole process**, start-up, imports and setup included. Python start-up alone
(`python3 -c pass`) costs 42.5M cycles and 64.6M instructions (OBSERVED). A ResNet run
(`experiments/e2e_latency.py`) spends 2.37 s on imports, 0.17 s building the model, 0.30 s on weights and 2.99 s
warming up, while one inference takes 0.0986 s.

`perf stat` can instead start with counters disabled (`-D -1`) and be toggled through a FIFO. **observed:**
```python
# roi.py
def ctl(cmd):
    with open("ctl.fifo", "w") as f: f.write(cmd + "\n")
    with open("ack.fifo") as f: f.read(5)
x = [i * i for i in range(300_000)]   # setup: not counted
ctl("enable"); s = sum(x); ctl("disable")
```
```
$ mkfifo ctl.fifo ack.fifo
$ taskset -c 20 perf stat -D -1 --control fifo:ctl.fifo,ack.fifo -e cycles,instructions -- python3 roi.py
Events disabled
Events enabled
Events disabled
         5,139,204      cycles
        30,631,894      instructions                     #    5.96  insn per cycle
```
Each toggle is a round trip through the `perf` process, so this suits coarse regions such as a whole forward pass.
For **individual operators**, use the in-process counters (section 11.3). Note that `roi.py` blocks forever if
`perf` isn't reading the FIFOs.

---

## 5. What the counters measure

A counter measures exactly one micro-architectural condition. Most mistakes come from assuming it measures something
more convenient. The "often assumed" columns below list those assumptions.

### 5.1 cycles, ref-cycles, instructions, IPC, CPI

| Event | Measures | Often assumed | Notes |
|---|---|---|---|
| `cycles` | Core clock cycles while this thread runs and the core is not halted | Wall time | cycles / 2.1e9 = CPU seconds, only at a fixed frequency. Blocked or descheduled time is not counted. |
| `ref-cycles` | Same interval at the constant TSC rate (2.1 GHz) | — | Frequency = cycles / ref-cycles x 2.1 GHz. Use it to *verify* the frequency was fixed. |
| `instructions` | Retired (architecturally completed) instructions | "Work", or uops | One AVX-512 FMA (32 FLOPs) and one interpreter dispatch (~0 FLOPs) both count as one instruction |
| IPC = instructions / cycles | Retirement rate | Efficiency | A macro-fused `cmp`+`jcc` is 2 instructions but 1 uop, so IPC can exceed the 6-wide allocation. `python3 -c 'sum(range(10**7))'` ran at **IPC 6.09** (OBSERVED) while doing little useful work. |
| CPI = cycles / instructions | Inverse of IPC | — | Handy when summing cost per instruction class |

Cross-check from `results/2026-10-06_resnet_baseline/processed/e2e_summary_explicit.json`: median 98.57 ms per
inference, 206.45M cycles, 475.2M instructions, IPC 2.30, and 2.095 GHz from cycles/ref-cycles. CALCULATED:
206.45M / 2.095 GHz = 98.56 ms, which matches.

### 5.2 Cache and memory events

| Event | Measures | Often assumed | Caveats |
|---|---|---|---|
| `cache-references` | **`LONGEST_LAT_CACHE.REFERENCE`** (`event=0x2e,umask=0x4f`): core-originated cacheable requests that look up **L3**. That is, requests that missed L1+L2: loads, RFOs (stores), code fetches and L1/L2 HW prefetches. HW prefetches *into* L3 are excluded. | "All cache accesses" | In 4 OBSERVED runs it exactly equalled `l2_rqsts.miss` (e.g. 339,268 = 339,268) |
| `cache-misses` | **`LONGEST_LAT_CACHE.MISS`** (`0x2e/0x41`): those L3 lookups that missed | "Demand loads that went to DRAM and stalled me" | Includes prefetches, stores, and misses the core never waited for. perf's "% of all cache refs" is the **L3** miss ratio. |
| `mem_load_retired.{l1_hit,fb_hit,l2_hit,l3_hit,l3_miss}` | **Retired load instructions**, by the level that supplied the data | Bytes or lines moved | Counted per *instruction* (a zmm load = 1). Demand loads only: no prefetches, stores or wrong-path loads. `fb_hit` = line already in flight. `l3_miss` is the strongest per-thread evidence that a *demand* load went past L3. Precise (PEBS); max 4 per group. |
| `mem_inst_retired.all_loads/all_stores` | Retired load / store instructions | — | Denominator for hit fractions. Same 4-per-group limit. |
| `l1d.replacement`, `l2_lines_in.all` | Lines filled into L1D / L2 (demand + prefetch) | — | x 64 B = bytes into L1D / L2 |
| `l2_lines_out.non_silent` | Modified lines evicted from L2 | — | x 64 B ≈ write-back traffic |
| `l2_rqsts.all_hwpf` | L2 hardware-prefetch requests | — | How prefetch-driven the traffic is |
| `ocr.demand_data_rd.dram` / `ocr.reads_to_core.dram` | This thread's demand reads / all reads (incl. prefetch) served by DRAM | All DRAM traffic | Reads only. x 64 B = per-thread DRAM read bytes. Uses the 2 offcore-response registers. |
| `memory_activity.stalls_l3_miss` | Cycles stalled **while** an L3-miss demand load was outstanding | "Cycles lost to DRAM" | Coincidence, not cause; an upper bound |
| `l1d_pend_miss.pending` / `.pending_cycles` | Sum over cycles of outstanding L1D misses / cycles with at least one | — | The ratio is memory-level parallelism |
| `uncore_imc/cas_count_read/` | DRAM read bursts for the **whole socket** | "My process's DRAM reads" | Section 5.5 |

**A counted miss is not a suffered stall.** Prefetchers turn would-be misses into hits or `fb_hit`s.
Out-of-order execution hides latency. `cache-misses` includes prefetch traffic the core never waited for. To claim
"this operator is DRAM-latency bound", you need both:
- `mem_load_retired.l3_miss` and/or `memory_activity.stalls_l3_miss`, and
- a top-down Memory Bound fraction that agrees.

### 5.3 FLOPs

`FP_ARITH_INST_RETIRED.*` counts retired FP arithmetic instructions (ADD, SUB, MUL, DIV, MIN, MAX, SQRT, RCP14,
RSQRT14, FMA) at their vector width. **FMA counts twice.** OBSERVED with an inline-asm loop of 4M zmm instructions:
```
add: 4000000  fp_arith_inst_retired.512b_packed_single:u   (4M vaddps)
fma: 8000000  fp_arith_inst_retired.512b_packed_single:u   (4M vfmadd231ps)
```
```
FLOPs (FP32) = scalar_single + 4 x 128b_packed_single + 8 x 256b_packed_single + 16 x 512b_packed_single
```
`cpuinf/metrics.py: derive()` computes this as `flops_measured`.

Padding lanes are counted, because they are computed. Loads, shuffles, conversions, int8/bf16 dot products and AMX
are not. In FP32 inference, `fp_scalar_double`, `fp_512_double` and `exe.amx_busy` should be near 0.

Compare against the CALCULATED FLOPs in `cpuinf/manifest.py`. More than calculated means extra work, such as
padding. Less means an algorithmic shortcut, such as Winograd. The OBSERVED peak is 63.86 FLOP/cycle
(`results/2026-10-05_microbench/processed/machine_model.json`).

### 5.4 Top-down (TMA) without perf's metric tables

Top-down analysis splits the core's **issue slots** (6 per cycle here) into four level-1 categories that sum to 1:
- **Retiring:** the slot's uop retired (useful work).
- **Bad Speculation:** the uop was thrown away.
- **Frontend Bound:** no uop was delivered, though the backend could take one.
- **Backend Bound:** the backend was full, so no uop could issue.

perf 6.8 has **no TMA formulas for this CPU model** (OBSERVED):
```
$ perf stat -M TopdownL1 -- true
Cannot find metric or group `TopdownL1'
$ perf stat --topdown -- true
Topdown requested but the topdown metric groups aren't present.
```
The hardware events still work. Put them in one group led by `slots` and compute `event / slots` yourself.
**observed:**
```
$ taskset -c 20 perf stat -e '{slots,topdown-retiring,topdown-bad-spec,topdown-fe-bound,topdown-be-bound,\
topdown-heavy-ops,topdown-br-mispredict,topdown-fetch-lat,topdown-mem-bound}' -- python3 -c 'sum(range(10**6))'
       456,430,632      slots
       264,908,758      topdown-retiring
        60,857,417      topdown-bad-spec
        93,076,050      topdown-fe-bound
        39,378,329      topdown-be-bound
        12,529,468      topdown-heavy-ops
        60,857,417      topdown-br-mispredict
        50,117,873      topdown-fetch-lat
        21,479,088      topdown-mem-bound
```
| Level 1 | = | Value | Level 2 split | = | Values |
|---|---|---|---|---|---|
| Retiring | retiring / slots | 58.0% | Heavy / Light ops | heavy-ops / slots; (retiring - heavy-ops) / slots | 2.7% / 55.3% |
| Bad Speculation | bad-spec / slots | 13.3% | Branch mispredicts / Machine clears | br-mispredict / slots; (bad-spec - br-mispredict) / slots | 13.3% / 0.0% |
| Frontend Bound | fe-bound / slots | 20.4% | Fetch latency / Fetch bandwidth | fetch-lat / slots; (fe-bound - fetch-lat) / slots | 11.0% / 9.4% |
| Backend Bound | be-bound / slots | 8.6% | Memory / Core bound | mem-bound / slots; (be-bound - mem-bound) / slots | 4.7% / 3.9% |

The values are CALCULATED from the output above. `cpuinf/metrics.py` computes the same quantities, clipping negative
differences at 0. Some properties of these events:
- **`slots` = 6 x `cycles`** on this core (OBSERVED: 449,438,442 / 74,906,407 = 6.000).
- **Each fraction is stored in 8 bits.** The kernel derives `topdown-*` from the `slots` fixed counter and the
  PERF_METRICS register, which holds 8 bits per fraction. Level 1 therefore sums to `slots` only within about 1%.
  Above, every fraction is a multiple of 1/255 (148 + 34 + 52 + 22 = 256), giving 100.4%.
- **They cost no GP counters.** A full top-down group can run alongside 8 GP events.

**Don't difference `topdown-*` reads around a short region.** These events are fine for whole-process `perf stat`,
but not for in-process start/stop deltas:
- OBSERVED in the control run's `inmodel_topdown.csv` (see [INTERPRETATION_GUIDE](INTERPRETATION_GUIDE.md)):
  in-process deltas gave nearly the same split, ~0.41 / 0.14 / 0.16 / 0.34, for *every* ResNet operator. That includes convolutions near 50 FLOP/cycle and `fc`
  at IPC ~0.3. The level-1 sums ranged from 0.71 to 1.56.
- INFERRED cause (`cpuinf/events.py`): PERF_METRICS holds 8-bit fractions accumulated since the hardware was last
  reset. A delta is therefore (delta slots) x (cumulative average fraction), not the region's own fraction.

**Per region, use the general-purpose (GP) top-down events instead** (the `tdgp` pass, Intel's TMA formulas,
implemented in `cpuinf/metrics.py`):
```
slots         = topdown.slots_p
Retiring      = uops_retired.slots / slots              Heavy = uops_retired.heavy / slots;  Light = Retiring - Heavy
Bad Spec      = topdown.bad_spec_slots / slots          Branch mispredicts = topdown.br_mispredict_slots / slots
Frontend      = (idq_bubbles.core - int_misc.uop_dropping) / slots
Fetch latency = (6 x idq_bubbles.cycles_0_uops_deliv.core - int_misc.uop_dropping) / slots
Backend       = topdown.backend_bound_slots / slots     Memory Bound = topdown.memory_bound_slots / slots
```
Machine clears, fetch bandwidth and core bound are the differences, as in the table above. These 10 events need
two runs:
- As one group: `<not counted>`.
- As two groups in one `perf stat`: each group multiplexed at ~50% (OBSERVED).
- As two runs, via `perfwrap.py --passes tdgp` on the same one-liner (OBSERVED): Retiring 57.7%, Bad Spec 13.5%,
  Frontend 20.8%, Backend 8.3%, level-1 sum 1.003. That agrees with the whole-process PERF_METRICS numbers above.

**Comparing with VTune or `toplev`:** official TMA normalizes by the sum of the four level-1 events and applies the
`int_misc.uop_dropping` correction. The plain `event / slots` version doesn't, so don't compare to the second
decimal.

**Retiring is not efficiency.** The Python interpreter above is 58% Retiring at IPC 3.8 while doing almost no
arithmetic. Conversely (INFERRED), an AVX-512 GEMM loop at peak FLOP rate issues about 2 FMA uops plus a little
overhead per cycle. That is roughly 35-50% of the 6 slots; the rest appears as **Core Bound**, because the FMA ports
are saturated. Always read top-down together with FLOPs per cycle.

### 5.5 Uncore: DRAM traffic from the memory controllers

The 8 memory-controller PMUs (`uncore_imc_0..7`) count DRAM CAS commands. Each CAS moves one 64-byte line, and perf
scales the count to MiB (`cas_count_read.scale = 6.103515625e-5` MiB = 64 B). **observed**, with a benchmark running
on CPU 6:
```
$ perf stat -a -e uncore_imc/cas_count_read/,uncore_imc/cas_count_write/ -- sleep 0.5
             66.40 MiB  uncore_imc/cas_count_read/
             33.09 MiB  uncore_imc/cas_count_write/
```
- **The counts are socket-wide.** They include every core, every user, the kernel and devices. Uncore events cannot
  attach to a process. perf 6.8 printed `system wide` even without `-a`; pass `-a` anyway so this is obvious.
- **Background traffic is real.** At idle it was about 62 MiB/s read and 43 MiB/s write
  (`results/2026-10-05_system/SYSTEM.md`); above, with one benchmark running, about 133 MiB/s read.
  `experiments/op_profile.py` measures 2 s of background before its `dram` pass. Subtract it, and trust only
  per-operator values much larger than background x duration. CALCULATED: 100 MiB/s over a 2 ms convolution is
  about 0.2 MB.
- **Per-thread alternatives:** `ocr.reads_to_core.dram` and `mem_load_retired.l3_miss`. They are attributable to
  your thread, but count reads only.
- **Multiplexing check for uncore reads.** `UncoreCounters` now opens each IMC instance with
  `time_enabled`/`time_running` and raises an error if any instance was multiplexed, because socket-wide counts
  cannot be scaled reliably over short intervals. Each channel has only a few counters, so still avoid running
  other IMC measurements (including `perf stat -a -e uncore_imc/...`) during a `dram` pass.

---

## 6. perf record and perf report

### 6.1 Sampling basics, -F vs -c, and the 1000 Hz limit

**observed** (the default event is `cycles:P`):
```
$ taskset -c 20 perf record -o /tmp/me/toy.data -- ./toy
Lowering default frequency rate from 4000 to 1000.
Please consider tweaking /proc/sys/kernel/perf_event_max_sample_rate.
$ perf report -i /tmp/me/toy.data --stdio
# Samples: 201  of event 'cycles:P'
    47.26%  toy      toy               [.] stream_sum
    44.77%  toy      toy               [.] chase
     3.98%  toy      libc.so.6         [.] random
     0.52%  toy      [unknown]         [k] 0xffffffffabc25374
```
- **`-F <Hz>` (frequency mode)** adjusts the period to hit a target number of samples per second of CPU time.
- **`-c <N>` (period mode)** takes one sample every N events. Use it when `samples x N` must mean something. Pick
  odd or prime-ish periods (2000003, 20011) so samples don't line up with loop trip counts.
- **The cap is 1000 samples/s per CPU; above it the kernel throttles.** **observed** with `-c 1000003`, which is
  about 2100 samples/s at 2.1 GHz:
  ```
  $ perf report -i toy2.data --stats  ->  THROTTLE events: 201   SAMPLE events: 201
  # Event count (approx.): 201000603        <- 201 samples x 1000003
  $ perf stat -e cycles -- ./toy           ->  418,977,025 cycles (the true count)
  ```
  The percentages stayed usable, but "Event count" was **half** the truth. Use `-F 999` or less, or for `cycles`
  a `-c` of at least about 2.1M.
- **Any event can be sampled.** **observed** example: which code produced the L2-miss loads?
  ```
  $ taskset -c 20 perf record -e mem_load_retired.l2_miss:pp -c 20011 -o l2m.data -- ./toy
  # Samples: 117  of event 'mem_load_retired.l2_miss:pp'
      94.87%  [.] chase
       5.13%  [.] main
  ```
  JSON events carry a default period, used when neither `-c` nor `-F` is given (`period=0x186a3` = 100003 in
  `perf list --details`).

### 6.2 Skid and precise modifiers

The overflow interrupt arrives some instructions after the event, and the sample blames whatever instruction is
current at that moment. That is **skid**. With PEBS (Precise Event-Based Sampling), the hardware records the state
itself, avoiding it.

| Modifier | `precise_ip` | Meaning |
|---|---|---|
| none | 0 | Interrupt-based; skids |
| `:p` | 1 | PEBS, but reports the **next** instruction (off by one) |
| `:pp` | 2 | PEBS with the exact eventing IP: the right instruction |
| `:ppp` | 3 | Most precise mode (also reduces sampling-distribution bias where supported) |
| `:P` | max (= 3 here) | "As precise as possible"; the `perf record` default |

**observed**: where `perf annotate` puts `cycles` samples in the pointer chase `p = next[p]`. The loop is unrolled
twice, with its loads at `12f0` and `12f8`:
```
cycles      (precise_ip 0)   47.75  12f4: add $0x2,%rdx       52.25  12fc: cmp %rdx,%rdi
cycles:p    (precise_ip 1)   47.29  12f4: add $0x2,%rdx       52.71  12fc: cmp %rdx,%rdi
cycles:pp   (precise_ip 2)   51.69  12f0: mov (%rcx,%rax,8)   46.12  12f8: mov (%rcx,%rax,8)
cycles:ppp  (precise_ip 3)   41.69  12f0: mov (%rcx,%rax,8)   58.31  12f8: mov (%rcx,%rax,8)
```
Without `:pp`, every sample landed on the instruction *after* the slow load. In a real kernel, that would send you
looking at an `add` instead of the L3-missing `mov`.

The kernel also accepted `:pp` on `l1d.replacement`, which `perf list` does not tag "(Precise event)". INFERRED:
this core can PEBS-sample any GP event. The tag still matters for data-address sampling (`perf mem`).

### 6.3 Reading perf report

| Option | Use |
|---|---|
| `--stdio` | Plain text instead of the TUI |
| `--sort sym` / `--sort dso,sym` | Group by function, or by library and function |
| `--no-children` / `--children` | Self time, or self + callees (needs a call graph) |
| `-S <sym>`, `--percent-limit 1` | Focus on one symbol / hide noise |
| `-G` (= `-g caller`) | Call chains, caller first |
| `--stats` | SAMPLE / THROTTLE / LOST record counts; check before trusting a profile |
| `--header-only` | Recorded command, CPU and events |

"Overhead" is the share of the **sampled event** (cycles, unless you chose another). `[.]` marks user code and `[k]`
kernel code. With fewer than about 1000 samples in a symbol, its percentage is visibly noisy.

---

## 7. perf annotate

`perf annotate` maps samples to instructions, and interleaves source lines if the binary has debug info (`-g`).
**observed** (`cycles:P`, 95 samples in this function, built with `gcc -O2 -g -fno-omit-frame-pointer`):
```
$ perf annotate -i ann.data --stdio -s stream_sum
         : 21   for (int i = 0; i < NSUM; i++) s += a[i];
    0.00 :   1287:   lea    0x402db2(%rip),%rax        # 404040 <a>
   17.90 :   1290:   addss  (%rax),%xmm0
    0.00 :   1294:   add    $0x10,%rax
   28.43 :   1298:   addss  -0xc(%rax),%xmm0
   18.95 :   129d:   addss  -0x8(%rax),%xmm0
   22.08 :   12a2:   addss  -0x4(%rax),%xmm0
    0.00 :   12a7:   cmp    %rdx,%rax
   12.63 :   12aa:   jne    1290 <stream_sum+0x20>
```
How to read it:
- **Percentages are relative to the function**, not the whole program.
- **This loop is latency-bound.** The samples sit on 4 scalar `addss` instructions forming one dependency chain
  through `%xmm0`, so each waits for the previous one. It is not memory-bound; the microbenchmarks OBSERVED a
  scalar FP add latency of 2 cycles.
- **Record with `:pp` or `:P`**, or every sample sits one instruction late.
- **oneDNN JIT kernels need their code bytes** before perf can annotate them, which takes a jitdump
  (section 10.3).

---

## 8. Call graphs: fp, dwarf, lbr

| Mode | How it unwinds | Needs | Size (OBSERVED, same 0.2 s run) | Limits |
|---|---|---|---|---|
| `--call-graph fp` (`-g`) | Follows the `%rbp` frame-pointer chain | Frame pointers in every frame | 76 KB | A frame without a pointer breaks or skips the chain |
| `--call-graph dwarf[,size]` | Copies 8 KB of user stack per sample, unwinds offline using DWARF CFI | Unwind info for every function | 1760 KB (23x) | Big files and slow reports. Truncates at the copied size. JIT code has no CFI. |
| `--call-graph lbr` | Hardware Last Branch Record, call-stack mode | Intel, user space | 100 KB | **32 frames deep** here; needs neither frame pointers nor CFI |

**observed**, samples in `chase` (which `main` calls):
```
fp:     _start -> __libc_start_main -> 0x728780c2a1ca -> chase          (main is missing)
dwarf:  _start -> __libc_start_main -> 0x737f1402a1c9 -> main -> chase
lbr:    _start -> __libc_start_main -> 0x7b9be3c2a1c8 -> main -> chase
```
Despite `-fno-omit-frame-pointer`, GCC built the leaf `chase` without a frame setup, so the fp unwinder skipped its
caller. For PyTorch:
- **fp works through the interpreter.** The system Python 3.12 (which `.venv` uses) keeps frame pointers
  (section 10.2).
- **If stacks stop or jump inside `libtorch_cpu.so` or MKL**, switch to `--call-graph dwarf,16384` or `lbr`.
  Whether the PyTorch wheels keep frame pointers was not verified.
- **`lbr` is the best bet through JIT kernels**, because it needs no unwind info. But 32 frames truncate deep
  Python + PyTorch stacks.

---

## 9. perf mem

`perf mem` samples memory instructions with their **data address**, **data source** (L1, fill buffer, L2, L3, DRAM)
and **latency in cycles**. On this PMU, `perf mem record` sets up two kinds of event (OBSERVED with `perf evlist`):
- loads: `cpu/mem-loads,ldlat=30/`, led by `cpu/mem-loads-aux/`
- stores: `cpu/mem-stores/P`

Only loads taking **≥ 30 cycles** are sampled, so most L1/L2 hits are deliberately invisible. **observed:**
```
$ taskset -c 20 perf mem -t load record --ldlat=30 -o mem2.data -- ./toy
$ perf mem report -i mem2.data --stdio --sort=mem,sym
# Samples: 113  of event 'cpu/mem-loads,ldlat=30/'
# Total weight : 6197
    88.98%            92  L3 hit                                   [.] chase
     6.31%             2  RAM hit                                  [.] main
```
With the default sort, the per-sample latency of the `chase` loads ("L3 hit") was 70-80 cycles. That matches the
OBSERVED L3 latency of 63-79 cycles in `machine_model.json`.

Reading and using the report:
- **"Overhead" is weighted by latency**, not by sample count.
- **Ignore the `mem-loads-aux` samples**; they are group bookkeeping.
- **Useful sort keys:** `--sort=mem,sym`, `--sort=sym,symbol_daddr` (which data object), `--sort=tlb`,
  `--sort=snoop`.
- **`perf mem` shows which loads are slow, not what they cost**, because out-of-order execution overlaps them. Pair
  it with `memory_activity.stalls_*` and top-down Memory Bound.

---

## 10. Symbol resolution: kernel, Python, oneDNN JIT

### 10.1 Kernel symbols (`kptr_restrict=1`)

Normal users can't read kernel addresses, so kernel samples show up as raw addresses:
```
WARNING: Kernel address maps (/proc/{kallsyms,modules}) are restricted,
check /proc/sys/kernel/kptr_restrict and /proc/sys/kernel/perf_event_paranoid.
     0.52%  toy      [unknown]         [k] 0xffffffffabc25374
```
Counting is unaffected: `cycles:k` still counts kernel time, and only the names are missing. Your options:
- **Exclude the kernel:** `-e cycles:u` or `perf record --all-user`.
- **Measure the kernel's share:** `perf report --sort dso`.
- **Get names:** this account has passwordless sudo (`docs/RESEARCH_LOG.md`), so `sudo perf report -i FILE`
  should resolve the recorded kernel addresses. That is UNKNOWN; it was not tried. Don't change `kptr_restrict` on
  a shared machine.

### 10.2 Python frames: `python -X perf`

Without help, every Python function shows up as `_PyEval_EvalFrameDefault`. With `-X perf` (or
`PYTHONPERFSUPPORT=1`), Python 3.12 emits a small trampoline per Python function and writes `/tmp/perf-<pid>.map`.
`perf report` reads that map automatically. **observed** (fp call graphs):
```
$ taskset -c 20 perf record -F 999 -g -o py.data -- python3 -X perf pyloop.py
$ perf report -i py.data --stdio --no-children -G
   PyEval_EvalCode
   py::<module>:/tmp/.../pyloop.py
   _PyEval_EvalFrameDefault
   py::outer:/tmp/.../pyloop.py
   ...
   py::inner:/tmp/.../pyloop.py
```
Without `-X perf`, the same stack shows only `PyEval_EvalCode -> _PyEval_EvalFrameDefault -> PyObject_Vectorcall ->
...`. Delete the map files afterwards.

### 10.3 oneDNN JIT kernels (`ONEDNN_JIT_PROFILE` + `perf inject --jit`)

PyTorch's FP32 convolutions run oneDNN kernels that are generated at run time in anonymous memory. Without help,
`perf report` shows only hex addresses for exactly the code you care about most. oneDNN can describe its kernels to
perf:

| `ONEDNN_JIT_PROFILE` | Effect |
|---|---|
| `2` | Writes `/tmp/perf-<pid>.map`: names only (`report` works, `annotate` doesn't) |
| `6` | Perf map + **jitdump** with code bytes (`annotate` works after `perf inject --jit`) |
| `14` | As 6, with TSC timestamps |

```
ONEDNN_JIT_PROFILE=6 taskset -c 20 perf record -k 1 -g -o /tmp/me/r.data -- .venv/bin/python SCRIPT
perf inject --jit -i /tmp/me/r.data -o /tmp/me/r.jit.data
perf report -i /tmp/me/r.jit.data --stdio --sort dso,sym
perf annotate -i /tmp/me/r.jit.data --stdio -s JIT_SYMBOL
```
`-k 1` records with `CLOCK_MONOTONIC`, so the jitdump timestamps line up with the samples. The jitdump goes to
`ONEDNN_JIT_PROFDUMP_DIR`, else `$JITDUMPDIR`, else `$HOME/.debug/jit/`. `perf inject` writes one small
`jitted-<pid>-N.so` per kernel; delete them afterwards.

**This workflow is not verified on this machine (it needs a PyTorch run).** Before trusting a profile, check that
`perf report` shows named oneDNN kernels rather than bare addresses.
- `ONEDNN_VERBOSE=1` independently lists which implementation ran for each primitive.
- `cpuinf/runtime.py: environment_record()` stores both variables with every result.
- These modes add overhead, so don't time with them on.
- Python's `-X perf` and mode 2 both write `/tmp/perf-<pid>.map`; whether both sets of symbols survive is untested.
  Prefer mode 6.

---

## 11. The project's own tools

### 11.1 `scripts/discover_perf_events.py`

`cpuinf/events.py: CATALOG` gives each key some candidate event names and an interpretation. For each candidate, the
script:
1. Resolves the name to an encoding (generic, sysfs or perf JSON).
2. Test-counts it with `perf stat` (top-down events inside a `slots` group).
3. Test-opens it in-process with `perf_event_open`.

The first candidate that passes both tests goes into `results/perf_events.json`/`.md`. Failures are recorded as
`UNAVAILABLE`, never as 0. The unavailable `perf stat -M TopdownL1` is recorded too. Measurement scripts use only
events marked `supported`.
```
taskset -c 20 .venv/bin/python scripts/discover_perf_events.py
```
Rerun it after a kernel or perf upgrade, or after adding a catalog entry. Its test workloads inherit the `taskset`
affinity.

### 11.2 `scripts/perfwrap.py`: multi-pass `perf stat` for whole commands

Use it for native programs, such as the microbenchmarks, where counting the whole process is what you want. It runs
the command once per **pass** in `cpuinf/events.py: PASSES`, each with `--repeat N`, pinned with `taskset`:
```
taskset -c 20 .venv/bin/python scripts/perfwrap.py --cpu 20 --repeat 3 --passes core,topdown,flops,loads \
    --out /tmp/me/pw -- ./microbench/bin/compute fma512
```
A pass that doesn't fit in one group is split with `plan_groups()` into sub-runs, written as
`perfstat_<pass>.0.csv`, `perfstat_<pass>.1.csv`, and so on. The full output in `--out` is:
- `perfstat_<pass>[.N].csv` (raw perf CSV) and `stdout_<pass>[.N].txt`.
- `perf_summary.json`, containing `counts_mean`, `derived` (IPC, frequency, TMA fractions, FLOPs, ... from
  `cpuinf/metrics.py`) and `per_pass_info` (stddev and `pct_running` per event).

OBSERVED on 2026-10-06 with a trivial workload: `loads`, `tdgp` and `stalls` each split into 2 sub-runs, and every
event counted at 100%. (An earlier version ran each pass as one group, and those passes came back `<not counted>`.)

Caveats:
- **Pin `perfwrap.py` itself.** `plan_groups()` trial-opens the counters in perfwrap's own process, as shown in the
  command above.
- **Sub-runs are separate executions.** A ratio between events in different sub-runs (e.g. `tdgp.0` vs `tdgp.1`)
  compares two runs of the command. That's fine for deterministic programs; it is not the same as one group.
- **Use `--repeat 2` or more.** With `-r 1`, perf omits the stddev CSV field, the columns shift, and `pct_running`
  is parsed as empty (OBSERVED).

### 11.3 `cpuinf/perfcounters.py`: in-process counters around one operator

`perf stat python script.py` can't tell you how many cycles `layer3.2.conv2` took. It mixes start-up, imports, model
construction and every other operator. `perfcounters.py` instead calls the `perf_event_open` syscall through
`ctypes`, so Python code can start and stop counters around any region:
```python
from cpuinf import runtime                 # import before torch: sets OMP/MKL threads = 1
runtime.pin(6)
torch = runtime.configure_torch()          # 1 thread, autograd off
from cpuinf.perfcounters import CounterSession

with CounterSession(["cycles", "instructions", "fp_arith_inst_retired.512b_packed_single"]) as cs:
    cs.start(); y = conv(x); c = cs.stop()   # {"cycles": ..., ..., "_multiplexed": False}
    assert not c["_multiplexed"]
```
How it works:
- **Name resolution follows perf's rules.** Generic events map to `PERF_TYPE_HARDWARE`/`SOFTWARE`. sysfs events come
  from `/sys/bus/event_source/devices/cpu/events`. JSON events use their encoding from `perf list --details`, packed
  with the PMU's `format/` bit layout.
- **Counting is per thread** (`pid=0, cpu=-1`): only the calling thread is counted, wherever it runs. This is one
  reason the runtime forces 1 thread.
- **Groups are split automatically.** `split_into_groups()` separates `slots`+`topdown-*`, other hardware events,
  and software events. Each group is read with `PERF_FORMAT_GROUP | TOTAL_TIME_ENABLED | TOTAL_TIME_RUNNING`.
  `_multiplexed` is True if any group had running < enabled.
- **`start()` and `stop()` toggle everything at once.** `start()` resets the groups and calls
  `prctl(PR_TASK_PERF_EVENTS_ENABLE)`. `stop()` calls `prctl(PR_TASK_PERF_EVENTS_DISABLE)` and reads. One syscall
  toggles every counter the thread owns, so all groups start and stop at the same instant.
- **Kernel time is included by default** (`exclude_kernel=False`), e.g. page faults taken on the thread's behalf.
- **`plan_groups(names)`** splits events into the fewest runs that each count without multiplexing, verified by
  actually opening them. Each run includes `cycles`, for normalization. `op_profile.py` uses it to create sub-passes,
  which is where files like `inmodel_loads.0.csv` and `inmodel_loads.1.csv` come from.
- **`UncoreCounters("uncore_imc/cas_count_read/")`** opens the event on every `uncore_imc_N` box (on the CPU in its
  `cpumask`), sums the raw values, and exposes `.scale`.
- **Per-operator top-down uses the GP events** (`tdgp` pass), not `slots`/`topdown-*` (section 5.4).

**The measurement floor.** An empty `start(); stop()` still counts the tail of the enabling `prctl`, the return to
Python, the next call, and the start of the disabling `prctl`. OBSERVED, as the median of 300 empty pairs on CPU 20:

| Session | Floor |
|---|---|
| `cycles, instructions` | 5,007 cycles, 13,313 instructions |
| same, `exclude_kernel=True` | 3,287 cycles, 12,107 instructions |
| `cycles, instructions, ref-cycles` + 3 software events (2 groups; the `e2e_latency.py` set) | 9,089 cycles |
| `slots` + 4 level-1 `topdown-*` (floor only; don't use these per region, section 5.4) | 44,391 slots (≈ 7,400 cycles) |

So each measurement has a floor of **about 5-10K cycles**. `op_profile.py: measure_floor()` records each pass's
floor, and `analysis/analyze_resnet.py` subtracts it from every row, clipping at 0. For a 50K-cycle operator the
floor is 10-20% of the reading. Below about 50K cycles, rely on `standalone_hot` mode, which loops the operator to
amortize the floor.

### 11.4 A pitfall we hit: silent multiplexing from leaked events

1. **A group open failed part-way** (e.g. on a 5th `mem_load_retired.*` event, with `EINVAL`), and the descriptors
   already opened were **not closed**.
2. **`prctl(PR_TASK_PERF_EVENTS_ENABLE)` re-enabled them.** It enables *every* event the thread owns, including that
   orphaned half-group, even though the group was created disabled.
3. **The orphan competed for the 4 constrained counters**, so later sessions were multiplexed **without any error**.

A deliberate reproduction left a 3-event `mem_load_retired.*` group open, then ran a session with 2 more.
**observed**, showing `_multiplexed` and `(time_enabled, time_running)` in ns:
```
clean  : False (19885078, 19885078)
leaked : True (20455243, 10236660)        <- counted only 50% of the time
```
A related problem: if `UncoreCounters` stay open in the same thread, every `prctl` toggle also reaches those
socket-wide events, which are bound to another CPU. That costs inter-processor interrupts. The project measured
**~150K cycles per toggle**, versus ~5K normally.

Fixes now in the code: `CounterGroup` closes a partial group on failure, and `CounterSession` closes earlier groups
if a later one fails. `op_profile.py` closes the uncore counters in `finally`. Every row records `multiplexed`,
every pass records `any_multiplexing`, and the analysis lists any pass that multiplexed.

**Lesson: always verify `time_enabled == time_running`.** Scaling cannot repair this kind of problem, so check the
times explicitly.

---

## 12. Common mistakes

1. **Ignoring multiplexing.** A `(xx.xx%)` column, or `time_running < time_enabled`, means the count is
   extrapolated. Ratios across different windows mix phases. Use more passes, and groups for ratios.
2. **Confusing unscaled and scaled counts.** A raw count from a multiplexed in-process session (or from
   `--no-scale`) is low by the running fraction. A scaled count is an estimate, not a measurement. Say which one
   you report, and better, avoid needing either.
3. **Counting the whole process.** `perf stat python ...` includes start-up (42.5M cycles for `python3 -c pass`),
   imports, weights and warm-up; the first ResNet iteration took 126.5 ms against a 98.6 ms median. Count the
   region of interest (sections 4.7 and 11.3) and drop warm-up iterations.
4. **Treating LLC misses as DRAM demand loads.** `cache-misses` (= `LONGEST_LAT_CACHE.MISS`) includes L1/L2
   prefetches and stores, and many of its misses are hidden. Use instead:
   - demand loads: `mem_load_retired.l3_miss` or `ocr.demand_data_rd.dram`
   - cost: `memory_activity.stalls_l3_miss` plus top-down Memory Bound
   - bytes: the IMC CAS counts
5. **Treating `cache-references` as all cache accesses.** It counts only requests that reached L3; here it equalled
   `l2_rqsts.miss` exactly.
6. **Skid.** Non-precise samples land on the next instruction or later (section 6.2). Use `:pp`/`:P` before
   blaming an instruction.
7. **Mixing kernel and user counts.** `perf stat`, `perf record` and `CounterSession` all include kernel mode by
   default here, so a `:u` number from one tool doesn't compare with a default number from another. Page faults
   made the kernel 30% of cycles in section 4.6.
8. **Assuming a frequency.** Cycles stop while the thread blocks, and they convert to seconds only at a known
   frequency. Verify it with `cycles / ref-cycles` (2.095 GHz OBSERVED). Note that `-F` rates are per second of
   *CPU* time.
9. **Throttled sampling.** Above 1000 samples/s, "Event count (approx.)" undercounts (by half in section 6.1).
   Check `perf report --stats` for THROTTLE records.
10. **Oversized groups.** An entire group comes back `<not counted>`, and scripts that skip non-numeric values then
    silently lose those metrics. Check `per_pass_info`, or the CSV, for `<not counted>`.
11. **Using `topdown-*` (PERF_METRICS) deltas for a short region.** Every operator then shows the same split
    (section 5.4). Per region, use the GP top-down events (`tdgp`).
12. **Treating Retiring or IPC as efficiency.** An interpreter retires at IPC 3.8 while doing nothing useful, and a
    peak-FLOP GEMM can look Core Bound. Pair top-down with FLOPs/cycle and bytes moved.
13. **Forgetting that uncore is socket-wide.** Subtract background traffic, and remember the other users.
14. **Using `-a` or `perf top` while benchmarks run** on this shared machine.

---

## 13. Cheat sheet

| Goal | Command (pin to a non-benchmark CPU when testing) |
|---|---|
| Basic counts | `taskset -c 20 perf stat -e cycles,instructions,ref-cycles -- CMD` |
| Repeat with stddev / CSV | `perf stat -r 5 -e ... -- CMD` / `perf stat -x, -e ... -- CMD` |
| User vs kernel | `perf stat -e cycles:u,cycles:k,instructions:u,instructions:k -- CMD` |
| Phases over time | `perf stat -I 100 -e cycles,instructions -- CMD` |
| Region of interest | `perf stat -D -1 --control fifo:ctl.fifo,ack.fifo -e ... -- CMD` |
| Top-down L1 + L2 (whole process) | `perf stat -e '{slots,topdown-retiring,topdown-bad-spec,topdown-fe-bound,topdown-be-bound,topdown-heavy-ops,topdown-br-mispredict,topdown-fetch-lat,topdown-mem-bound}' -- CMD` |
| Top-down from GP events (any region; 2 runs) | `scripts/perfwrap.py --passes tdgp ...`, or in-process `CounterSession` with the `tdgp` events (section 5.4) |
| FP32 FLOPs | `perf stat -e '{cycles,fp_arith_inst_retired.scalar_single,fp_arith_inst_retired.128b_packed_single,fp_arith_inst_retired.256b_packed_single,fp_arith_inst_retired.512b_packed_single}' -- CMD` |
| Load sources (≤ 4 `mem_*`) | `perf stat -e '{cycles,mem_load_retired.l1_hit,mem_load_retired.l2_hit,mem_load_retired.l3_hit,mem_load_retired.l3_miss}' -- CMD` |
| Line-fill traffic (x 64 B) | `perf stat -e '{cycles,l1d.replacement,l2_lines_in.all,l2_lines_out.non_silent}' -- CMD` |
| Memory stalls | `perf stat -e '{cycles,cycle_activity.stalls_total,memory_activity.stalls_l3_miss}' -- CMD` |
| Socket DRAM traffic (MiB) | `perf stat -a -e uncore_imc/cas_count_read/,uncore_imc/cas_count_write/ -- sleep 1` |
| Where are the cycles? | `taskset -c 20 perf record -F 999 -o /tmp/me/p.data -- CMD; perf report -i /tmp/me/p.data --stdio` |
| Where are the L3-miss loads? | `perf record -e mem_load_retired.l3_miss:pp -c 2003 -- CMD` |
| Hot instructions | `perf annotate -i p.data --stdio -s SYMBOL` (record with `:P`) |
| Call graph | `perf record --call-graph lbr` (or `fp`, `dwarf,16384`), then `perf report --children` |
| Slow loads + addresses | `perf mem -t load record --ldlat=30 -- CMD; perf mem report --stdio --sort=mem,sym` |
| Python frames | `perf record -g -- python3 -X perf script.py` |
| oneDNN JIT symbols | `ONEDNN_JIT_PROFILE=6 perf record -k 1 ...; perf inject --jit -i IN -o OUT` |
| Sample health | `perf report --stats` (THROTTLE, LOST) |
| Look up an event | `perf list 'pattern*'`; `perf list --details EVENT`; `results/perf_events.md` |
| Project: whole command | `taskset -c C scripts/perfwrap.py --cpu C --repeat 3 --passes core,topdown,flops --out DIR -- CMD` |
| Project: per operator | `CounterSession([...])`; `start()`/`stop()`; check `_multiplexed`; subtract the floor |

| Derived metric | Formula |
|---|---|
| IPC / CPI | instructions / cycles; cycles / instructions |
| Frequency (GHz) / CPU time (s) | cycles / ref-cycles x 2.1; cycles / 2.1e9 (fixed frequency only) |
| TMA fraction | topdown-X / slots (slots = 6 x cycles); GP version in section 5.4 |
| FP32 FLOPs | scalar + 4 x 128b + 8 x 256b + 16 x 512b (FMA already counted twice) |
| Memory-level parallelism | l1d_pend_miss.pending / l1d_pend_miss.pending_cycles |
| Bytes into L1D / L2 | 64 x l1d.replacement; 64 x l2_lines_in.all |
| DRAM bytes (socket) | 64 x CAS (perf already prints MiB) |
| L3 MPKI (generic events) | 1000 x cache-misses / instructions (includes prefetches) |
