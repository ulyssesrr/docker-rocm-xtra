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

FROM ulyssesrr/rocm-xtra-builder-rocrand:ubuntu${UBUNTU_VERSION}_rocm${ROCM_VERSION} as rocrand-package-builder

FROM ulyssesrr/rocm-xtra-builder-rccl:ubuntu${UBUNTU_VERSION}_rocm${ROCM_VERSION} as rccl-package-builder

FROM ulyssesrr/rocm-xtra-builder-rocfft:ubuntu${UBUNTU_VERSION}_rocm${ROCM_VERSION} as rocfft-package-builder

FROM ulyssesrr/rocm-xtra-builder-rocprim:ubuntu${UBUNTU_VERSION}_rocm${ROCM_VERSION} as rocprim-package-builder

FROM ulyssesrr/rocm-xtra-builder-rocthrust:ubuntu${UBUNTU_VERSION}_rocm${ROCM_VERSION} as rocthrust-package-builder

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

# replace rocrand with our version
WORKDIR /tmp/rocrand
COPY --from=rocrand-package-builder /deb/*.deb .
RUN dpkg -i /tmp/rocrand/*.deb \
    && rm -f /tmp/rocrand/*.deb

# replace rccl with our version
WORKDIR /tmp/rccl
COPY --from=rccl-package-builder /deb/*.deb .
RUN dpkg -i /tmp/rccl/*.deb \
    && rm -f /tmp/rccl/*.deb

# replace rocfft with our version
WORKDIR /tmp/rocfft
COPY --from=rocfft-package-builder /deb/*.deb .
RUN dpkg -i /tmp/rocfft/*.deb \
    && rm -f /tmp/rocfft/*.deb

# replace rocprim with our version
WORKDIR /tmp/rocprim
COPY --from=rocprim-package-builder /deb/*.deb .
RUN dpkg -i /tmp/rocprim/*.deb \
    && rm -f /tmp/rocprim/*.deb

# replace rocthrust with our version
WORKDIR /tmp/rocthrust
COPY --from=rocthrust-package-builder /deb/*.deb .
RUN dpkg -i /tmp/rocthrust/*.deb \
    && rm -f /tmp/rocthrust/*.deb

WORKDIR /app