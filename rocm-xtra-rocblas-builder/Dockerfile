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

#COPY deps /deps

#RUN dpkg -i /deps/*.deb

WORKDIR /git

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    git \
    && rm -rf /var/lib/apt/lists/*

ARG ROCM_VERSION

RUN git clone --depth 1 --branch rocm-${ROCM_VERSION} https://github.com/ROCmSoftwarePlatform/Tensile.git

RUN git clone --depth 1 --branch rocm-${ROCM_VERSION} https://github.com/ROCmSoftwarePlatform/rocBLAS.git

# fix gfx803
RUN rm -rf /git/rocBLAS/library/src/blas3/Tensile/Logic/asm_full/r9nano*

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

COPY deps /deps
RUN dpkg -i /deps/*.deb && rm -rf /deps

COPY patches /patches
RUN git -C /git/Tensile apply /patches/Tensile-*.patch
RUN git -C /git/rocBLAS apply /patches/rocBLAS-*.patch

# configure
ARG ROCM_ARCH_SCSV

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive ./install.sh \
        --cmake_install \
        --dependencies \
        --test_local_path /git/Tensile \
        --architecture "${ROCM_ARCH_SCSV}" \
        --logic asm_full \
        --msgpack \
    && rm -rf /var/lib/apt/lists/*

RUN make -C build/release -j$(nproc) TENSILE_LIBRARY_TARGET
# # Copy debian package
# FROM rocm/dev-ubuntu-${UBUNTU_VERSION}:${ROCM_VERSION_DOCKER}-complete as rocblas-package-builder

# ARG ROCM_VERSION

# WORKDIR /rocblas-deb

# COPY --from=rocblas-builder /git/rocBLAS/build/release/*.deb .
# #COPY --from=rocblas-builder /git/rocBLAS/build/*.deb .


# Patch generated rocblas package
FROM rocm/dev-ubuntu-${UBUNTU_VERSION}:${ROCM_VERSION_DOCKER}-complete as rocblas-package-builder
ARG ROCM_VERSION

WORKDIR /rocblas-deb

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get download rocblas \
    && rm -rf /var/lib/apt/lists/*

# extract original deb
RUN mkdir extracted && dpkg-deb -R /rocblas-deb/rocblas_*.deb extracted

# remove broken gfx803 libraries
RUN rm -rf /rocblas-deb/extracted/opt/rocm-${ROCM_VERSION}/lib/rocblas/library/*gfx803*

# add gfx803 and gfx1010 libraries
COPY --from=rocblas-builder /git/rocBLAS/build/release/Tensile/library/* /rocblas-deb/extracted/opt/rocm-${ROCM_VERSION}/lib/rocblas/library/

# overwrite original .deb and delete extracted files
RUN chmod 0755 /rocblas-deb/extracted/DEBIAN/* \
    && dpkg-deb -b extracted /rocblas-deb/rocblas_*.deb \
    && rm -rf /rocblas-deb/extracted

