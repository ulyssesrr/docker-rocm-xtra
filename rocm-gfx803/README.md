# Intro

This repo hosts the docker images for PyTorch releases with ROCm backend support. 

The docker images been hosted in this registry are meant to run on gfx803 cards, however only the `Radeon RX 580` is currently tested.

# Usage

## Recommended aliases
```shell
alias drun='sudo docker run -it --network=host --device=/dev/kfd --device=/dev/dri --ipc=host --shm-size 16G --group-add video --cap-add=SYS_PTRACE --security-opt seccomp=unconfined -v $(pwd):/current'

alias udrun='drun -u $(id -u ${USER}):$(id -g ${USER})'
```
## Sample usage
```shell
[ulysses@ftl docker-rocm-gfx803]$ drun --rm ulyssesrr/rocm-gfx803-pytorch
root@ftl:/app# python3
Python 3.8.10 (default, Mar 15 2022, 12:22:08) 
[GCC 9.4.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import torch
>>> print(torch.__version__)
1.11.0a0+git503a092
```
# Acknowledgements
Based on the packages built by https://github.com/xuhuisheng/rocm-gfx803

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