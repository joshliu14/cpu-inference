"""Single-core runtime setup shared by every PyTorch experiment.

Import this module BEFORE importing torch: OMP/MKL read their thread-count
environment variables when the libraries initialise.
"""
from __future__ import annotations

import json
import os
import platform
import statistics
import subprocess
import time

for _v in ("OMP_NUM_THREADS", "MKL_NUM_THREADS", "OPENBLAS_NUM_THREADS", "NUMEXPR_NUM_THREADS"):
    os.environ.setdefault(_v, "1")

T_PROCESS_START = time.perf_counter()


def pin(cpu: int | None) -> list[int]:
    """Pin this process to one CPU (equivalent to taskset -c CPU)."""
    if cpu is not None:
        os.sched_setaffinity(0, {cpu})
    return sorted(os.sched_getaffinity(0))


def configure_torch(threads: int = 1):
    """threads=1 is the baseline; >1 only for the thread-scaling experiment
    (then OMP_NUM_THREADS must also be set by the caller before import)."""
    import torch

    torch.set_num_threads(threads)
    try:
        torch.set_num_interop_threads(1)
    except RuntimeError:
        pass  # can only be set once, before any inter-op work
    torch.set_grad_enabled(False)
    return torch


def environment_record(cpu: int | None) -> dict:
    import torch
    import torchvision

    return {
        "time": time.strftime("%Y-%m-%dT%H:%M:%S%z"),
        "host": platform.node(),
        "affinity": sorted(os.sched_getaffinity(0)),
        "requested_cpu": cpu,
        "torch": torch.__version__,
        "torchvision": torchvision.__version__,
        "torch_num_threads": torch.get_num_threads(),
        "torch_num_interop_threads": torch.get_num_interop_threads(),
        "cpu_capability": torch.backends.cpu.get_cpu_capability(),
        "mkldnn_enabled": torch.backends.mkldnn.enabled,
        "env": {k: os.environ.get(k) for k in ("OMP_NUM_THREADS", "MKL_NUM_THREADS", "ONEDNN_VERBOSE",
                                                 "DNNL_VERBOSE", "MKL_VERBOSE", "ONEDNN_JIT_PROFILE")},
        "process_threads": len(os.listdir("/proc/self/task")),
        "loadavg": open("/proc/loadavg").read().strip(),
        "git_commit": subprocess.run(["git", "rev-parse", "--short", "HEAD"], capture_output=True,
                                     text=True, cwd=os.path.dirname(__file__)).stdout.strip(),
    }


def summarize(values: list[float]) -> dict:
    """median, mean, stddev, min, max, p5, p95 (nearest-rank on sorted data)."""
    v = sorted(values)
    n = len(v)

    def pct(p):
        return v[min(n - 1, max(0, round(p / 100 * (n - 1))))]

    return {
        "n": n, "median": statistics.median(v), "mean": statistics.fmean(v),
        "stddev": statistics.stdev(v) if n > 1 else 0.0, "min": v[0], "max": v[-1],
        "p5": pct(5), "p95": pct(95),
        "cv": (statistics.stdev(v) / statistics.fmean(v)) if n > 1 and statistics.fmean(v) else 0.0,
    }


def dump_json(path, obj):
    with open(path, "w") as f:
        json.dump(obj, f, indent=2, default=str)
        f.write("\n")
