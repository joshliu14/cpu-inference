# Counter validation against known-answer microbenchmarks

Each row: counter value divided by the known amount of work: per dependent load for pointer chases, per 64-byte line requested for streams, per FMA instruction for fma512. One uncore CAS = one 64 B line. Uncore counters are socket-wide, so other activity on the machine adds to them.

## chase_L1

random pointer chase, 16 KiB, 2 MiB pages: one dependent load per step; work = 1e+06 loads; cycles per unit = 5.043

| counter | value | per unit (load / line / FMA) |
|---|---|---|
| `mem_load_retired.l1_hit` | 1,008,812 | 1.0088 |
| `mem_load_retired.l2_hit` | 512 | 0.0005 |
| `mem_load_retired.l3_hit` | 187 | 0.0002 |
| `mem_load_retired.l3_miss` | 59 | 0.0001 |

## chase_L2

random pointer chase, 1024 KiB, 2 MiB pages: one dependent load per step; work = 1e+06 loads; cycles per unit = 20.857

| counter | value | per unit (load / line / FMA) |
|---|---|---|
| `mem_load_retired.l1_hit` | 20,103 | 0.0201 |
| `mem_load_retired.l2_hit` | 975,184 | 0.9752 |
| `mem_load_retired.l3_hit` | 4,508 | 0.0045 |
| `mem_load_retired.l3_miss` | 21,760 | 0.0218 |

## chase_L3

random pointer chase, 16384 KiB, 2 MiB pages: one dependent load per step; work = 1.049e+06 loads; cycles per unit = 204.455

| counter | value | per unit (load / line / FMA) |
|---|---|---|
| `mem_load_retired.l1_hit` | 152,584 | 0.1455 |
| `mem_load_retired.l2_hit` | 12,029 | 0.0115 |
| `mem_load_retired.l3_hit` | 3,208 | 0.0031 |
| `mem_load_retired.l3_miss` | 1,047,329 | 0.9988 |

## chase_DRAM

random pointer chase, 1048576 KiB, 2 MiB pages: one dependent load per step; work = 4e+06 loads; cycles per unit = 209.863

| counter | value | per unit (load / line / FMA) |
|---|---|---|
| `mem_load_retired.l1_hit` | 537,887 | 0.1345 |
| `mem_load_retired.l2_hit` | 47,722 | 0.0119 |
| `mem_load_retired.l3_hit` | 2,896 | 0.0007 |
| `mem_load_retired.l3_miss` | 4,000,227 | 1.0001 |

## chase_DRAM_dram_attribution

each step should be one demand read served by DRAM = one 64 B CAS read; work = 4e+06 loads; cycles per unit = 210.771

| counter | value | per unit (load / line / FMA) |
|---|---|---|
| `ocr.demand_data_rd.dram` | 4,001,483 | 1.0004 |
| `offcore_requests.demand_data_rd` | 4,007,092 | 1.0018 |
| `uncore_imc/cas_count_read/` | 25,496,122 | 6.3740 |
| `uncore_imc/cas_count_write/` | 6,623,409 | 1.6559 |

## tlb_4k

1 GiB chase, 4 KiB pages; work = 4e+06 loads; cycles per unit = 273.726

| counter | value | per unit (load / line / FMA) |
|---|---|---|
| `dtlb_load_misses.stlb_hit` | 33,229 | 0.0083 |
| `dtlb_load_misses.walk_completed` | 3,978,444 | 0.9946 |

## tlb_2m

1 GiB chase, 2 MiB pages; work = 4e+06 loads; cycles per unit = 209.822

| counter | value | per unit (load / line / FMA) |
|---|---|---|
| `dtlb_load_misses.stlb_hit` | 3,757,697 | 0.9394 |
| `dtlb_load_misses.walk_completed` | 3,437 | 0.0009 |

## stream_read

sequential 512 MiB read, 64 B zmm loads; work = 5.369e+08 bytes; cycles per unit = 7.330

| counter | value | per unit (load / line / FMA) |
|---|---|---|
| `l2_lines_in.all` | 8,423,087 | 1.0041 |
| `mem_load_retired.l3_miss` | 4,052,441 | 0.4831 |
| `uncore_imc/cas_count_read/` | 9,407,838 | 1.1215 |
| `uncore_imc/cas_count_write/` | 349,058 | 0.0416 |

## stream_read_sources

where do demand loads of a stream get their data?; work = 5.369e+08 bytes; cycles per unit = 7.384

| counter | value | per unit (load / line / FMA) |
|---|---|---|
| `mem_inst_retired.all_loads` | 8,437,909 | 1.0059 |
| `mem_load_retired.fb_hit` | 512,603 | 0.0611 |
| `mem_load_retired.l1_hit` | 55,616 | 0.0066 |
| `mem_load_retired.l2_hit` | 3,808,031 | 0.4540 |

## stream_write

regular stores: expect DRAM reads (read-for-ownership) as well as writes; work = 5.369e+08 bytes; cycles per unit = 9.057

| counter | value | per unit (load / line / FMA) |
|---|---|---|
| `l2_lines_out.non_silent` | 8,395,200 | 1.0008 |
| `uncore_imc/cas_count_read/` | 9,361,419 | 1.1160 |
| `uncore_imc/cas_count_write/` | 8,701,620 | 1.0373 |

## stream_write_nt

non-temporal stores: expect DRAM writes, no RFO reads; work = 5.369e+08 bytes; cycles per unit = 5.815

| counter | value | per unit (load / line / FMA) |
|---|---|---|
| `uncore_imc/cas_count_read/` | 57,346 | 0.0068 |
| `uncore_imc/cas_count_write/` | 8,406,890 | 1.0022 |

## fma512

register-only AVX-512 FMA throughput kernel; work = 1e+08 ops; cycles per unit = 0.502

| counter | value | per unit (load / line / FMA) |
|---|---|---|
| `fp_arith_inst_retired.512b_packed_single` | 199,999,872 | 2.0000 |
| `uops_dispatched.port_0` | 50,014,723 | 0.5001 |
| `uops_dispatched.port_1` | 283,352 | 0.0028 |
| `uops_dispatched.port_5_11` | 50,720,741 | 0.5072 |

