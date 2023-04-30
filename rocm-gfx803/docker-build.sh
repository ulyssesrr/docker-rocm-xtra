#!/bin/bash
source ../build-args.sh

docker_image_name="ulyssesrr/rocm-dev-gfx803"
docker_image_tag="ubuntu${ARG_UBUNTU_VERSION}-rocm${ROCM_VERSION}-complete"

docker build \
  --build-arg "UBUNTU_VERSION=$ARG_UBUNTU_VERSION" \
  --build-arg "ROCM_MAJOR_VERSION=$ARG_ROCM_MAJOR_VERSION" \
  --build-arg "ROCM_MINOR_VERSION=$ARG_ROCM_MINOR_VERSION" \
  --build-arg "ROCM_PATCH_VERSION=$ARG_ROCM_PATCH_VERSION" \
  --build-arg "ROCM_VERSION=$ROCM_VERSION" \
  --build-arg "ROCBLAS_BASE_URL=$ARG_ROCBLAS_BASE_URL" \
  --build-arg "ROCBLAS_FILE=$ARG_ROCBLAS_FILE" \
  --build-arg "ROCBLAS_DEV_FILE=$ARG_ROCBLAS_DEV_FILE" \
  -t "$docker_image_name:$docker_image_tag" .