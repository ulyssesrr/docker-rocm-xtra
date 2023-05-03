#!/bin/bash
source ../build-args.sh

drun() {
   sudo docker run -it --network=host --device=/dev/kfd --device=/dev/dri --ipc=host --shm-size 16G --group-add video --cap-add=SYS_PTRACE --security-opt seccomp=unconfined -v $HOME/dockerx:/dockerx -v $(pwd):/current "$@"
}

docker_image_name="ulyssesrr/rocm-gfx803-pytorch-builder"
docker_image_tag="ubuntu${ARG_UBUNTU_VERSION}-rocm${ARG_ROCM_VERSION}-complete"

drun --rm "$docker_image_name:$docker_image_tag" "$@"