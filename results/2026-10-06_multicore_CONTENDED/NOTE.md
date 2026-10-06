# Contended multi-core run (kept as a noise example; do not use for results)

Started 15:36:47 UTC right after the quiet gate passed (1-minute load 1.03).
Another user's all-core job restarted at ~15:36:55 (other users' CPU 3% ->
~2,400%, `results/machine_load_2026-10-06.log`), so every configuration below
overlapped it. Stopped at ~15:39 after the baseline thread runs for N = 1, 2,
4, 8 (and part of 16/26).

Symptom worth remembering: with contention, intra-op scaling inverts --
baseline 104.7 ms (1 thread), 65.6 (2), 72.4 (4), 84.5 (8) -- because every
OpenMP parallel region waits for its slowest thread, and a thread that shares
its core with another process's thread is slowed by about 2x.
Re-run with a per-configuration contention check: results/<date>_multicore*/.
