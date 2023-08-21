# Intro

This repo hosts the docker images with ROCm backend support for extra architectures.

# Supported Architectures:

Image | Description
--- | ---
gfx803 | Uses workaround: https://github.com/ROCmSoftwarePlatform/rocBLAS/issues/1218
gfx900 | From upstream.
gfx906 | From upstream.
gfx908 | From upstream.
gfx90a | From upstream.
gfx1010 | Fixed https://github.com/ROCmSoftwarePlatform/Tensile/issues/1757
gfx1011 | Fixed https://github.com/ROCmSoftwarePlatform/Tensile/issues/1757
gfx1012 | Fixed https://github.com/ROCmSoftwarePlatform/Tensile/issues/1757
gfx1030 | From upstream.
gfx1100 | From upstream.
gfx1101 | From upstream.
gfx1102 | From upstream.

# Usage

## Recommended aliases

```shell
alias drun='sudo docker run -it --network=host --device=/dev/kfd --device=/dev/dri --ipc=host --shm-size 16G --group-add video --cap-add=SYS_PTRACE --security-opt seccomp=unconfined -v $(pwd):/current'
```

# Images
See each image README for details.

Images are being migrated to support all archs. Images where the name starts with `rocm-xtra` supports all architectures. Images starting with `rocm-gfx803` only support the gfx803 arch.

Image | Description | Docs
--- | --- | ---
[ulyssesrr/rocm-xtra-dev][llamacpp]<br />[![ulyssesrr/ulyssesrr/rocm-xtra-dev][devimage-badge]][devimage] | Base image for development | [README](rocm-xtra-dev/README.md)
[ulyssesrr/rocm-xtra-llamacpp][llamacpp]<br />[![ulyssesrr/ulyssesrr/rocm-xtra-llamacpp][llamacpp-badge]][llamacpp] | [llama.cpp + PR#1087](https://github.com/ggerganov/llama.cpp/pull/1087) | [README](rocm-xtra-llamacpp/README.md)
[ulyssesrr/rocm-gfx803-pytorch][pytorch]<br />[![ulyssesrr/rocm-gfx803-pytorch][pytorch-badge]][pytorch] | PyTorch (OpenBLAS/MAGMA) | [README](rocm-gfx803-pytorch/README.md)
[ulyssesrr/rocm-gfx803-stable-diffusion-webui][stable-diffusion-webui]<br />[![ulyssesrr/rocm-gfx803-stable-diffusion-webui][stable-diffusion-webui-badge]][stable-diffusion-webui] | AUTOMATIC1111's Stable Diffusion Web UI | [README](rocm-gfx803-stable-diffusion-webui/README.md)

# Builder Images
TODO
[devimage]: https://hub.docker.com/r/ulyssesrr/rocm-xtra-llamacpp
[devimage-badge]: https://img.shields.io/docker/v/ulyssesrr/rocm-xtra-dev?color=green
[pytorch]: https://hub.docker.com/r/ulyssesrr/rocm-gfx803-pytorch
[pytorch-badge]: https://img.shields.io/docker/v/ulyssesrr/rocm-gfx803-pytorch?color=green
[llamacpp]: https://hub.docker.com/r/ulyssesrr/rocm-xtra-llamacpp
[llamacpp-badge]: https://img.shields.io/docker/v/ulyssesrr/rocm-xtra-llamacpp?color=green
[stable-diffusion-webui]: https://hub.docker.com/r/ulyssesrr/rocm-gfx803-stable-diffusion-webui
[stable-diffusion-webui-badge]: https://img.shields.io/docker/v/ulyssesrr/rocm-gfx803-stable-diffusion-webui?color=green
