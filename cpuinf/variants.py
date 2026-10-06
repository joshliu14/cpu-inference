"""Model variants for the optimization experiments (one change each).

Shared by experiments/opt_variants.py (single core), opt_mechanisms.py and
multicore.py so that every experiment builds exactly the same models.
'baseline' is always the canonical explicit ResNet-50, unchanged.

  baseline              canonical explicit model (NCHW / contiguous, eager)
  maxpool_chlast        only the max-pool runs on a channels-last copy of its
                        input (convert -> pool -> convert back)
  fold_bn               BatchNorm folded into the preceding conv's weights/bias
  fold_bn+chlast_pool   fold_bn and maxpool_chlast together
  channels_last         whole model and input in channels-last memory format
  fold_bn+channels_last fold_bn, then the whole model in channels-last
  mkldnn_layout         torch.utils.mkldnn.to_mkldnn: oneDNN blocked tensors
                        between operators
  jit_trace             torch.jit.trace only (same ATen ops as baseline, but
                        executed by the TorchScript interpreter: no Python
                        nn.Module calls) -- isolates Python overhead
  jit_freeze            torch.jit.trace -> freeze -> optimize_for_inference
  inductor              torch.compile(backend="inductor"), inductor freezing on
"""
import copy

import torch
import torch.nn as nn
import torch.nn.functional as F

from cpuinf.resnet import Bottleneck

VARIANTS = ["baseline", "maxpool_chlast", "fold_bn", "channels_last", "mkldnn_layout", "fold_bn+chlast_pool",
            "fold_bn+channels_last", "jit_freeze", "inductor"]


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
    if name == "fold_bn+channels_last":
        m = fold_bn(base).to(memory_format=torch.channels_last)
        return m, x.contiguous(memory_format=torch.channels_last), dense
    if name == "jit_trace":
        with torch.inference_mode(False), torch.no_grad():
            tm = torch.jit.trace(copy.deepcopy(base).eval(), x)
        return tm, x, dense
    if name == "jit_freeze":
        with torch.inference_mode(False), torch.no_grad():
            tm = torch.jit.trace(copy.deepcopy(base).eval(), x)
            tm = torch.jit.optimize_for_inference(torch.jit.freeze(tm))
        return tm, x, dense
    if name == "inductor":
        import torch._inductor.config as icfg
        icfg.freezing = True
        m = torch.compile(copy.deepcopy(base).eval(), backend="inductor")
        return m, x, dense
    if name == "mkldnn_layout":
        from torch.utils import mkldnn as mkldnn_utils
        m = mkldnn_utils.to_mkldnn(copy.deepcopy(base))
        return m, x.to_mkldnn(), lambda y: y.to_dense() if y.is_mkldnn else y
    raise ValueError(name)


