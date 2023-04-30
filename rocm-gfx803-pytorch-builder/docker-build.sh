#!/bin/bash
source ../build-args.sh

docker_image_name="ulyssesrr/rocm-gfx803-pytorch-builder"
docker_image_tag="ubuntu${ARG_UBUNTU_VERSION}-rocm${ARG_ROCM_VERSION}-complete"

echo "Building $docker_image_name:$docker_image_tag ..."
docker_build -t "$docker_image_name:$docker_image_tag" .