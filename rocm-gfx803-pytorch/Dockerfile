ARG rocblas_package_file=rocblas.deb
ARG rocblas_base_url=https://github.com/xuhuisheng/rocm-gfx803/releases/download/rocm511
ARG rocblas_file=rocblas_2.43.0-490c4140.dirty_amd64.deb

ARG rocblas_search_version=2.43.0-490c4140~dirty
ARG rocblas_replace_version=2.43.0.50100-2.43.0~490c4140~dirty

### Stage: Patch the gfx803 rocblas package with the same version of the target to be replaced
# - TODO: automate version number in search & replace

FROM ubuntu:20.04 AS rocblas-patched-package

WORKDIR /packages

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends ca-certificates curl

ARG rocblas_base_url
ARG rocblas_file

RUN curl -sL $rocblas_base_url/$rocblas_file --output $rocblas_file

RUN dpkg-deb -x $rocblas_file rocblas-package

RUN dpkg-deb --control $rocblas_file rocblas-package/DEBIAN

ARG rocblas_search_version
ARG rocblas_replace_version

RUN sed -i "s/Version: ${rocblas_search_version}/Version: ${rocblas_replace_version}/g" rocblas-package/DEBIAN/control

RUN chmod -R 0755 rocblas-package/DEBIAN

ARG rocblas_package_file

RUN dpkg -b rocblas-package ${rocblas_package_file}

### Stage: rocm-gfx803-pytorch

FROM rocm/dev-ubuntu-20.04:5.1-complete as rocm-gfx803-pytorch

LABEL org.opencontainers.image.authors="Ulysses R. Ribeiro <ulyssesrr@gmail.com>"

WORKDIR /tmp

RUN ln -s /opt/rocm-5.1.0 /opt/rocm \
    && sh -c 'echo /opt/rocm/lib > /etc/ld.so.conf.d/rocm.conf' \
    && ldconfig
    
ARG rocblas_package_file

COPY --from=rocblas-patched-package /packages/${rocblas_package_file} ./

RUN dpkg -i ./${rocblas_package_file} \
    && rm -f ./${rocblas_package_file}

# install torch deps
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        libopenmpi3 \
        libopenblas0-openmp \
        && rm -rf /var/lib/apt/lists/*
        
# install pytorch
RUN pip install --no-cache-dir https://github.com/xuhuisheng/rocm-gfx803/releases/download/rocm500/torch-1.11.0a0+git503a092-cp38-cp38-linux_x86_64.whl

# install torchvision
RUN pip install --no-cache-dir https://github.com/xuhuisheng/rocm-gfx803/releases/download/rocm500/torchvision-0.12.0a0+2662797-cp38-cp38-linux_x86_64.whl

# install opencv
RUN pip install --no-cache-dir opencv-python==4.5.5.64

WORKDIR /app
