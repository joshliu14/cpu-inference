# Counter validation run under heavy contention (kept as a noise example)

While this ran (2026-10-06 ~00:27-00:31 UTC) another user's job occupied all
28 cores (load average ~26-28) and drove ~50 GB/s of DRAM reads and ~15 GB/s
of writes socket-wide (OBSERVED with uncore IMC counters right afterwards).

Visible effects (OBSERVED):
* chase_L3 (16 MiB working set, 2 MiB pages): `mem_load_retired.l3_miss` =
  0.999 per load and 204 cycles/load -- DRAM latency, although the same
  working set measured 63 cycles (an L3 hit) on a quiet machine. INFERRED: the
  neighbour's traffic evicted our lines from the shared L3 between visits.
* chase_DRAM_dram_attribution: 6.37 socket CAS reads per load instead of ~1:
  the extra ~5.4 lines/load are other cores' traffic.

Per-thread counters (load sources, ocr.*, page walks, FP, ports) still reported
self-consistent values; socket-wide uncore counts did not. The run is repeated
on a quiet machine (see the next counter_validation directory).
