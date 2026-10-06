# Counter validation against known-answer microbenchmarks

Each row: counter value divided by the known amount of work: per dependent load for pointer chases, per 64-byte line requested for streams, per FMA instruction for fma512. One uncore CAS = one 64 B line. Uncore counters are socket-wide, so other activity on the machine adds to them.

## chase_L1

random pointer chase, 16 KiB, 2 MiB pages: one dependent load per step; work = 1e+06 loads; cycles per unit = 5.053

| counter | value | per unit (load / line / FMA) |
|---|---|---|
| `mem_load_retired.l1_hit` | 1,011,150 | 1.0111 |
| `mem_load_retired.l2_hit` | 499 | 0.0005 |
| `mem_load_retired.l3_hit` | 150 | 0.0001 |
| `mem_load_retired.l3_miss` | 16 | 0.0000 |

## chase_L2

random pointer chase, 1024 KiB, 2 MiB pages: one dependent load per step; work = 1e+06 loads; cycles per unit = 16.061

| counter | value | per unit (load / line / FMA) |
|---|---|---|
| `mem_load_retired.l1_hit` | 16,154 | 0.0162 |
| `mem_load_retired.l2_hit` | 1,000,882 | 1.0009 |
| `mem_load_retired.l3_hit` | 169 | 0.0002 |
| `mem_load_retired.l3_miss` | 5 | 0.0000 |

## chase_L3

random pointer chase, 16384 KiB, 2 MiB pages: one dependent load per step; work = 1.049e+06 loads; cycles per unit = 67.705

| counter | value | per unit (load / line / FMA) |
|---|---|---|
| `mem_load_retired.l1_hit` | 50,250 | 0.0479 |
| `mem_load_retired.l2_hit` | 4,406 | 0.0042 |
| `mem_load_retired.l3_hit` | 1,015,833 | 0.9688 |
| `mem_load_retired.l3_miss` | 33,505 | 0.0320 |

## chase_DRAM

random pointer chase, 1048576 KiB, 2 MiB pages: one dependent load per step; work = 4e+06 loads; cycles per unit = 209.339

| counter | value | per unit (load / line / FMA) |
|---|---|---|
| `mem_load_retired.l1_hit` | 566,256 | 0.1416 |
| `mem_load_retired.l2_hit` | 57,183 | 0.0143 |
| `mem_load_retired.l3_hit` | 2,096 | 0.0005 |
| `mem_load_retired.l3_miss` | 3,999,837 | 1.0000 |

## chase_DRAM_dram_attribution

each step should be one demand read served by DRAM = one 64 B CAS read; work = 4e+06 loads; cycles per unit = 209.287

| counter | value | per unit (load / line / FMA) |
|---|---|---|
| `ocr.demand_data_rd.dram` | 3,999,537 | 0.9999 |
| `offcore_requests.demand_data_rd` | 4,004,313 | 1.0011 |
| `uncore_imc/cas_count_read/` | 4,497,440 | 1.1244 |
| `uncore_imc/cas_count_write/` | 371,815 | 0.0930 |

## tlb_4k

1 GiB chase, 4 KiB pages; work = 4e+06 loads; cycles per unit = 266.873

| counter | value | per unit (load / line / FMA) |
|---|---|---|
| `dtlb_load_misses.stlb_hit` | 33,391 | 0.0083 |
| `dtlb_load_misses.walk_completed` | 3,980,073 | 0.9950 |

## tlb_2m

1 GiB chase, 2 MiB pages; work = 4e+06 loads; cycles per unit = 209.321

| counter | value | per unit (load / line / FMA) |
|---|---|---|
| `dtlb_load_misses.stlb_hit` | 3,760,232 | 0.9401 |
| `dtlb_load_misses.walk_completed` | 98 | 0.0000 |

## stream_read

sequential 512 MiB read, 64 B zmm loads; work = 5.369e+08 bytes; cycles per unit = 7.285

| counter | value | per unit (load / line / FMA) |
|---|---|---|
| `l2_lines_in.all` | 8,428,991 | 1.0048 |
| `mem_load_retired.l3_miss` | 3,969,667 | 0.4732 |
| `uncore_imc/cas_count_read/` | 8,415,904 | 1.0033 |
| `uncore_imc/cas_count_write/` | 24,443 | 0.0029 |

## stream_read_sources

where do demand loads of a stream get their data?; work = 5.369e+08 bytes; cycles per unit = 7.274

| counter | value | per unit (load / line / FMA) |
|---|---|---|
| `mem_inst_retired.all_loads` | 8,444,373 | 1.0066 |
| `mem_load_retired.fb_hit` | 513,367 | 0.0612 |
| `mem_load_retired.l1_hit` | 65,914 | 0.0079 |
| `mem_load_retired.l2_hit` | 3,838,959 | 0.4576 |

## stream_write

regular stores: expect DRAM reads (read-for-ownership) as well as writes; work = 5.369e+08 bytes; cycles per unit = 8.969

| counter | value | per unit (load / line / FMA) |
|---|---|---|
| `l2_lines_out.non_silent` | 8,421,393 | 1.0039 |
| `uncore_imc/cas_count_read/` | 8,332,868 | 0.9934 |
| `uncore_imc/cas_count_write/` | 8,076,656 | 0.9628 |

## stream_write_nt

non-temporal stores: expect DRAM writes, no RFO reads; work = 5.369e+08 bytes; cycles per unit = 5.822

| counter | value | per unit (load / line / FMA) |
|---|---|---|
| `uncore_imc/cas_count_read/` | 90,603 | 0.0108 |
| `uncore_imc/cas_count_write/` | 8,410,173 | 1.0026 |

## fma512

register-only AVX-512 FMA throughput kernel; work = 1e+08 ops; cycles per unit = 0.503

| counter | value | per unit (load / line / FMA) |
|---|---|---|
| `fp_arith_inst_retired.512b_packed_single` | 199,999,872 | 2.0000 |
| `uops_dispatched.port_0` | 50,017,159 | 0.5002 |
| `uops_dispatched.port_1` | 185,465 | 0.0019 |
| `uops_dispatched.port_5_11` | 50,726,936 | 0.5073 |

