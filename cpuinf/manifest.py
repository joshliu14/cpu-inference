"""Layer manifest: what every ResNet-50 operator computes and moves.

All quantities here are CALCULATED from shapes, not measured:
  flops         useful arithmetic of the textbook algorithm
                (conv/linear: 2 per multiply-accumulate; BN inference: 2 per
                element (x*scale + shift); ReLU/Add: 1; MaxPool kxk: k*k-1
                comparisons per output; global avgpool: 1 add per input)
  *_bytes       FP32 tensor sizes (4 bytes per element)
  min_traffic   input + weight + output bytes: the compulsory traffic if every
                tensor were read or written exactly once. Real kernels can move
                more (layout reorders, re-reads when tiles do not fit in cache)
                or less from DRAM (data already resident in cache).
  ai            arithmetic intensity = flops / min_traffic (FLOP/byte)
Execution order is captured from forward hooks, so downsample branches appear
where they actually run (after bn3 of the first block of a stage).
"""
from __future__ import annotations

import math

import torch
import torch.nn as nn

from .resnet import Add, leaf_modules

F32 = 4


def _op_kind(m: nn.Module) -> str:
    if isinstance(m, nn.Conv2d):
        k = m.kernel_size[0]
        return f"conv{k}x{k}"
    return {nn.BatchNorm2d: "batchnorm", nn.ReLU: "relu", nn.MaxPool2d: "maxpool", Add: "add",
            nn.AdaptiveAvgPool2d: "avgpool", nn.Flatten: "flatten", nn.Linear: "linear"}[type(m)]


def _stage(name: str) -> str:
    if name.startswith("layer"):
        return name.split(".")[0]
    return "head" if name in ("avgpool", "flatten", "fc") else "stem"


def _block(name: str) -> str:
    parts = name.split(".")
    return ".".join(parts[:2]) if name.startswith("layer") else parts[0]


def describe(name: str, m: nn.Module, inputs: list[torch.Tensor], out: torch.Tensor) -> dict:
    kind = _op_kind(m)
    x = inputs[0]
    in_elems = sum(t.numel() for t in inputs)
    out_elems = out.numel()
    params = sum(p.numel() for p in m.parameters())
    buffers = sum(b.numel() for b in m.buffers() if b.dtype.is_floating_point)
    rec = {
        "layer_name": name, "stage": _stage(name), "block": _block(name), "operation": kind,
        "input_shape": "x".join(map(str, x.shape)) + ("+" + "x".join(map(str, inputs[1].shape)) if len(inputs) > 1 else ""),
        "output_shape": "x".join(map(str, out.shape)),
        "kernel": "", "stride": "", "padding": "", "in_channels": x.shape[1] if x.dim() > 1 else "",
        "out_channels": out.shape[1] if out.dim() > 1 else "",
        "parameters": params,
    }
    if isinstance(m, nn.Conv2d):
        kh, kw = m.kernel_size
        n, co, ho, wo = out.shape
        macs = n * co * ho * wo * (m.in_channels // m.groups) * kh * kw
        flops = 2 * macs
        rec.update(kernel=f"{kh}x{kw}", stride=m.stride[0], padding=m.padding[0])
        # Equivalent GEMM view (im2col): M = output pixels, N = out channels, K = Cin*kh*kw
        rec.update(gemm_m=ho * wo * n, gemm_n=co, gemm_k=(m.in_channels // m.groups) * kh * kw)
    elif isinstance(m, nn.BatchNorm2d):
        flops = 2 * out_elems
    elif isinstance(m, nn.ReLU):
        flops = out_elems
    elif isinstance(m, nn.MaxPool2d):
        k = m.kernel_size if isinstance(m.kernel_size, int) else m.kernel_size[0]
        flops = out_elems * (k * k - 1)
        rec.update(kernel=f"{k}x{k}", stride=m.stride, padding=m.padding)
    elif isinstance(m, Add):
        flops = out_elems
    elif isinstance(m, nn.AdaptiveAvgPool2d):
        flops = in_elems
    elif isinstance(m, nn.Linear):
        flops = 2 * m.in_features * m.out_features + m.out_features
        rec.update(gemm_m=x.shape[0], gemm_n=m.out_features, gemm_k=m.in_features)
    else:  # flatten: a view, no arithmetic and no data movement
        flops = 0
    weight_bytes = (params + (buffers if isinstance(m, nn.BatchNorm2d) else 0)) * F32
    in_bytes = in_elems * F32
    out_bytes = out_elems * F32
    if isinstance(m, nn.Flatten):
        in_bytes = out_bytes = 0
    traffic = in_bytes + weight_bytes + out_bytes
    rec.update(flops=flops, input_bytes=in_bytes, weight_bytes=weight_bytes, output_bytes=out_bytes,
               min_traffic_bytes=traffic, arithmetic_intensity=(flops / traffic) if traffic else math.nan,
               working_set_bytes=traffic)
    return rec


@torch.inference_mode()
def build_manifest(model: nn.Module) -> list[dict]:
    records, handles = [], []
    for name, m in leaf_modules(model):
        def hook(mod, inp, out, name=name):
            records.append(describe(name, mod, list(inp), out))
        handles.append(m.register_forward_hook(hook))
    try:
        model(torch.randn(1, 3, 224, 224))
    finally:
        for h in handles:
            h.remove()
    for i, r in enumerate(records):
        r["exec_index"] = i
    return records
