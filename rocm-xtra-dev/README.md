# Intro

A simple image with the rocm-dev package installed from repo.radeon.com. No kernel level components installed. It's meant to serve as a base ROCm image for downstream images to derive from with the dockerfile FROM statement. 

Built as:
[rocm/dev-ubuntu-20.04](https://hub.docker.com/r/rocm/dev-ubuntu-20.04) or [rocm/dev-ubuntu-22.04](https://hub.docker.com/r/rocm/dev-ubuntu-22.04) + fixes from [debrocm-xtra-builder-rocblas](../rocm-xtra-builder-rocblas)

# Usage

## Recommended aliases

```shell
alias drun='sudo docker run -it --network=host --device=/dev/kfd --device=/dev/dri --ipc=host --shm-size 16G --group-add video --cap-add=SYS_PTRACE --security-opt seccomp=unconfined -v $(pwd):/current'
```

## Usage
```shell
drun --pull=always --rm ulyssesrr/rocm-xtra-dev:latest
```
