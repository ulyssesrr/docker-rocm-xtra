#!/bin/bash
source ../build-args.sh

docker_image_name="ulyssesrr/rocm-xtra-dev"
docker_image_tag="ubuntu${ARG_UBUNTU_VERSION}-rocm${ARG_ROCM_VERSION}-complete"