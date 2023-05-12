# Intro

This repo hosts the docker images with ROCm backend support for the gfx803 architecture.


# Usage

## Recommended aliases

```shell
alias drun='sudo docker run -it --network=host --device=/dev/kfd --device=/dev/dri --ipc=host --shm-size 16G --group-add video --cap-add=SYS_PTRACE --security-opt seccomp=unconfined -v $(pwd):/current'
```

# Images
See each image README for details.

Image | Description | Docs
--- | --- | ---
[ulyssesrr/rocm-gfx803-pytorch][pytorch]<br />[![ulyssesrr/rocm-gfx803-pytorch][pytorch-badge]][pytorch] | PyTorch (OpenBLAS/MAGMA) | [README](rocm-gfx803-pytorch/README.md)
[ulyssesrr/rocm-gfx803-stable-diffusion-webui][stable-diffusion-webui]<br />[![ulyssesrr/rocm-gfx803-stable-diffusion-webui][stable-diffusion-webui-badge]][stable-diffusion-webui] | AUTOMATIC1111's Stable Diffusion Web UI | [README](rocm-gfx803-stable-diffusion-webui/README.md)

# Builder Images
TODO

# Debian & Python Packages (unsupported)

https://github.com/ulyssesrr/rocm-gfx803/releases

# Acknowledgements
Uses Xu Huisheng's [patches](https://github.com/xuhuisheng/rocm-gfx803) for rocBLAS

# gfx803 Cards
* Polaris 30
  * Radeon RX 590
* Polaris 20
  * Radeon Pro 580
  * Radeon RX 580
  * Radeon Pro 575
  * Radeon Pro 570
  * Radeon RX 570
* Polaris 10
  * Radeon Instinct MI6
  * Radeon Pro Duo 2017
  * Radeon Pro WX 7100
  * Radeon Pro WX 7100 Mobile
  * Radeon RX 480
  * Radeon Pro WX 5100
  * Radeon RX 470
* Polaris 21
  * Radeon Pro 560X
  * Radeon Pro 560
  * Radeon Pro 555X
  * Radeon Pro 555
* Polaris 11
  * Radeon Pro WX 4100
  * Radeon Pro WX 4170 Mobile
  * Radeon Pro WX 4150 Mobile
  * Radeon Pro WX 4130 Mobile
  * Radeon RX 560D
  * Radeon RX 460
* Fiji
  * Fiji XT
    * Radeon Instinct MI8
    * Radeon R9 Fury X
    * Radeon R9 Fury
    * Radeon R9 Nano
  * Capsaicin XT
    * FirePro S9300x2
    * Radeon Pro Duo 2016

[pytorch]: https://hub.docker.com/r/ulyssesrr/rocm-gfx803-pytorch
[pytorch-badge]: https://img.shields.io/docker/v/ulyssesrr/rocm-gfx803-pytorch?color=green
[stable-diffusion-webui]: https://hub.docker.com/r/ulyssesrr/rocm-gfx803-stable-diffusion-webui
[stable-diffusion-webui-badge]: https://img.shields.io/docker/v/ulyssesrr/rocm-gfx803-stable-diffusion-webui?color=green
