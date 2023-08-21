ARG UBUNTU_VERSION

ARG ROCM_MAJOR_VERSION
ARG ROCM_MINOR_VERSION
ARG ROCM_PATCH_VERSION
ARG ROCM_BUILD_NUMBER
ARG ROCM_LIBPATCH_VERSION
ARG ROCM_VERSION
ARG ROCM_VERSION_DOCKER

FROM rocm/dev-ubuntu-${UBUNTU_VERSION}:${ROCM_VERSION_DOCKER}-complete as rocblas-builder

LABEL org.opencontainers.image.authors="Ulysses R. Ribeiro <ulyssesrr@gmail.com>"


WORKDIR /src

ARG ROCM_VERSION
RUN --mount=type=cache,target=/tmp/cache/download,rw \
    curl -L -o /tmp/cache/download/rocBLAS-${ROCM_VERSION}.tar.gz https://github.com/ROCmSoftwarePlatform/rocBLAS/archive/rocm-${ROCM_VERSION}.tar.gz \
    && tar -xf /tmp/cache/download/rocBLAS-${ROCM_VERSION}.tar.gz -C /src \
    && rm -f /tmp/cache/download/rocBLAS-${ROCM_VERSION}.tar.gz

RUN --mount=type=cache,target=/tmp/cache/download,rw \
    curl -L -o /tmp/cache/download/Tensile-${ROCM_VERSION}.tar.gz https://github.com/ROCmSoftwarePlatform/Tensile/archive/rocm-${ROCM_VERSION}.tar.gz \
    && tar -xvf /tmp/cache/download/Tensile-${ROCM_VERSION}.tar.gz -C /src \
    && rm -f /tmp/cache/download/Tensile-${ROCM_VERSION}.tar.gz

# fix gfx803
RUN rm -rf /src/rocBLAS-rocm-${ROCM_VERSION}/library/src/blas3/Tensile/Logic/asm_full/r9nano*

WORKDIR /src/rocBLAS-rocm-${ROCM_VERSION}

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


COPY patches /patches
RUN patch -Np1 -d /src/Tensile-rocm-${ROCM_VERSION} -i /patches/Tensile-fix-fallback-arch-build.patch
RUN patch -Np1 -d /src/rocBLAS-rocm-${ROCM_VERSION} -i /patches/rocBLAS-configure-but-dont-build.patch

# configure
ARG ROCM_ARCH_SCSV

RUN --mount=type=cache,target=/var/cache/apt,rw --mount=type=cache,target=/var/lib/apt,rw \
    apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends cmake \
    && DEBIAN_FRONTEND=noninteractive ./install.sh \
        --cmake_install \
        --dependencies \
        --test_local_path /src/Tensile-rocm-${ROCM_VERSION} \
        --architecture "${ROCM_ARCH_SCSV}" \
        --logic asm_full \
        --msgpack \
    && rm -rf /var/lib/apt/lists/*

RUN make -C build/release -j$(nproc) TENSILE_LIBRARY_TARGET
# # Copy debian package
# FROM rocm/dev-ubuntu-${UBUNTU_VERSION}:${ROCM_VERSION_DOCKER}-complete as rocblas-package-builder

# ARG ROCM_VERSION

# WORKDIR /deb

# COPY --from=rocblas-builder /src/rocBLAS-rocm-${ROCM_VERSION}/build/release/*.deb .
# #COPY --from=rocblas-builder /src/rocBLAS-rocm-${ROCM_VERSION}/build/*.deb .


# Patch generated rocblas package
FROM rocm/dev-ubuntu-${UBUNTU_VERSION}:${ROCM_VERSION_DOCKER}-complete as rocblas-package-builder
ARG ROCM_VERSION

WORKDIR /deb

RUN --mount=type=cache,target=/var/cache/apt,rw --mount=type=cache,target=/var/lib/apt,rw \
    apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get download rocblas \
    && rm -rf /var/lib/apt/lists/*

# extract original deb
RUN mkdir extracted && dpkg-deb -R /deb/rocblas_*.deb extracted

# remove broken gfx803 libraries
RUN rm -rf /deb/extracted/opt/rocm-${ROCM_VERSION}/lib/rocblas/library/*gfx803*

# add gfx803 and gfx1010 libraries
COPY --from=rocblas-builder /src/rocBLAS-rocm-${ROCM_VERSION}/build/release/Tensile/library/* /deb/extracted/opt/rocm-${ROCM_VERSION}/lib/rocblas/library/

# overwrite original .deb and delete extracted files
RUN chmod 0755 /deb/extracted/DEBIAN/* \
    && dpkg-deb -Zxz -b extracted /deb/rocblas_*.deb \
    && rm -rf /deb/extracted

