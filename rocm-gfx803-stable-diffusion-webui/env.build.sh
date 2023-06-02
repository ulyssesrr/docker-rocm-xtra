#!/bin/bash
source ../build-args.sh

arg_stable_diffusion_commit=22bcc7be428c94e9408f589966c2040187245d81
SD_SHORT_HASH=${arg_stable_diffusion_commit:0:7}
docker_image_name="ulyssesrr/rocm-gfx803-stable-diffusion-webui"
docker_image_tag="${SD_SHORT_HASH}_rocm${ARG_ROCM_VERSION}_ubuntu${ARG_UBUNTU_VERSION}_py${ARG_PYTHON_VERSION}_pytorch${ARG_PYTORCH_VERSION}"