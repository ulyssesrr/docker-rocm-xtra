# Intro

Docker images for PyTorch (including OpenBLAS and MAGMA) with ROCm backend support.

# Usage

## Recommended aliases

```shell
alias drun='sudo docker run -it --network=host --device=/dev/kfd --device=/dev/dri --ipc=host --shm-size 16G --group-add video --cap-add=SYS_PTRACE --security-opt seccomp=unconfined -v $(pwd):/current'
```

## Sample usage

```shell
[ulysses@ftl docker-rocm-xtra]$ drun --rm ulyssesrr/rocm-xtra-pytorch
root@ftl:/app# python3
Python 3.8.10 (default, Mar 13 2023, 10:26:41) 
[GCC 9.4.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import torch
>>> print(torch.__version__)
1.13.1
>>> torch.cuda.get_device_name(torch.cuda.current_device())
'Radeon RX 580 Series'
>>> a = torch.randn(3, 3, device='cuda')
>>> a.svd()
torch.return_types.svd(
U=tensor([[-0.0894,  0.2031,  0.9751],
        [ 0.5636, -0.7969,  0.2176],
        [ 0.8212,  0.5690, -0.0433]], device='cuda:0'),
S=tensor([2.5529, 1.8354, 0.1961], device='cuda:0'),
V=tensor([[ 0.7216, -0.4800,  0.4989],
        [-0.6366, -0.1771,  0.7506],
        [-0.2719, -0.8592, -0.4333]], device='cuda:0'))
```
