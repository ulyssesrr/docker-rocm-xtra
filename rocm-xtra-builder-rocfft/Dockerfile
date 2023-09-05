ARG UBUNTU_VERSION

ARG ROCM_MAJOR_VERSION
ARG ROCM_MINOR_VERSION
ARG ROCM_PATCH_VERSION
ARG ROCM_BUILD_NUMBER
ARG ROCM_LIBPATCH_VERSION
ARG ROCM_VERSION
ARG ROCM_VERSION_DOCKER

FROM rocm/dev-ubuntu-${UBUNTU_VERSION}:${ROCM_VERSION_DOCKER}-complete

LABEL org.opencontainers.image.authors="Ulysses R. Ribeiro <ulyssesrr@gmail.com>"

# rocFFT deps
RUN --mount=type=cache,target=/var/cache/apt,rw --mount=type=cache,target=/var/lib/apt,rw \
    apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    make \
    pkg-config \
    cmake \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /src

ARG ROCM_VERSION
RUN --mount=type=cache,target=/tmp/cache/download,rw \
    curl -L -o /tmp/cache/download/rocFFT-${ROCM_VERSION}.tar.gz https://github.com/ROCmSoftwarePlatform/rocFFT/archive/rocm-${ROCM_VERSION}.tar.gz \
    && tar -xf /tmp/cache/download/rocFFT-${ROCM_VERSION}.tar.gz -C /src \
    && rm -f /tmp/cache/download/rocFFT-${ROCM_VERSION}.tar.gz

WORKDIR /src/rocFFT-rocm-${ROCM_VERSION}

ARG ROCM_ALL_ARCH_SCSV
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

RUN cmake \
    -Wno-dev \
    -B build \
    -S "/src/rocFFT-rocm-${ROCM_VERSION}" \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_CXX_COMPILER=/opt/rocm-${ROCM_VERSION}/bin/hipcc \
    -DCMAKE_INSTALL_PREFIX=/opt/rocm-${ROCM_VERSION} \
    -DBUILD_FILE_REORG_BACKWARD_COMPATIBILITY=ON \
    -DCPACK_SET_DESTDIR=OFF \
    -DCPACK_PACKAGING_INSTALL_PREFIX=/opt/rocm-${ROCM_VERSION} \
    -DROCM_PATH="/opt/rocm-${ROCM_VERSION}" \
    -DAMDGPU_TARGETS="${ROCM_ALL_ARCH_SCSV}"

RUN cmake --build build --target package -j$(nproc)

WORKDIR /deb

RUN cp /src/rocFFT-rocm-${ROCM_VERSION}/build/*.deb .
