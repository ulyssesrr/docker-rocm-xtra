#!/usr/bin/env bash
set -euxo pipefail

./install.sh --install \
  --cmake_install \
  --dependencies \
  --test_local_path /git/Tensile \
  --architecture gfx803 \
  --logic asm_full \
  --cov V3 \
  --merge-architectures \
  --msgpack

# requires docker run -v $(pwd):/current ...
mkdir -p /current/build
cp /git/rocBLAS/build/release/*.deb /current/build

echo "All Done!"