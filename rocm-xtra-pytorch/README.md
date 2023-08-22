# Intro

Docker images for PyTorch (including OpenBLAS and MAGMA) with ROCm backend support.

# Usage

## Recommended aliases

```shell
alias drun='sudo docker run -it --network=host --device=/dev/kfd --device=/dev/dri --ipc=host --shm-size 16G --group-add video --cap-add=SYS_PTRACE --security-opt seccomp=unconfined -v $(pwd):/current'
```

## Sample usage

```shell
[ulysses@ftl docker-rocm-xtra]$ drun --pull=always --rm ulyssesrr/rocm-xtra-pytorch:latest
root@ftl:/app# python
Python 3.10.6 (main, Mar 10 2023, 10:55:28) [GCC 11.3.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import torch
>>> torch.__version__
'1.13.1'
>>> torch.cuda.get_device_name(torch.cuda.current_device())
'AMD Radeon RX 5700 XT'
>>> a = torch.randn(3, 3, device='cuda')
>>> a.svd()
torch.return_types.svd(
U=tensor([[-0.6892, -0.6190,  0.3767],
        [ 0.7124, -0.4838,  0.5083],
        [-0.1323,  0.6187,  0.7744]], device='cuda:0'),
S=tensor([1.7729, 1.4760, 0.5706], device='cuda:0'),
V=tensor([[-0.6071,  0.7628,  0.2229],
        [ 0.3171,  0.4897, -0.8122],
        [-0.7286, -0.4224, -0.5392]], device='cuda:0'))
>>> import torchvision
>>> torchvision.__version__
'0.14.1a0+5e8e2f1'
>>> import torchaudio
>>> torchaudio.__version__
'0.13.1+b90d798'
```
