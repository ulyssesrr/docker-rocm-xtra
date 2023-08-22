ARG UBUNTU_VERSION
ARG ROCM_ARCH
ARG ROCM_MAJOR_VERSION
ARG ROCM_MINOR_VERSION
ARG ROCM_PATCH_VERSION
ARG ROCM_BUILD_NUMBER
ARG ROCM_LIBPATCH_VERSION
ARG ROCM_VERSION
ARG PYTORCH_VERSION
ARG PYTORCH_VISION_VERSION
ARG OPENCV_VERSION
ARG NUM_CPU_CORES

FROM ulyssesrr/rocm-xtra-pytorch-builder:rocm${ROCM_VERSION}_ubuntu${UBUNTU_VERSION}_pytorch${PYTORCH_VERSION} as rocm-xtra-pytorch-builder

FROM ulyssesrr/rocm-xtra-pytorch-base:rocm${ROCM_VERSION}_ubuntu${UBUNTU_VERSION}_pytorch${PYTORCH_VERSION}

ARG UBUNTU_VERSION
ARG ROCM_ARCH
ARG ROCM_MAJOR_VERSION
ARG ROCM_MINOR_VERSION
ARG ROCM_PATCH_VERSION
ARG ROCM_BUILD_NUMBER
ARG ROCM_LIBPATCH_VERSION
ARG ROCM_VERSION
ARG PYTORCH_VERSION
ARG PYTORCH_VISION_VERSION
ARG OPENCV_VERSION
ARG NUM_CPU_CORES

LABEL org.opencontainers.image.authors="Ulysses R. Ribeiro <ulyssesrr@gmail.com>"

COPY --from=rocm-xtra-pytorch-builder /build/*.whl /tmp/pytorch/

# install pytorch
RUN pip install --no-cache-dir /tmp/pytorch/torch-*.whl

# install torchvision
RUN pip install --no-cache-dir /tmp/pytorch/torchvision-*.whl

# install torchaudio
RUN pip install --no-cache-dir /tmp/pytorch/torchaudio-*.whl

RUN rm -f /tmp/pytorch/*.whl

# install opencv
RUN pip install --no-cache-dir opencv-python==${OPENCV_VERSION}

# runtime deps (use dev deps to keep it simple)
RUN --mount=type=cache,target=/var/cache/apt,rw --mount=type=cache,target=/var/lib/apt,rw \
    apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    libpng-dev \
    libjpeg-turbo8-dev \
    ffmpeg \
    libavcodec-dev \
    libswscale-dev \
    libavutil-dev \
    libswresample-dev \
    libavformat-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
