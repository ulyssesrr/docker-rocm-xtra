#!/bin/bash
source ../build-args.sh

docker_image_name="ulyssesrr/rocm-gfx803-rocblas-builder"
docker_image_tag="ubuntu${ARG_UBUNTU_VERSION}_rocm${ARG_ROCM_VERSION}"
docker build \
  --build-arg "UBUNTU_VERSION=$ARG_UBUNTU_VERSION" \
  --build-arg "ROCM_MAJOR_VERSION=$ARG_ROCM_MAJOR_VERSION" \
  --build-arg "ROCM_MINOR_VERSION=$ARG_ROCM_MINOR_VERSION" \
  --build-arg "ROCM_PATCH_VERSION=$ARG_ROCM_PATCH_VERSION" \
  --build-arg "ROCM_BUILD_NUMBER=$ARG_ROCM_BUILD_NUMBER" \
  --build-arg "ROCM_LIBPATCH_VERSION=$ARG_ROCM_LIBPATCH_VERSION" \
  --build-arg "ROCM_VERSION=$ARG_ROCM_VERSION" \
  -t "$docker_image_name:$docker_image_tag" .