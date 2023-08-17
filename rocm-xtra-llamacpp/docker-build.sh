#!/bin/bash
source env.build.sh

docker_build \
  --build-arg "LLAMACPP_REPO_URL=$ARG_LLAMACPP_REPO_URL" \
  --build-arg "LLAMACPP_HIPBLAS_PULL_ID=$ARG_LLAMACPP_HIPBLAS_PULL_ID" \
  --build-arg "LLAMACPP_HIPBLAS_PULL_HASH=$ARG_LLAMACPP_HIPBLAS_PULL_HASH" \
  -t "$docker_image_name:$docker_image_tag" .
