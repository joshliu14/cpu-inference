#!/usr/bin/env python3
"""Optimization experiments: one minimal change per variant, same measurement.

Each variant states a hypothesis grounded in a baseline measurement (see
docs/RESULTS.md). For every variant we check numerical equivalence with the
baseline output, then measure end-to-end latency (with cycles/instructions)
and a per-operator-type time breakdown (forward hooks on leaf modules).

Variants
  baseline              the canonical explicit model (NCHW / contiguous)
  maxpool_chlast        only the max-pool runs on a channels-last copy of its
                        input (convert -> pool -> convert back)
  fold_bn               BatchNorm folded into the preceding conv's weights/bias
                        (exact in inference; removes 53 BN operators)
  channels_last         whole model and input in channels-last memory format
  mkldnn_layout         torch.utils.mkldnn.to_mkldnn: tensors stay in oneDNN's
                        blocked layout between operators (no per-op reorders)
  fold_bn+chlast_pool   fold_bn and maxpool_chlast together

usage: opt_variants.py --cpu 6 --out DIR [--variants a,b,...] [--iters 100]
"""
import argparse
import collections
import copy
import os
import sys
import time

sys.path.insert(0, os.path.join(os.path.dirname(__file__), ".."))
from cpuinf import runtime  # noqa: E402

ap = argparse.ArgumentParser()
ap.add_argument("--cpu", type=int, default=None)
ap.add_argument("--out", required=True)
ap.add_argument("--variants", default="baseline,maxpool_chlast,fold_bn,channels_last,mkldnn_layout,fold_bn+chlast_pool")
ap.add_argument("--iters", type=int, default=100)
ap.add_argument("--warmup", type=int, default=15)
ap.add_argument("--op-iters", type=int, default=15)
args = ap.parse_args()
runtime.pin(args.cpu)
torch = runtime.configure_torch()
import torch.nn as nn  # noqa: E402
import torch.nn.functional as F  # noqa: E402

from cpuinf.perfcounters import CounterSession  # noqa: E402
from cpuinf.resnet import Bottleneck, build  # noqa: E402

os.makedirs(os.path.join(args.out, "raw"), exist_ok=True)
os.makedirs(os.path.join(args.out, "processed"), exist_ok=True)


class ChannelsLastMaxPool(nn.Module):
    def __init__(self, mp):
        super().__init__()
        self.mp = mp

    def forward(self, x):
        y = F.max_pool2d(x.contiguous(memory_format=torch.channels_last), self.mp.kernel_size,
                         self.mp.stride, self.mp.padding)
        return y.contiguous()


def fold_bn(model):
    from torch.nn.utils.fusion import fuse_conv_bn_eval
    m = copy.deepcopy(model)
    m.conv1 = fuse_conv_bn_eval(m.conv1, m.bn1)
    m.bn1 = nn.Identity()
    for mod in m.modules():
        if isinstance(mod, Bottleneck):
            for c, b in (("conv1", "bn1"), ("conv2", "bn2"), ("conv3", "bn3")):
                setattr(mod, c, fuse_conv_bn_eval(getattr(mod, c), getattr(mod, b)))
                setattr(mod, b, nn.Identity())
            if mod.downsample is not None:
                mod.downsample = nn.Sequential(fuse_conv_bn_eval(mod.downsample[0], mod.downsample[1]))
    return m


def make_variant(name, base, x):
    """-> (callable model, input tensor, output-to-dense function)"""
    dense = lambda y: y  # noqa: E731
    if name == "baseline":
        return base, x, dense
    if name == "maxpool_chlast":
        m = copy.deepcopy(base)
        m.maxpool = ChannelsLastMaxPool(m.maxpool)
        return m, x, dense
    if name == "fold_bn":
        return fold_bn(base), x, dense
    if name == "fold_bn+chlast_pool":
        m = fold_bn(base)
        m.maxpool = ChannelsLastMaxPool(m.maxpool)
        return m, x, dense
    if name == "channels_last":
        m = copy.deepcopy(base).to(memory_format=torch.channels_last)
        return m, x.contiguous(memory_format=torch.channels_last), dense
    if name == "mkldnn_layout":
        from torch.utils import mkldnn as mkldnn_utils
        m = mkldnn_utils.to_mkldnn(copy.deepcopy(base))
        return m, x.to_mkldnn(), lambda y: y.to_dense() if y.is_mkldnn else y
    raise ValueError(name)


def op_kind(mod):
    n = type(mod).__name__
    if "Conv" in n:
        k = mod.kernel_size[0] if hasattr(mod, "kernel_size") else "?"
        return f"conv{k}x{k}"
    return {"BatchNorm2d": "batchnorm", "ReLU": "relu", "MaxPool2d": "maxpool", "Add": "add",
            "AdaptiveAvgPool2d": "avgpool", "Linear": "linear", "ChannelsLastMaxPool": "maxpool",
            "Flatten": "flatten", "Identity": "identity"}.get(n, n)


def breakdown(m, xin):
    """Median per-op-type time over --op-iters forward passes (leaf hooks)."""
    leaves = [(n, mod) for n, mod in m.named_modules()
              if len(list(mod.children())) == 0 or isinstance(mod, ChannelsLastMaxPool)]
    leaves = [(n, mod) for n, mod in leaves if not any(n.startswith(p + ".") for p, q in leaves
                                                       if isinstance(q, ChannelsLastMaxPool))]
    t0s, acc = {}, collections.defaultdict(list)
    hs = []
    for n, mod in leaves:
        hs.append(mod.register_forward_pre_hook(lambda md, i, n=n: t0s.__setitem__(n, time.perf_counter_ns())))
        hs.append(mod.register_forward_hook(lambda md, i, o, n=n, k=op_kind(mod):
                                            acc[(k, n)].append(time.perf_counter_ns() - t0s[n])))
    with torch.inference_mode():
        for _ in range(args.op_iters):
            m(xin)
    for h in hs:
        h.remove()
    per_type = collections.defaultdict(float)
    for (k, n), v in acc.items():
        v = sorted(v)
        per_type[k] += v[len(v) // 2] / 1e6
    return dict(per_type)


base = build("random")
x = torch.randn(1, 3, 224, 224, generator=torch.Generator().manual_seed(123))
with torch.inference_mode():
    ref = base(x)
cs = CounterSession(["cycles", "instructions", "page-faults"])
summary = {"environment": runtime.environment_record(args.cpu), "variants": {}}
rows = []
for name in args.variants.split(","):
    m, xin, dense = make_variant(name, base, x)
    with torch.inference_mode():
        for _ in range(args.warmup):
            y = m(xin)
        diff = float((dense(y) - ref).abs().max())
        ms, cyc, ins, pf = [], [], [], []
        for i in range(args.iters):
            cs.start()
            t = time.perf_counter_ns()
            m(xin)
            dt = time.perf_counter_ns() - t
            c = cs.stop()
            ms.append(dt / 1e6)
            cyc.append(c["cycles"])
            ins.append(c["instructions"])
            pf.append(c["page-faults"])
            rows.append({"variant": name, "iter": i, "ms": dt / 1e6, "cycles": c["cycles"],
                         "instructions": c["instructions"], "page_faults": pf[-1]})
    try:
        bd = breakdown(m, xin)
    except Exception as e:  # noqa: BLE001
        bd = {"error": str(e)}
    s = runtime.summarize(ms)
    summary["variants"][name] = {"latency_ms": s, "cycles_median": sorted(cyc)[len(cyc) // 2],
                                 "instructions_median": sorted(ins)[len(ins) // 2],
                                 "ipc": sorted(ins)[len(ins) // 2] / sorted(cyc)[len(cyc) // 2],
                                 "page_faults_median": sorted(pf)[len(pf) // 2],
                                 "max_abs_diff_vs_baseline": diff, "per_op_type_ms": bd}
    print(f"{name:22s} median {s['median']:7.2f} ms  p5 {s['p5']:7.2f}  p95 {s['p95']:7.2f}  "
          f"IPC {summary['variants'][name]['ipc']:.2f}  max|diff| {diff:.2e}  "
          + " ".join(f"{k}={v:.2f}" for k, v in sorted(bd.items(), key=lambda kv: -kv[1]) if isinstance(v, float))[:200])

import csv  # noqa: E402

with open(os.path.join(args.out, "raw", "opt_iters.csv"), "w", newline="") as f:
    w = csv.DictWriter(f, fieldnames=list(rows[0].keys()))
    w.writeheader()
    w.writerows(rows)
runtime.dump_json(os.path.join(args.out, "processed", "opt_summary.json"), summary)
