# Intro

AUTOMATIC1111's Stable Diffusion Web UI Docker Image for ROCm (supporting extra architectures).

# Usage

## Create `drun` alias (if it doesn't exist yet)
```shell
alias drun='sudo docker run -it --network=host --device=/dev/kfd --device=/dev/dri --ipc=host --shm-size 16G --group-add video --cap-add=SYS_PTRACE --security-opt seccomp=unconfined -v $HOME/dockerx:/dockerx -v $(pwd):/current'
```

## Run container with `--medvram`
```shell
drun --pull=always --rm \
    -v $(pwd)/cache:/root/.cache \
    -v $(pwd)/data:/stable-diffusion-webui/data \
    -v $(pwd)/outputs:/stable-diffusion-webui/outputs \
    ulyssesrr/rocm-xtra-stable-diffusion-webui:latest \
    --medvram
```
