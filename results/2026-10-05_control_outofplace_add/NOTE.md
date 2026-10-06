# Control: residual Add implemented out-of-place

This run used an earlier version of `cpuinf/resnet.py` whose `Add` module
computed `a + b` (allocating a new output tensor) instead of torchvision's
in-place `out += identity`. It is kept as a control experiment:

| run | median ms |
|---|---|
| explicit model, out-of-place Add | 99.77 |
| torchvision resnet50 (in-place add) | 98.38 |
| explicit model, ImageNet weights, out-of-place Add | 99.22 |

The ~1.4 ms difference is attributed (INFERRED) to allocating and writing 16
fresh residual-output tensors per inference. The canonical baseline uses the
in-place Add. The op_profile part of this run stopped at the `loads` pass
(event-group scheduling error, since fixed); passes time/blocktime/core/sw/
topdown/flops completed and are valid for the out-of-place variant.
