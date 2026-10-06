"""Derived metrics computed from raw counter values.

All functions take a dict of raw counts keyed by catalog keys (see events.py)
and return new keys. Missing inputs produce None (rendered as UNAVAILABLE),
never 0.
"""
from __future__ import annotations

LINE = 64  # bytes per cache line on this CPU (sysfs coherency_line_size)
TSC_GHZ = 2.1  # reference-cycle (TSC) rate; turbostat TSC_MHz=2100 on this machine


def _div(a, b):
    if a is None or b is None or b == 0:
        return None
    return a / b


def derive(c: dict, freq_hz: float | None = None) -> dict:
    g = c.get
    d = {}
    d["ipc"] = _div(g("instructions"), g("cycles"))
    d["cpi"] = _div(g("cycles"), g("instructions"))
    d["freq_ghz"] = (_div(g("cycles"), g("ref_cycles")) * TSC_GHZ) if g("ref_cycles") else None
    d["branch_miss_rate"] = _div(g("branch_misses"), g("branches"))
    d["llc_miss_ratio"] = _div(g("cache_misses"), g("cache_references"))
    d["llc_mpki"] = _div(g("cache_misses"), g("instructions") and g("instructions") / 1000)

    # Top-down level 1 and level 2: fraction of pipeline slots.
    s = g("slots")
    if s:
        ret, bad, fe, be = (g("td_retiring"), g("td_bad_spec"), g("td_fe_bound"), g("td_be_bound"))
        d["tma_retiring"] = _div(ret, s)
        d["tma_bad_spec"] = _div(bad, s)
        d["tma_frontend_bound"] = _div(fe, s)
        d["tma_backend_bound"] = _div(be, s)
        if g("td_heavy_ops") is not None and ret is not None:
            d["tma_heavy_ops"] = _div(g("td_heavy_ops"), s)
            d["tma_light_ops"] = _div(ret - g("td_heavy_ops"), s)
        if g("td_br_mispredict") is not None and bad is not None:
            d["tma_branch_mispredicts"] = _div(g("td_br_mispredict"), s)
            d["tma_machine_clears"] = _div(max(bad - g("td_br_mispredict"), 0), s)
        if g("td_fetch_lat") is not None and fe is not None:
            d["tma_fetch_latency"] = _div(g("td_fetch_lat"), s)
            d["tma_fetch_bandwidth"] = _div(max(fe - g("td_fetch_lat"), 0), s)
        if g("td_mem_bound") is not None and be is not None:
            d["tma_memory_bound"] = _div(g("td_mem_bound"), s)
            d["tma_core_bound"] = _div(max(be - g("td_mem_bound"), 0), s)

    # Top-down from general-purpose events (valid per region). Formulas follow
    # Intel's TMA method for this core (6 slots per cycle).
    s = g("tdg_slots")
    if s:
        drop = g("tdg_uop_dropping") or 0
        ret, bad, be = g("tdg_retiring"), g("tdg_bad_spec"), g("tdg_be_bound")
        fe = (g("tdg_fe_bound") - drop) if g("tdg_fe_bound") is not None else None
        d["tma_retiring"] = _div(ret, s)
        d["tma_bad_spec"] = _div(bad, s)
        d["tma_frontend_bound"] = _div(fe, s)
        d["tma_backend_bound"] = _div(be, s)
        if None not in (ret, bad, fe, be):
            d["tma_l1_sum"] = (ret + bad + fe + be) / s   # sanity check, should be ~1
        if g("tdg_heavy_ops") is not None and ret is not None:
            d["tma_heavy_ops"] = _div(g("tdg_heavy_ops"), s)
            d["tma_light_ops"] = _div(max(ret - g("tdg_heavy_ops"), 0), s)
        if g("tdg_br_mispredict") is not None and bad is not None:
            d["tma_branch_mispredicts"] = _div(g("tdg_br_mispredict"), s)
            d["tma_machine_clears"] = _div(max(bad - g("tdg_br_mispredict"), 0), s)
        if g("tdg_fe_0uops_cycles") is not None and fe is not None:
            fl = max(6 * g("tdg_fe_0uops_cycles") - drop, 0)
            d["tma_fetch_latency"] = _div(fl, s)
            d["tma_fetch_bandwidth"] = _div(max(fe - fl, 0), s)
        if g("tdg_mem_bound") is not None and be is not None:
            d["tma_memory_bound"] = _div(g("tdg_mem_bound"), s)
            d["tma_core_bound"] = _div(max(be - g("tdg_mem_bound"), 0), s)

    # Retired floating-point work. FP_ARITH counts FMA instructions twice, so
    # multiplying by the vector width gives FLOPs directly.
    fp_keys = {"fp_scalar_single": 1, "fp_128_single": 4, "fp_256_single": 8, "fp_512_single": 16,
               "fp_scalar_double": 1, "fp_512_double": 8}
    if any(g(k) is not None for k in fp_keys):
        d["flops_measured"] = sum((g(k) or 0) * w for k, w in fp_keys.items())
        total_fp_inst = sum((g(k) or 0) for k in fp_keys)
        d["fp_inst_512_share"] = _div(g("fp_512_single"), total_fp_inst)
        d["fp_inst_256_share"] = _div(g("fp_256_single"), total_fp_inst)
        d["fp_inst_scalar_share"] = _div((g("fp_scalar_single") or 0) + (g("fp_scalar_double") or 0), total_fp_inst)
        d["flops_per_cycle"] = _div(d["flops_measured"], g("cycles"))

    # Where retired demand loads were served from (fractions of all loads).
    if g("loads"):
        for k in ("load_l1_hit", "load_fb_hit", "load_l2_hit", "load_l3_hit", "load_l3_miss"):
            d[k + "_frac"] = _div(g(k), g("loads"))
        d["loads_per_instr"] = _div(g("loads"), g("instructions"))

    # Line-fill traffic estimates (bytes), demand + prefetch.
    if g("l1d_replacement") is not None:
        d["bytes_into_l1d"] = g("l1d_replacement") * LINE
    if g("l2_lines_in") is not None:
        d["bytes_into_l2"] = g("l2_lines_in") * LINE
    if g("l2_lines_out_nonsilent") is not None:
        d["bytes_l2_writeback"] = g("l2_lines_out_nonsilent") * LINE
    if g("ocr_reads_dram") is not None:
        d["bytes_dram_reads_core"] = g("ocr_reads_dram") * LINE

    # Stall breakdown (fractions of cycles).
    cyc = g("cycles")
    for k in ("stalls_total", "stalls_l1d_miss", "stalls_l2_miss", "stalls_l3_miss",
              "bound_on_loads", "bound_on_stores"):
        if g(k) is not None:
            d[k + "_frac"] = _div(g(k), cyc)
    if g("l1d_pend_miss_pending") is not None:
        d["mlp_l1d"] = _div(g("l1d_pend_miss_pending"), g("l1d_pend_miss_cycles"))

    # Execution port utilisation (uops per cycle per port).
    for k in ("port0", "port1", "port5", "port6", "port_load", "port_sta", "port_std"):
        if g(k) is not None:
            d[k + "_per_cycle"] = _div(g(k), cyc)
    return d
