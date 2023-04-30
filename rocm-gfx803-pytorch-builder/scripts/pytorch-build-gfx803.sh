#!/usr/bin/env bash
set -euxo pipefail

# requires docker run -v $(pwd):/current ...
mkdir -p /current/build

# build torch
cd /git/pytorch
python tools/amd_build/build_amd.py
python setup.py bdist_wheel
cp /git/pytorch/dist/*.whl /current/build

# Build torchvision
## install torch
pip install --no-cache-dir /git/pytorch/dist/torch-*.whl

## generate wheel
cd /git/vision
python setup.py bdist_wheel
cp /git/vision/dist/*.whl /current/build

echo "All Done!"