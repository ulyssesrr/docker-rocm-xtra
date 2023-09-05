ARG UBUNTU_VERSION
ARG ROCM_MAJOR_VERSION
ARG ROCM_MINOR_VERSION
ARG ROCM_PATCH_VERSION
ARG ROCM_BUILD_NUMBER
ARG ROCM_VERSION
ARG PYTORCH_VERSION
ARG PYTORCH_VISION_VERSION
ARG PYTORCH_AUDIO_VERSION
ARG NUM_CPU_CORES

FROM ulyssesrr/rocm-xtra-pytorch-base:rocm${ROCM_VERSION}_ubuntu${UBUNTU_VERSION}_pytorch${PYTORCH_VERSION}

ARG UBUNTU_VERSION
ARG ROCM_MAJOR_VERSION
ARG ROCM_MINOR_VERSION
ARG ROCM_PATCH_VERSION
ARG ROCM_BUILD_NUMBER
ARG ROCM_VERSION
ARG PYTORCH_VERSION
ARG PYTORCH_VISION_VERSION
ARG PYTORCH_AUDIO_VERSION
ARG NUM_CPU_CORES

LABEL org.opencontainers.image.authors="Ulysses R. Ribeiro <ulyssesrr@gmail.com>"

# pytorch deps
RUN --mount=type=cache,target=/var/cache/apt,rw --mount=type=cache,target=/var/lib/apt,rw \
    apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# pytorch build env vars
ARG ROCM_VERSION
ENV ROCM_PATH=/opt/rocm
ARG ROCM_ALL_ARCH_SCSV
ENV PYTORCH_ROCM_ARCH=${ROCM_ALL_ARCH_SCSV}
ENV PYTORCH_BUILD_VERSION=${PYTORCH_VERSION}
ENV PYTORCH_BUILD_NUMBER=1
ENV MAX_JOBS=${NUM_CPU_CORES}

# prepare torch build

## torch deps
RUN pip install astunparse numpy ninja pyyaml setuptools cmake cffi typing_extensions future six requests dataclasses

#RUN git clone --depth 1 --branch v${PYTORCH_VERSION} --recursive https://github.com/pytorch/pytorch.git


RUN --mount=type=cache,target=/tmp/cache/download,rw \
    curl -L -o /tmp/cache/download/pytorch-v${PYTORCH_VERSION}.tar.gz https://github.com/pytorch/pytorch/releases/download/v${PYTORCH_VERSION}/pytorch-v${PYTORCH_VERSION}.tar.gz \
    && tar -xf /tmp/cache/download/pytorch-v${PYTORCH_VERSION}.tar.gz -C /src \
    && rm -f /tmp/cache/download/pytorch-v${PYTORCH_VERSION}.tar.gz \
    && mv /src/pytorch-v${PYTORCH_VERSION} /src/pytorch

WORKDIR /src

# setup build dir
RUN mkdir -p /build

# build torch
ENV HIPCC_COMPILE_FLAGS_APPEND="-parallel-jobs=${NUM_CPU_CORES}"
ENV HIPCC_LINK_FLAGS_APPEND="-parallel-jobs=${NUM_CPU_CORES}"

WORKDIR /src/pytorch
RUN python tools/amd_build/build_amd.py
RUN python setup.py bdist_wheel
RUN cp /src/pytorch/dist/*.whl /build

# Build torchvision
## install torch
RUN pip install --no-cache-dir /src/pytorch/dist/torch-*.whl

# prepare torchvision build
# torchvision deps
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

WORKDIR /src
RUN git clone --depth 1 --branch v${PYTORCH_VISION_VERSION} --recursive https://github.com/pytorch/vision.git

RUN mkdir -p /patches/torchvision
COPY patches/torchvision /patches/torchvision

# https://github.com/pytorch/vision/issues/7561
RUN patch -Np1 -d /src/vision -i /patches/torchvision/fix_ROCm_build.patch

## generate wheel
WORKDIR /src/vision

# fix bin/hipcc not found, because ROCM_HOME is lost
# https://github.com/pytorch/vision/issues/6707#issuecomment-1269640873
ENV ROCM_HOME=/opt/rocm-${ROCM_VERSION}

RUN TORCHVISION_USE_NVJPEG=0 \
    TORCHVISION_USE_VIDEO_CODEC=0 \
    TORCHVISION_USE_FFMPEG=1 \
    python setup.py bdist_wheel
RUN cp /src/vision/dist/*.whl /build

# Build torchaudio
ENV USE_FFMPEG=1

# prepare torchaudio build
WORKDIR /src
RUN git clone --depth 1 --branch v${PYTORCH_AUDIO_VERSION} --recursive https://github.com/pytorch/audio.git

# torchaudio deps
RUN --mount=type=cache,target=/var/cache/apt,rw --mount=type=cache,target=/var/lib/apt,rw \
    apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    pkg-config \
    ninja-build \
    libavfilter-dev \
    libavdevice-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /src/audio
RUN CMAKE_PREFIX_PATH=/opt/rocm-${ROCM_VERSION} BUILD_SOX=1 USE_ROCM=1 python setup.py bdist_wheel
RUN cp /src/audio/dist/*.whl /build

WORKDIR /build
