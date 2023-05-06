# Intro

This repo hosts the docker images for PyTorch releases with ROCm backend support. 

The docker images been hosted in this registry are meant to run on gfx803 cards, however only the *Radeon RX 580 8GB* is currently tested.

# Usage

## Recommended aliases

```shell
alias drun='sudo docker run -it --network=host --device=/dev/kfd --device=/dev/dri --ipc=host --shm-size 16G --group-add video --cap-add=SYS_PTRACE --security-opt seccomp=unconfined -v $(pwd):/current'
```

# Images
See each image README for details.

Image | Description | Docs
--- | --- | ---
pytorch | PyTorch (OpenBLAS/MAGMA) | [README](rocm-gfx803-pytorch/README.md)
stable-diffusion-webui | AUTOMATIC1111's Stable Diffusion Web UI | [README](rocm-gfx803-stable-diffusion-webui/README.md)

# Builder Images
TODO

# Debian & Python Packages (unsupported)

https://github.com/ulyssesrr/rocm-gfx803/releases

# Acknowledgements
Uses Xu Huisheng's [patches](https://github.com/xuhuisheng/rocm-gfx803) for rocBLAS

# gfx803 Cards
    Fiji
        Fiji XT
            Radeon Instinct MI8
            Radeon R9 Fury X
            Radeon R9 Fury
            Radeon R9 Nano
        Capsaicin XT
            FirePro S9300x2
            Radeon Pro Duo 2016
    Polaris 30
        Radeon RX 590
    Polaris 20
        Radeon Pro 580
        Radeon RX 580
        Radeon Pro 575
        Radeon Pro 570
        Radeon RX 570
    Polaris 10
        Radeon Instinct MI6
        Radeon Pro Duo 2017
        Radeon Pro WX 7100
        Radeon Pro WX 7100 Mobile
        Radeon RX 480
        Radeon Pro WX 5100
        Radeon RX 470
    Polaris 21
        Radeon Pro 560X
        Radeon Pro 560
        Radeon Pro 555X
        Radeon Pro 555
    Polaris 11
        Radeon Pro WX 4100
        Radeon Pro WX 4170 Mobile
        Radeon Pro WX 4150 Mobile
        Radeon Pro WX 4130 Mobile
        Radeon RX 560D
        Radeon RX 460
