ARG UBUNTU_VERSION

ARG ROCM_MAJOR_VERSION
ARG ROCM_MINOR_VERSION
ARG ROCM_PATCH_VERSION
ARG ROCM_BUILD_NUMBER
ARG ROCM_LIBPATCH_VERSION
ARG ROCM_VERSION

FROM rocm/dev-ubuntu-${UBUNTU_VERSION}:${ROCM_VERSION}-complete

LABEL org.opencontainers.image.authors="Ulysses R. Ribeiro <ulyssesrr@gmail.com>"

COPY deps /deps

RUN dpkg -i /deps/*.deb

COPY patches /patches

WORKDIR /git

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    git \
    && rm -rf /var/lib/apt/lists/*

ARG ROCM_VERSION

RUN git clone --depth 1 --branch rocm-${ROCM_VERSION} https://github.com/ROCmSoftwarePlatform/Tensile.git

RUN git clone --depth 1 --branch rocm-${ROCM_VERSION} https://github.com/ROCmSoftwarePlatform/rocBLAS.git

RUN git -C /git/Tensile apply /patches/22.tensile-gfx803-1.patch
RUN rm -rf /git/rocBLAS/library/src/blas3/Tensile/Logic/asm_full/r9nano*

COPY scripts /git/rocBLAS

WORKDIR /git/rocBLAS

ARG UBUNTU_VERSION
ARG ROCM_MAJOR_VERSION
ARG ROCM_MINOR_VERSION
ARG ROCM_PATCH_VERSION
ARG ROCM_BUILD_NUMBER
ARG ROCM_LIBPATCH_VERSION

ENV ROCM_PATH=/opt/rocm-${ROCM_VERSION}
ENV ROCM_MAJOR_VERSION=${ROCM_MAJOR_VERSION}
ENV ROCM_MINOR_VERSION=${ROCM_MINOR_VERSION}
ENV ROCM_PATCH_VERSION=${ROCM_PATCH_VERSION}
ENV ROCM_LIBPATCH_VERSION=${ROCM_LIBPATCH_VERSION}
ENV ROCM_PKGTYPE=DEB
ENV CPACK_DEBIAN_PACKAGE_RELEASE=${ROCM_BUILD_NUMBER}~${UBUNTU_VERSION}

CMD ["./rocblas-build-gfx803.sh"]