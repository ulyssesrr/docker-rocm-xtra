This image is used to build a patched rocBLAS debian package for the gfx803 architecture.

# Usage

```shell
drun --rm ulyssesrr/rocm-xtra-rocblas-builder:latest bash -c 'cp /rocblas-deb/rocblas*.deb /current/build'
```

# Acknowledgements

Based on the patches by https://github.com/xuhuisheng/rocm-build/tree/master/gfx803

# Patched Issues

- https://github.com/ROCmSoftwarePlatform/rocBLAS/issues/1218
