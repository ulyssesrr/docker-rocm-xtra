ARG UBUNTU_VERSION
ARG ROCM_ALL_ARCH_SPACED
ARG ROCM_MAJOR_VERSION
ARG ROCM_MINOR_VERSION
ARG ROCM_PATCH_VERSION
ARG ROCM_BUILD_NUMBER
ARG ROCM_LIBPATCH_VERSION
ARG ROCM_VERSION
ARG MAGMA_VERSION
ARG PYTORCH_VERSION
ARG PYTORCH_VISION_VERSION
ARG OPENCV_VERSION
ARG NUM_CPU_CORES

ARG OPENBLAS_VERSION
ARG OPENBLAS_INSTALL_PREFIX

FROM ulyssesrr/rocm-xtra-dev:ubuntu${UBUNTU_VERSION}-rocm${ROCM_VERSION}-complete

ARG UBUNTU_VERSION
ARG ROCM_ALL_ARCH_SPACED
ARG ROCM_MAJOR_VERSION
ARG ROCM_MINOR_VERSION
ARG ROCM_PATCH_VERSION
ARG ROCM_BUILD_NUMBER
ARG ROCM_LIBPATCH_VERSION
ARG ROCM_VERSION
ARG MAGMA_VERSION
ARG PYTORCH_VERSION
ARG PYTORCH_VISION_VERSION
ARG OPENCV_VERSION
ARG NUM_CPU_CORES

ARG OPENBLAS_VERSION
ARG OPENBLAS_INSTALL_PREFIX

LABEL org.opencontainers.image.authors="Ulysses R. Ribeiro <ulyssesrr@gmail.com>"

# magma deps
RUN --mount=type=cache,target=/var/cache/apt,rw --mount=type=cache,target=/var/lib/apt,rw \
    apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    gfortran \
    libopenblas-dev \
    cmake \
    ninja-build \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /src

RUN --mount=type=cache,target=/tmp/cache/download,rw \
    wget -O /tmp/cache/download/magma-${MAGMA_VERSION}.tar.gz https://icl.utk.edu/projectsfiles/magma/downloads/magma-${MAGMA_VERSION}.tar.gz \
    && tar -xf /tmp/cache/download/magma-${MAGMA_VERSION}.tar.gz -C /src \
    && rm -f /src/magma-${MAGMA_VERSION}.tar.gz

WORKDIR /src/magma-${MAGMA_VERSION}

RUN cmake \
    -B build \
    -G Ninja \
    -DCMAKE_CXX_COMPILER=/opt/rocm/bin/hipcc \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DBUILD_SHARED_LIBS=ON \
    -DMAGMA_ENABLE_HIP=ON \
    -DBLA_VENDOR=OpenBLAS \
    -DGPU_TARGET="${ROCM_ALL_ARCH_SPACED}"

RUN cmake --build build --target lib sparse-lib

RUN cmake --install build

# DEBUG
#RUN cmake --build build --target testing_dgemm