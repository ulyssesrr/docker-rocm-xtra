#!/bin/bash
source ../build-args.sh

docker_image_name="ulyssesrr/rocm-xtra-pytorch"
docker_image_tag="rocm${ARG_ROCM_VERSION}_ubuntu${ARG_UBUNTU_VERSION}_pytorch${ARG_PYTORCH_VERSION}"