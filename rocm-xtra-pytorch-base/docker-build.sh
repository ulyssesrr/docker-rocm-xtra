#!/bin/bash
source ../build-args.sh

docker_image_name="ulyssesrr/rocm-xtra-pytorch-base"
docker_image_tag="rocm${ARG_ROCM_VERSION}_ubuntu${ARG_UBUNTU_VERSION}_pytorch${ARG_PYTORCH_VERSION}"

ARG_OPENBLAS_VERSION="0.3.23"
ARG_OPENBLAS_INSTALL_PREFIX="/usr"

docker_build \
  --build-arg "OPENBLAS_VERSION=$ARG_OPENBLAS_VERSION" \
  --build-arg "OPENBLAS_INSTALL_PREFIX=$ARG_OPENBLAS_INSTALL_PREFIX" \
  -t "$docker_image_name:$docker_image_tag" .