# cpu-inference

An evidence-based performance model of **barebones ResNet-50 inference on one
CPU core**, traced from Python down to the microarchitecture:

```
Python -> PyTorch nn.Module -> dispatcher -> ATen -> oneDNN / MKL / ATen native kernels
       -> machine instructions (AVX-512 FMA, loads, stores, ...) -> execution ports
       -> L1 -> L2 -> L3 -> DRAM
```

Batch 1, 3x224x224, FP32, inference only, one thread pinned to one core, no
torch.compile / quantization / fusion in the baseline.

**Start here:** [docs/RESULTS.md](docs/RESULTS.md) (findings) and
[docs/EXPERIMENT_GUIDE.md](docs/EXPERIMENT_GUIDE.md) (how to run and read
every experiment).

## Target machine

CloudLab Dell PowerEdge C6620, Intel Xeon Gold 5512U (28 cores, SMT off,
1 socket), turbo off -> fixed 2.1 GHz, 8 x DDR5-4800, Ubuntu 24.04,
Linux 6.8, GCC 13.3, Python 3.12, PyTorch 2.14.1+cpu (oneDNN 3.12, MKL 2024.2),
perf 6.8. Full inventory: `results/2026-10-05_system/SYSTEM.md`.

## Quick start

```bash
scripts/setup_env.sh                 # venv with pinned CPU-only PyTorch
make -C microbench                   # native microbenchmarks
BENCH_CPU=6 scripts/run_all.sh       # the whole measurement ladder (~1 h)
```

Or step by step:

| Step | Script | Output |
|---|---|---|
| System discovery | `scripts/collect_system_info.sh` | `results/<date>_system/` |
| Perf event discovery | `scripts/discover_perf_events.py` | `results/perf_events.json` |
| Native baselines (Level 6) | `scripts/run_microbench.sh` | `results/<date>_microbench/` |
| Counter validation | `scripts/run_counter_validation.sh` | `results/<date>_counter_validation/` |
| ResNet-50 Levels 0-3, 5 | `scripts/run_resnet_baseline.sh` | `results/<date>_resnet_baseline/` |
| Backend path | `scripts/run_backend_probe.sh` | `results/<date>_backend/` |
| Instructions (Level 4) | `scripts/run_instruction_profile.sh` | `results/<date>_instruction_profile/` |
| Dispatch overhead | `scripts/run_dispatch_overhead.sh` | `results/<date>_dispatch_overhead/` |

## Layout

```
cpuinf/        model + measurement library
  resnet.py      explicit ResNet-50 (every op a hookable module; == torchvision)
  manifest.py    per-layer shapes, FLOPs, bytes, arithmetic intensity
  perfcounters.py in-process perf_event_open (ctypes), group planning, uncore
  events.py      event catalog (candidates + interpretation); metrics.py derived metrics
  runtime.py     single-thread / pinning setup, statistics
experiments/   e2e_latency, op_profile, backend_probe, dispatch_overhead,
               infer_loop (perf target), validate_counters, opt_* (optimizations)
microbench/    C/C++ baselines: compute, memlat, membw, intensity, flags_kernels
analysis/      analysis + plotting for each experiment
scripts/       runners (one per experiment) and perf wrapper
results/       timestamped result directories: raw/ processed/ plots/
docs/          EXPERIMENT_GUIDE, INTERPRETATION_GUIDE, HARDWARE_GUIDE,
               PERF_GUIDE, RESEARCH_LOG, RESULTS
```

Conventions: results are never overwritten (timestamped directories);
every claim is labelled OBSERVED / CALCULATED / INFERRED / UNKNOWN;
unavailable measurements are reported as `UNAVAILABLE`, never as 0.
