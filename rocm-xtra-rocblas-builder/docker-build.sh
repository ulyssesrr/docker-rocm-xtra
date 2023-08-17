#!/bin/bash
source ../build-args.sh

docker_image_name="ulyssesrr/rocm-xtra-rocblas-builder"
docker_image_tag="ubuntu${ARG_UBUNTU_VERSION}_rocm${ARG_ROCM_VERSION}"
docker_build -t "$docker_image_name:$docker_image_tag" .