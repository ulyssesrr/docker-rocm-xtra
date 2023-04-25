#!/bin/bash

ARG_UBUNTU_VERSION="20.04"
ARG_ROCM_MAJOR_VERSION="5"
ARG_ROCM_MINOR_VERSION="4"
ARG_ROCM_PATCH_VERSION="3"

ROCM_VERSION="${ARG_ROCM_MAJOR_VERSION}.${ARG_ROCM_MINOR_VERSION}.${ARG_ROCM_PATCH_VERSION}"

ARG_ROCBLAS_BASE_URL="https://github.com/ulyssesrr/rocm-gfx803/releases/download/rocm-${ROCM_VERSION}-gfx803"
ARG_ROCBLAS_FILE="rocblas_2.46.0.50403-121.20.04_amd64.deb"
ARG_ROCBLAS_DEV_FILE="rocblas-dev_2.46.0.50403-121.20.04_amd64.deb"

docker_image_name="ulyssesrr/rocm-gfx803"
docker_image_tag="ubuntu${ARG_UBUNTU_VERSION}_rocm${ROCM_VERSION}"

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