ARG UBUNTU_VERSION
ARG ROCM_ARCH
ARG ROCM_MAJOR_VERSION
ARG ROCM_MINOR_VERSION
ARG ROCM_PATCH_VERSION
ARG ROCM_BUILD_NUMBER
ARG ROCM_LIBPATCH_VERSION
ARG ROCM_VERSION
ARG ROCM_VERSION_DOCKER
ARG MAGMA_VERSION
ARG PYTORCH_VERSION
ARG PYTORCH_VISION_VERSION
ARG OPENCV_VERSION
ARG NUM_CPU_CORES

FROM ulyssesrr/rocm-xtra-builder-rocblas:ubuntu${UBUNTU_VERSION}_rocm${ROCM_VERSION} as rocblas-package-builder

FROM ulyssesrr/rocm-xtra-builder-rocsparse:ubuntu${UBUNTU_VERSION}_rocm${ROCM_VERSION} as rocsparse-package-builder

FROM rocm/dev-ubuntu-${UBUNTU_VERSION}:${ROCM_VERSION_DOCKER}-complete

ARG UBUNTU_VERSION
ARG ROCM_ARCH
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

LABEL org.opencontainers.image.authors="Ulysses R. Ribeiro <ulyssesrr@gmail.com>"

# apt install utilities
RUN --mount=type=cache,target=/var/cache/apt,rw --mount=type=cache,target=/var/lib/apt,rw \
    apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    git \
    python-is-python3 \
    nano \
    wget \
    && rm -rf /var/lib/apt/lists/*

# replace rocblas with our version
WORKDIR /tmp/rocblas
COPY --from=rocblas-package-builder /deb/*.deb .
RUN dpkg -i /tmp/rocblas/*.deb \
    && rm -f /tmp/rocblas/*.deb

# replace rocsparse with our version
WORKDIR /tmp/rocsparse
COPY --from=rocsparse-package-builder /deb/*.deb .
RUN dpkg -i /tmp/rocsparse/*.deb \
    && rm -f /tmp/rocsparse/*.deb

WORKDIR /app