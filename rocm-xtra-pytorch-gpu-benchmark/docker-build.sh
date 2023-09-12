#!/bin/bash
source ../build-args.sh

docker_image_name="ulyssesrr/rocm-xtra-pytorch-gpu-benchmark"
docker_image_tag="rocm${ARG_ROCM_VERSION}_ubuntu${ARG_UBUNTU_VERSION}_pytorch${ARG_PYTORCH_VERSION}"

docker_build \
  -t "$docker_image_name:$docker_image_tag" .
