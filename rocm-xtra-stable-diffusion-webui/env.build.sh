#!/bin/bash
source ../build-args.sh

arg_stable_diffusion_ui_version=1.6.0
SD_SHORT_HASH=${arg_stable_diffusion_ui_version:0:7}
docker_image_name="ulyssesrr/rocm-xtra-stable-diffusion-webui"
docker_image_tag="${SD_SHORT_HASH}_rocm${ARG_ROCM_VERSION}_ubuntu${ARG_UBUNTU_VERSION}_pytorch${ARG_PYTORCH_VERSION}"