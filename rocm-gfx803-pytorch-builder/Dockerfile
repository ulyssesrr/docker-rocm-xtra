ARG UBUNTU_VERSION
ARG ROCM_MAJOR_VERSION
ARG ROCM_MINOR_VERSION
ARG ROCM_PATCH_VERSION
ARG ROCM_BUILD_NUMBER
ARG ROCM_VERSION
ARG PYTHON_VERSION
ARG PYTORCH_VERSION
ARG PYTORCH_VISION_VERSION
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

# shared build script
COPY scripts /git

WORKDIR /git

ENV ROCM_PATH=/opt/rocm
ENV PYTORCH_ROCM_ARCH=${ROCM_ARCH}
ENV PYTORCH_BUILD_VERSION=${PYTORCH_VERSION}
ENV PYTORCH_BUILD_NUMBER=1
ENV MAX_JOBS=${NUM_CPU_CORES}

CMD ["./pytorch-build-gfx803.sh"]