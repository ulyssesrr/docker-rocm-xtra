#!/bin/bash
source ../build-args.sh

ARG_LLAMACPP_REPO_URL="https://github.com/ggerganov/llama.cpp.git"
ARG_LLAMACPP_COMMIT_ID="NOT IN USE"
ARG_LLAMACPP_HIPBLAS_PULL_ID="1087"
ARG_LLAMACPP_HIPBLAS_PULL_HASH="8bab456"

docker_image_name="ulyssesrr/rocm-gfx803-llamacpp"
docker_image_tag="pr${ARG_LLAMACPP_HIPBLAS_PULL_ID}_${ARG_LLAMACPP_HIPBLAS_PULL_HASH}_rocm${ARG_ROCM_VERSION}_ubuntu${ARG_UBUNTU_VERSION}"
