#!/usr/bin/env bash
# Create the Python virtual environment used by every experiment.
# CPU-only PyTorch wheels come from download.pytorch.org/whl/cpu so that no CUDA
# libraries are pulled in.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

if [[ ! -x .venv/bin/python ]]; then
    python3 -m venv .venv
fi
.venv/bin/pip install -q --upgrade pip
.venv/bin/pip install -q --index-url https://download.pytorch.org/whl/cpu \
    "$(grep '^torch==' requirements.txt)" "$(grep '^torchvision==' requirements.txt)"
.venv/bin/pip install -q $(grep -vE '^(torch|torchvision)==' requirements.txt)
.venv/bin/python -c "import torch, torchvision; print('torch', torch.__version__, 'torchvision', torchvision.__version__, 'capability', torch.backends.cpu.get_cpu_capability())"
