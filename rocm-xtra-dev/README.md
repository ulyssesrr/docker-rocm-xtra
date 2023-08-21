# Intro

A simple image with the rocm-dev package installed from repo.radeon.com. No kernel level components installed. It's meant to serve as a base ROCm image for downstream images to derive from with the dockerfile FROM statement. 

Built as:
[rocm/dev-ubuntu-20.04](https://hub.docker.com/r/rocm/dev-ubuntu-20.04) or [rocm/dev-ubuntu-22.04](https://hub.docker.com/r/rocm/dev-ubuntu-22.04) + fixes from [debrocm-xtra-builder-rocblas](../rocm-xtra-builder-rocblas)

# Usage

## Recommended aliases

```shell
alias drun='sudo docker run -it --network=host --device=/dev/kfd --device=/dev/dri --ipc=host --shm-size 16G --group-add video --cap-add=SYS_PTRACE --security-opt seccomp=unconfined -v $(pwd):/current'
```

## Sample usage
```shell
[ulysses@ftl rocm-xtra-dev]$ drun  --pull=always --rm ulyssesrr/rocm-xtra-dev:ubuntu22.04-rocm5.5.1-complete
root@ftl:/app# ls -1 /opt/rocm/lib/rocblas/library/TensileLibrary_lazy_gfx*
/opt/rocm/lib/rocblas/library/TensileLibrary_lazy_gfx1010.dat
/opt/rocm/lib/rocblas/library/TensileLibrary_lazy_gfx1011.dat
/opt/rocm/lib/rocblas/library/TensileLibrary_lazy_gfx1012.dat
/opt/rocm/lib/rocblas/library/TensileLibrary_lazy_gfx1030.dat
/opt/rocm/lib/rocblas/library/TensileLibrary_lazy_gfx1100.dat
/opt/rocm/lib/rocblas/library/TensileLibrary_lazy_gfx1101.dat
/opt/rocm/lib/rocblas/library/TensileLibrary_lazy_gfx1102.dat
/opt/rocm/lib/rocblas/library/TensileLibrary_lazy_gfx803.dat
/opt/rocm/lib/rocblas/library/TensileLibrary_lazy_gfx900.dat
/opt/rocm/lib/rocblas/library/TensileLibrary_lazy_gfx906.dat
/opt/rocm/lib/rocblas/library/TensileLibrary_lazy_gfx908.dat
/opt/rocm/lib/rocblas/library/TensileLibrary_lazy_gfx90a.dat
```
