#!/bin/bash
source ../build-args.sh

ARG_LLAMACPP_REPO_URL="https://github.com/ggerganov/llama.cpp.git"
ARG_LLAMACPP_HIPBLAS_PULL_ID="1087"
ARG_LLAMACPP_HIPBLAS_PULL_HASH="c88c2a992a42d8fe40bc61e56dd44c7fade1c5a3"

docker_image_name="ulyssesrr/rocm-xtra-llamacpp"
docker_image_tag="pr${ARG_LLAMACPP_HIPBLAS_PULL_ID}_${ARG_LLAMACPP_HIPBLAS_PULL_HASH}_rocm${ARG_ROCM_VERSION}_ubuntu${ARG_UBUNTU_VERSION}"
