#!/bin/bash
source ../build-args.sh

docker_image_name="ulyssesrr/rocm-gfx803-dev"
docker_image_tag="ubuntu${ARG_UBUNTU_VERSION}-rocm${ARG_ROCM_VERSION}-complete"