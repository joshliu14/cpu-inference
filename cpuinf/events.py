"""Catalog of the performance events this project wants to measure.

Each entry lists *candidate* event names in preference order. Nothing here is
assumed to exist: scripts/discover_perf_events.py checks every candidate
against `perf list` and a real test count on this machine, and records the
outcome in results/perf_events.json. Measurement code only uses events that
discovery marked as supported; everything else is reported as UNAVAILABLE.
"""
from dataclasses import dataclass, field

THREAD = "per-thread (core PMU, counts only the measured thread on its core)"
SOFTWARE = "per-thread (kernel software counter)"
SOCKET = "socket-wide (uncore PMU; includes every process on the socket)"


@dataclass(frozen=True)
class Ev:
    key: str                      # stable name used in our CSV/JSON columns
    candidates: tuple             # perf event names to try, in order
    category: str
    scope: str
    description: str
    interpretation: str
    uncore: bool = False
    tags: tuple = field(default_factory=tuple)


CATALOG = [
    # ---------------------------------------------------------------- generic
    Ev("cycles", ("cycles",), "generic", THREAD,
       "Core clock cycles while the thread was running (unhalted).",
       "Time in core clocks. At a fixed 2.1 GHz, cycles / 2.1e9 = seconds on CPU."),
    Ev("instructions", ("instructions",), "generic", THREAD,
       "Retired (architecturally completed) instructions.",
       "Work done in instructions. IPC = instructions / cycles."),
    Ev("ref_cycles", ("ref-cycles",), "generic", THREAD,
       "Cycles at the fixed reference (TSC) rate while unhalted.",
       "cycles / ref_cycles x TSC frequency = actual average core frequency."),
    Ev("branches", ("branches",), "generic", THREAD,
       "Retired branch instructions.", "Control-flow density; high in scalar/Python code."),
    Ev("branch_misses", ("branch-misses",), "generic", THREAD,
       "Retired mispredicted branches.",
       "Each costs roughly 15-20 cycles of wasted pipeline work; check Bad Speculation."),
    Ev("cache_references", ("cache-references",), "generic", THREAD,
       "Generic 'cache references'. On Intel this maps to LONGEST_LAT_CACHE.REFERENCE "
       "(core requests that look up the LLC).",
       "Requests that missed the private L1+L2 and went to the shared L3. "
       "Not 'all cache accesses'."),
    Ev("cache_misses", ("cache-misses",), "generic", THREAD,
       "Generic 'cache misses'. On Intel: LONGEST_LAT_CACHE.MISS (L3 misses, incl. prefetches).",
       "Requests that missed L3 and were served by memory (or another socket). "
       "An LLC miss is not proof of a demand DRAM stall: prefetches are included."),
    Ev("context_switches", ("context-switches",), "generic", SOFTWARE,
       "Context switches of the measured thread.", "Noise indicator: should be ~0 in a timed region."),
    Ev("cpu_migrations", ("cpu-migrations",), "generic", SOFTWARE,
       "Migrations of the thread between CPUs.", "Must be 0 when pinned with taskset."),
    Ev("page_faults", ("page-faults",), "generic", SOFTWARE,
       "Page faults (minor + major).",
       "Fresh allocations being touched for the first time; costs kernel time."),
    Ev("task_clock", ("task-clock",), "generic", SOFTWARE,
       "CPU time of the thread in nanoseconds.", "Cross-check against wall-clock time."),

    # ------------------------------------------------------- top-down (TMA)
    Ev("slots", ("slots", "topdown.slots"), "topdown", THREAD,
       "Pipeline issue slots (machine width x cycles; 6 slots/cycle on Golden Cove).",
       "Denominator for every top-down fraction."),
    Ev("td_retiring", ("topdown-retiring",), "topdown", THREAD,
       "Slots that issued uops which eventually retired.",
       "Useful work. High Retiring + low IPC can still mean wasteful (e.g. scalar) code."),
    Ev("td_bad_spec", ("topdown-bad-spec",), "topdown", THREAD,
       "Slots wasted on uops that were cancelled (mispredicts, machine clears).",
       "Speculation waste."),
    Ev("td_fe_bound", ("topdown-fe-bound",), "topdown", THREAD,
       "Slots where the frontend delivered no uop while the backend could accept one.",
       "Instruction fetch/decode limits (i-cache, ITLB, decoders, DSB)."),
    Ev("td_be_bound", ("topdown-be-bound",), "topdown", THREAD,
       "Slots where no uop issued because the backend lacked resources.",
       "Either waiting on memory (Memory Bound) or on execution units (Core Bound)."),
    Ev("td_heavy_ops", ("topdown-heavy-ops",), "topdown", THREAD,
       "Retiring slots from instructions decoding to >= 2 uops or microcode.",
       "Level-2 split of Retiring: Heavy vs Light operations."),
    Ev("td_br_mispredict", ("topdown-br-mispredict",), "topdown", THREAD,
       "Bad-speculation slots due to branch mispredicts.",
       "Level-2 split of Bad Speculation: Branch Mispredict vs Machine Clears."),
    Ev("td_fetch_lat", ("topdown-fetch-lat",), "topdown", THREAD,
       "Frontend-bound slots due to fetch latency (i-cache/ITLB misses, resteers).",
       "Level-2 split of Frontend Bound: Fetch Latency vs Fetch Bandwidth."),
    Ev("td_mem_bound", ("topdown-mem-bound",), "topdown", THREAD,
       "Backend-bound slots attributed to the memory subsystem.",
       "Level-2 split of Backend Bound: Memory Bound vs Core Bound."),

    # ------------------------------------- top-down from general-purpose events
    # The kernel's topdown-* events above are derived from the PERF_METRICS
    # register, which holds 8-bit fractions accumulated since the hardware was
    # last reset. Differencing two reads around a short region therefore gives
    # (delta slots) x (cumulative average fraction) -- OBSERVED: every ResNet
    # operator showed the same split. They are valid for whole-process
    # counting (perf stat) only. For per-region top-down we use these plain
    # counting events, combined with Intel's TMA formulas (cpuinf/metrics.py).
    Ev("tdg_slots", ("topdown.slots_p",), "topdown_gp", THREAD,
       "Issue slots, counted on a general-purpose counter.", "Denominator of every fraction."),
    Ev("tdg_retiring", ("uops_retired.slots",), "topdown_gp", THREAD,
       "Retirement slots used by retired uops.", "Retiring = uops_retired.slots / slots."),
    Ev("tdg_bad_spec", ("topdown.bad_spec_slots",), "topdown_gp", THREAD,
       "Slots wasted by speculation (mispredicts + machine clears).", "Bad Speculation."),
    Ev("tdg_fe_bound", ("idq_bubbles.core", "idq_uops_not_delivered.core"), "topdown_gp", THREAD,
       "Uops not delivered by the frontend while the backend was not stalled.",
       "Frontend Bound = (idq_bubbles.core - int_misc.uop_dropping) / slots."),
    Ev("tdg_be_bound", ("topdown.backend_bound_slots",), "topdown_gp", THREAD,
       "Slots where the backend could not accept uops.", "Backend Bound."),
    Ev("tdg_mem_bound", ("topdown.memory_bound_slots",), "topdown_gp", THREAD,
       "Backend-bound slots attributed to the memory subsystem.", "Memory Bound; Core Bound = Backend - Memory."),
    Ev("tdg_br_mispredict", ("topdown.br_mispredict_slots",), "topdown_gp", THREAD,
       "Bad-speculation slots caused by branch mispredicts.", "Machine Clears = Bad Spec - this."),
    Ev("tdg_heavy_ops", ("uops_retired.heavy",), "topdown_gp", THREAD,
       "Retired uops of heavy (multi-uop / microcoded) instructions.", "Heavy Operations; Light = Retiring - Heavy."),
    Ev("tdg_fe_0uops_cycles", ("idq_bubbles.cycles_0_uops_deliv.core",), "topdown_gp", THREAD,
       "Cycles in which the frontend delivered no uop while the backend could take one.",
       "Fetch Latency = (6 x this - int_misc.uop_dropping) / slots."),
    Ev("tdg_uop_dropping", ("int_misc.uop_dropping",), "topdown_gp", THREAD,
       "Uops dropped by the frontend (correction term in TMA formulas).", ""),

    # ------------------------------------------------------ floating point
    Ev("fp_scalar_single", ("fp_arith_inst_retired.scalar_single",), "flops", THREAD,
       "Retired scalar FP32 arithmetic instructions (FMA counts twice).", "1 FLOP each."),
    Ev("fp_128_single", ("fp_arith_inst_retired.128b_packed_single",), "flops", THREAD,
       "Retired 128-bit (SSE/AVX xmm) packed FP32 instructions (FMA counts twice).", "4 FLOPs each."),
    Ev("fp_256_single", ("fp_arith_inst_retired.256b_packed_single",), "flops", THREAD,
       "Retired 256-bit (AVX/AVX2 ymm) packed FP32 instructions (FMA counts twice).", "8 FLOPs each."),
    Ev("fp_512_single", ("fp_arith_inst_retired.512b_packed_single",), "flops", THREAD,
       "Retired 512-bit (AVX-512 zmm) packed FP32 instructions (FMA counts twice).", "16 FLOPs each."),
    Ev("fp_scalar_double", ("fp_arith_inst_retired.scalar_double",), "flops", THREAD,
       "Retired scalar FP64 arithmetic instructions.", "Should be ~0 in FP32 inference."),
    Ev("fp_512_double", ("fp_arith_inst_retired.512b_packed_double",), "flops", THREAD,
       "Retired 512-bit packed FP64 instructions.", "Should be ~0 in FP32 inference."),
    Ev("amx_busy", ("exe.amx_busy",), "flops", THREAD,
       "Cycles the AMX unit is busy.", "Non-zero only if a kernel uses AMX tiles (bf16/int8)."),

    # ------------------------------------------------- load/store & caches
    Ev("loads", ("mem_inst_retired.all_loads",), "memory", THREAD,
       "Retired load instructions.", "Denominator for hit/miss ratios by level."),
    Ev("stores", ("mem_inst_retired.all_stores",), "memory", THREAD,
       "Retired store instructions.", ""),
    Ev("load_l1_hit", ("mem_load_retired.l1_hit",), "memory", THREAD,
       "Retired loads whose data came from L1D.", "Data source attribution for *retired demand loads*."),
    Ev("load_l1_miss", ("mem_load_retired.l1_miss",), "memory", THREAD,
       "Retired loads that missed L1D.", ""),
    Ev("load_fb_hit", ("mem_load_retired.fb_hit",), "memory", THREAD,
       "Retired loads that missed L1D but hit a fill buffer already fetching the line.",
       "Line was already in flight (often thanks to a prefetch or a neighbouring load)."),
    Ev("load_l2_hit", ("mem_load_retired.l2_hit",), "memory", THREAD,
       "Retired loads served by L2.", ""),
    Ev("load_l2_miss", ("mem_load_retired.l2_miss",), "memory", THREAD,
       "Retired loads that missed L2.", ""),
    Ev("load_l3_hit", ("mem_load_retired.l3_hit",), "memory", THREAD,
       "Retired loads served by L3.", ""),
    Ev("load_l3_miss", ("mem_load_retired.l3_miss",), "memory", THREAD,
       "Retired loads that missed L3 (served by DRAM or remote).",
       "Strongest per-thread evidence that a *demand load* went beyond the LLC."),
    Ev("l1d_replacement", ("l1d.replacement",), "memory", THREAD,
       "Cache lines brought into L1D (demand + prefetch).",
       "x 64 B = bytes filled into L1D: an estimate of L2->L1 traffic."),
    Ev("l2_lines_in", ("l2_lines_in.all",), "memory", THREAD,
       "Cache lines filled into L2 (demand + prefetch).",
       "x 64 B = bytes filled into L2: an estimate of L3/DRAM->L2 traffic."),
    Ev("l2_lines_out_nonsilent", ("l2_lines_out.non_silent",), "memory", THREAD,
       "Modified/forwarded lines evicted from L2 (write-backs toward L3).",
       "x 64 B ~ L2->L3 write-back traffic."),
    Ev("l2_rqsts_miss", ("l2_rqsts.miss",), "memory", THREAD,
       "L2 requests that missed (demand + prefetch).", ""),
    Ev("l2_hwpf", ("l2_rqsts.all_hwpf",), "memory", THREAD,
       "L2 hardware prefetch requests.", "How much of the traffic is prefetcher-driven."),
    Ev("offcore_demand_rd", ("offcore_requests.demand_data_rd",), "memory", THREAD,
       "Demand data reads sent beyond L2 (to the uncore).", ""),
    Ev("ocr_dram_rd", ("ocr.demand_data_rd.dram",), "memory", THREAD,
       "Demand data reads that were served by DRAM (offcore response).",
       "Per-thread DRAM attribution for demand reads (prefetches excluded)."),
    Ev("ocr_reads_dram", ("ocr.reads_to_core.dram",), "memory", THREAD,
       "All reads to core (demand + prefetch) served by DRAM.", ""),
    Ev("dtlb_load_walks", ("dtlb_load_misses.walk_completed",), "memory", THREAD,
       "Completed page walks caused by loads.", "TLB reach problems."),

    # ---------------------------------------------------------------- stalls
    Ev("stalls_total", ("cycle_activity.stalls_total",), "stalls", THREAD,
       "Cycles with no uop executed on any port.", "Total execution stalls."),
    Ev("stalls_l1d_miss", ("memory_activity.stalls_l1d_miss", "cycle_activity.stalls_l1d_miss"), "stalls", THREAD,
       "Execution stalls while an L1D-miss demand load is outstanding.", ""),
    Ev("stalls_l2_miss", ("memory_activity.stalls_l2_miss", "cycle_activity.stalls_l2_miss"), "stalls", THREAD,
       "Execution stalls while an L2-miss demand load is outstanding.", ""),
    Ev("stalls_l3_miss", ("memory_activity.stalls_l3_miss", "cycle_activity.stalls_l3_miss"), "stalls", THREAD,
       "Execution stalls while an L3-miss demand load is outstanding.",
       "Upper bound on cycles lost waiting for DRAM by demand loads."),
    Ev("bound_on_loads", ("exe_activity.bound_on_loads",), "stalls", THREAD,
       "Stall cycles where a load was outstanding (any level).", ""),
    Ev("bound_on_stores", ("exe_activity.bound_on_stores",), "stalls", THREAD,
       "Cycles where the store buffer was full and no load was outstanding.", "Store-bandwidth pressure."),
    Ev("l1d_pend_miss_cycles", ("l1d_pend_miss.pending_cycles",), "stalls", THREAD,
       "Cycles with at least one L1D miss outstanding.", ""),
    Ev("l1d_pend_miss_pending", ("l1d_pend_miss.pending",), "stalls", THREAD,
       "Sum over cycles of outstanding L1D misses.",
       "pending / pending_cycles = memory-level parallelism (avg. misses in flight)."),
    Ev("fb_full", ("l1d_pend_miss.fb_full",), "stalls", THREAD,
       "Cycles a demand request was blocked because the fill buffers were full.",
       "Too many misses in flight: per-core bandwidth limit."),

    # -------------------------------------------------- execution ports/uops
    Ev("port0", ("uops_dispatched.port_0",), "ports", THREAD,
       "Uops dispatched on port 0 (ALU, FMA/vector on 512-bit fused p0+p1).", ""),
    Ev("port1", ("uops_dispatched.port_1",), "ports", THREAD,
       "Uops dispatched on port 1 (ALU; vector port fused with p0 for 512-bit).", ""),
    Ev("port5", ("uops_dispatched.port_5_11",), "ports", THREAD,
       "Uops dispatched on ports 5 and 11 (ALU, shuffle, 2nd 512-bit FMA on server parts).", ""),
    Ev("port6", ("uops_dispatched.port_6",), "ports", THREAD, "Uops dispatched on port 6 (ALU, branch).", ""),
    Ev("port_load", ("uops_dispatched.port_2_3_10",), "ports", THREAD,
       "Uops dispatched on load ports 2, 3 and 10.", "Up to 3 loads/cycle (2 for 512-bit)."),
    Ev("port_sta", ("uops_dispatched.port_7_8",), "ports", THREAD, "Store-address uops (ports 7, 8).", ""),
    Ev("port_std", ("uops_dispatched.port_4_9",), "ports", THREAD, "Store-data uops (ports 4, 9).", ""),
    Ev("uops_executed", ("uops_executed.thread",), "ports", THREAD, "Uops executed by the thread.", ""),
    Ev("uops_issued", ("uops_issued.any",), "ports", THREAD, "Uops issued by the RAT to the RS.", ""),
    Ev("ports_util_1", ("exe_activity.1_ports_util",), "ports", THREAD,
       "Cycles with exactly 1 uop executed across all ports (non-stall).", "Low execution parallelism."),
    Ev("ports_util_2", ("exe_activity.2_ports_util",), "ports", THREAD,
       "Cycles with exactly 2 uops executed.", ""),

    # ---------------------------------------------------------- frontend
    Ev("dsb_uops", ("idq.dsb_uops",), "frontend", THREAD, "Uops delivered from the decoded-uop cache (DSB).", ""),
    Ev("mite_uops", ("idq.mite_uops",), "frontend", THREAD, "Uops delivered from legacy decoders (MITE).", ""),
    Ev("ms_uops", ("idq.ms_uops",), "frontend", THREAD, "Uops delivered by the microcode sequencer.", ""),
    Ev("lsd_uops", ("lsd.uops",), "frontend", THREAD, "Uops delivered by the loop stream detector.", ""),
    Ev("icache_stalls", ("icache_data.stalls",), "frontend", THREAD, "Cycles stalled on instruction-cache misses.", ""),

    # ------------------------------------------------------------- uncore
    Ev("imc_cas_read", ("uncore_imc/cas_count_read/",), "dram", SOCKET,
       "DRAM read CAS commands summed over all memory channels (perf scales to MiB).",
       "Actual bytes read from DRAM by the whole socket (64 B per CAS).", uncore=True),
    Ev("imc_cas_write", ("uncore_imc/cas_count_write/",), "dram", SOCKET,
       "DRAM write CAS commands summed over all memory channels.",
       "Actual bytes written to DRAM by the whole socket.", uncore=True),
]

BY_KEY = {e.key: e for e in CATALOG}

# Measurement passes. Each pass is run separately so that no pass needs more
# hardware counters than the core has (8 general-purpose + fixed counters on
# this PMU with SMT off); multiplexing is checked and reported, not assumed away.
PASSES = {
    "core": ["cycles", "instructions", "ref_cycles", "branches", "branch_misses",
             "cache_references", "cache_misses"],
    "sw": ["task_clock", "page_faults", "context_switches", "cpu_migrations"],
    # perf-metrics top-down: valid for whole-process counting (perf stat) only
    "topdown": ["slots", "td_retiring", "td_bad_spec", "td_fe_bound", "td_be_bound",
                "td_heavy_ops", "td_br_mispredict", "td_fetch_lat", "td_mem_bound"],
    # general-purpose top-down: valid for any region (used per operator)
    "tdgp": ["tdg_slots", "tdg_retiring", "tdg_bad_spec", "tdg_fe_bound", "tdg_be_bound",
             "tdg_mem_bound", "tdg_br_mispredict", "tdg_heavy_ops", "tdg_fe_0uops_cycles",
             "tdg_uop_dropping"],
    "flops": ["cycles", "instructions", "fp_scalar_single", "fp_128_single", "fp_256_single",
              "fp_512_single", "fp_scalar_double", "fp_512_double", "amx_busy"],
    "loads": ["cycles", "loads", "stores", "load_l1_hit", "load_l1_miss", "load_fb_hit",
              "load_l2_hit", "load_l3_hit", "load_l3_miss"],
    "traffic": ["cycles", "l1d_replacement", "l2_lines_in", "l2_lines_out_nonsilent",
                "l2_hwpf", "offcore_demand_rd", "ocr_dram_rd", "ocr_reads_dram"],
    "stalls": ["cycles", "stalls_total", "stalls_l1d_miss", "stalls_l2_miss", "stalls_l3_miss",
               "bound_on_loads", "bound_on_stores", "l1d_pend_miss_pending", "l1d_pend_miss_cycles"],
    "ports": ["cycles", "port0", "port1", "port5", "port6", "port_load", "port_sta",
              "port_std", "uops_executed"],
    "frontend": ["cycles", "uops_issued", "dsb_uops", "mite_uops", "ms_uops", "lsd_uops",
                 "icache_stalls", "dtlb_load_walks", "fb_full"],
}
