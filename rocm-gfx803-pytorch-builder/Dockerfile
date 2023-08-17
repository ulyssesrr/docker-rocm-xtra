ARG UBUNTU_VERSION
ARG ROCM_MAJOR_VERSION
ARG ROCM_MINOR_VERSION
ARG ROCM_PATCH_VERSION
ARG ROCM_BUILD_NUMBER
ARG ROCM_VERSION
ARG PYTHON_VERSION
ARG PYTORCH_VERSION
ARG PYTORCH_VISION_VERSION
ARG PYTORCH_AUDIO_VERSION
ARG NUM_CPU_CORES

FROM ulyssesrr/rocm-gfx803-pytorch-base:rocm${ROCM_VERSION}_ubuntu${UBUNTU_VERSION}_py${PYTHON_VERSION}_pytorch${PYTORCH_VERSION}

ARG UBUNTU_VERSION
ARG ROCM_ARCH
ARG ROCM_MAJOR_VERSION
ARG ROCM_MINOR_VERSION
ARG ROCM_PATCH_VERSION
ARG ROCM_BUILD_NUMBER
ARG ROCM_VERSION
ARG PYTHON_VERSION
ARG PYTORCH_VERSION
ARG PYTORCH_VISION_VERSION
ARG PYTORCH_AUDIO_VERSION
ARG NUM_CPU_CORES

LABEL org.opencontainers.image.authors="Ulysses R. Ribeiro <ulyssesrr@gmail.com>"

WORKDIR /git

# pytorch deps
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

ARG ROCM_VERSION

# prepare torch build
## torch deps
RUN pip install astunparse numpy ninja pyyaml setuptools cmake cffi typing_extensions future six requests dataclasses

RUN git clone --depth 1 --branch v${PYTORCH_VERSION} --recursive https://github.com/pytorch/pytorch.git

# prepare torchvision build
# torchvision deps
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    libpng-dev \
    libjpeg-turbo8-dev \
    ffmpeg \
    libavcodec-dev \
    libswscale-dev \
    libavutil-dev \
    libswresample-dev \
    libavformat-dev \
    && rm -rf /var/lib/apt/lists/*

RUN git clone --depth 1 --branch v${PYTORCH_VISION_VERSION} --recursive https://github.com/pytorch/vision.git

# prepare torchaudio build
RUN git clone --depth 1 --branch v${PYTORCH_AUDIO_VERSION} --recursive https://github.com/pytorch/audio.git

WORKDIR /git

# set target for hipcc
ENV HCC_AMDGPU_TARGET=${ROCM_ARCH}

ENV ROCM_PATH=/opt/rocm
ENV PYTORCH_ROCM_ARCH=${ROCM_ARCH}
ENV PYTORCH_BUILD_VERSION=${PYTORCH_VERSION}
ENV PYTORCH_BUILD_NUMBER=1
ENV MAX_JOBS=${NUM_CPU_CORES}

# setup build dir
RUN mkdir -p /build

# build torch
WORKDIR /git/pytorch
RUN python tools/amd_build/build_amd.py
RUN python setup.py bdist_wheel
RUN cp /git/pytorch/dist/*.whl /build

# Build torchvision
## install torch
RUN pip install --no-cache-dir /git/pytorch/dist/torch-*.whl

## generate wheel
WORKDIR /git/vision
RUN python setup.py bdist_wheel
RUN cp /git/vision/dist/*.whl /build

# Build torchaudio
ENV USE_FFMPEG=1


# torchaudio deps
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    pkg-config \
    ninja-build \
    libavfilter-dev \
    libavdevice-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /git/audio
RUN python setup.py bdist_wheel
RUN cp /git/audio/dist/*.whl /build

WORKDIR /build
