"""Barebones, fully explicit ResNet-50 (inference only).

Every computation that matters for performance is its own nn.Module so it can
be hooked, timed and counted individually -- including the residual addition
and each ReLU, which torchvision folds into functional calls / shared modules.

ReLUs are in-place, exactly as in torchvision, so memory behaviour matches
the reference implementation.

The structure and parameter names match torchvision.models.resnet50 (the
"v1.5" variant: stride 2 on the 3x3 conv of each downsampling bottleneck), so
torchvision weights load directly and outputs can be compared numerically
(see validate_against_torchvision).
"""
from __future__ import annotations

import torch
import torch.nn as nn


class Add(nn.Module):
    """Residual addition as a module so it can be hooked like any other op.

    In-place (out += identity), exactly like torchvision's Bottleneck, so no
    new output tensor is allocated."""

    def forward(self, a: torch.Tensor, b: torch.Tensor) -> torch.Tensor:
        a += b
        return a


class Bottleneck(nn.Module):
    expansion = 4

    def __init__(self, inplanes: int, planes: int, stride: int = 1, downsample: nn.Module | None = None):
        super().__init__()
        width = planes
        self.conv1 = nn.Conv2d(inplanes, width, kernel_size=1, bias=False)
        self.bn1 = nn.BatchNorm2d(width)
        self.relu1 = nn.ReLU(inplace=True)
        self.conv2 = nn.Conv2d(width, width, kernel_size=3, stride=stride, padding=1, bias=False)
        self.bn2 = nn.BatchNorm2d(width)
        self.relu2 = nn.ReLU(inplace=True)
        self.conv3 = nn.Conv2d(width, planes * self.expansion, kernel_size=1, bias=False)
        self.bn3 = nn.BatchNorm2d(planes * self.expansion)
        self.downsample = downsample
        self.add = Add()
        self.relu3 = nn.ReLU(inplace=True)

    def forward(self, x: torch.Tensor) -> torch.Tensor:
        identity = x
        out = self.relu1(self.bn1(self.conv1(x)))
        out = self.relu2(self.bn2(self.conv2(out)))
        out = self.bn3(self.conv3(out))
        if self.downsample is not None:
            identity = self.downsample(x)
        out = self.add(out, identity)
        return self.relu3(out)


class ResNet50(nn.Module):
    def __init__(self, num_classes: int = 1000):
        super().__init__()
        self.inplanes = 64
        self.conv1 = nn.Conv2d(3, 64, kernel_size=7, stride=2, padding=3, bias=False)
        self.bn1 = nn.BatchNorm2d(64)
        self.relu = nn.ReLU(inplace=True)
        self.maxpool = nn.MaxPool2d(kernel_size=3, stride=2, padding=1)
        self.layer1 = self._make_layer(64, 3, stride=1)
        self.layer2 = self._make_layer(128, 4, stride=2)
        self.layer3 = self._make_layer(256, 6, stride=2)
        self.layer4 = self._make_layer(512, 3, stride=2)
        self.avgpool = nn.AdaptiveAvgPool2d((1, 1))
        self.flatten = nn.Flatten(1)
        self.fc = nn.Linear(512 * Bottleneck.expansion, num_classes)

    def _make_layer(self, planes: int, blocks: int, stride: int) -> nn.Sequential:
        downsample = None
        if stride != 1 or self.inplanes != planes * Bottleneck.expansion:
            downsample = nn.Sequential(
                nn.Conv2d(self.inplanes, planes * Bottleneck.expansion, kernel_size=1, stride=stride, bias=False),
                nn.BatchNorm2d(planes * Bottleneck.expansion),
            )
        layers = [Bottleneck(self.inplanes, planes, stride, downsample)]
        self.inplanes = planes * Bottleneck.expansion
        for _ in range(1, blocks):
            layers.append(Bottleneck(self.inplanes, planes))
        return nn.Sequential(*layers)

    def forward(self, x: torch.Tensor) -> torch.Tensor:
        x = self.maxpool(self.relu(self.bn1(self.conv1(x))))
        x = self.layer4(self.layer3(self.layer2(self.layer1(x))))
        return self.fc(self.flatten(self.avgpool(x)))


LEAF_TYPES = (nn.Conv2d, nn.BatchNorm2d, nn.ReLU, nn.MaxPool2d, Add, nn.AdaptiveAvgPool2d, nn.Flatten, nn.Linear)


def leaf_modules(model: nn.Module) -> list[tuple[str, nn.Module]]:
    """Leaf (compute) modules in registration order, which equals execution
    order for this model except that each downsample runs after conv3/bn3."""
    return [(n, m) for n, m in model.named_modules() if isinstance(m, LEAF_TYPES)]


def build(weights: str = "random", seed: int = 0) -> ResNet50:
    """weights: 'random' (seeded torchvision-style init) or 'imagenet'
    (torchvision IMAGENET1K_V1, downloaded on first use)."""
    import torchvision

    if weights == "imagenet":
        ref = torchvision.models.resnet50(weights=torchvision.models.ResNet50_Weights.IMAGENET1K_V1)
    else:
        torch.manual_seed(seed)
        ref = torchvision.models.resnet50(weights=None)
    model = ResNet50()
    missing, unexpected = model.load_state_dict(ref.state_dict(), strict=True)
    assert not missing and not unexpected
    return model.eval()


@torch.inference_mode()
def validate_against_torchvision(weights: str = "random", seed: int = 0) -> dict:
    """Structural + numerical equivalence check with torchvision's resnet50."""
    import torchvision

    torch.manual_seed(seed)
    ref = (torchvision.models.resnet50(weights=torchvision.models.ResNet50_Weights.IMAGENET1K_V1)
           if weights == "imagenet" else torchvision.models.resnet50(weights=None)).eval()
    model = ResNet50()
    model.load_state_dict(ref.state_dict(), strict=True)
    model.eval()
    x = torch.randn(1, 3, 224, 224, generator=torch.Generator().manual_seed(123))
    y_ref, y = ref(x), model(x)
    n_params = sum(p.numel() for p in model.parameters())
    n_params_ref = sum(p.numel() for p in ref.parameters())
    ref_shapes = {k: tuple(v.shape) for k, v in ref.state_dict().items()}
    our_shapes = {k: tuple(v.shape) for k, v in model.state_dict().items()}
    return {
        "params": n_params,
        "params_torchvision": n_params_ref,
        "state_dict_keys_identical": ref_shapes.keys() == our_shapes.keys(),
        "state_dict_shapes_identical": ref_shapes == our_shapes,
        "output_shape": tuple(y.shape),
        "max_abs_diff": float((y - y_ref).abs().max()),
        "top1_equal": bool(y.argmax() == y_ref.argmax()),
        "allclose_atol1e-5": bool(torch.allclose(y, y_ref, atol=1e-5, rtol=1e-5)),
    }
