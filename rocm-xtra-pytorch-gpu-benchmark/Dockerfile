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

FROM ulyssesrr/rocm-xtra-pytorch:rocm${ROCM_VERSION}_ubuntu${UBUNTU_VERSION}_pytorch${PYTORCH_VERSION} as rocm-xtra-stable-diffusion-webui

LABEL org.opencontainers.image.authors="Ulysses R. Ribeiro <ulyssesrr@gmail.com>"

WORKDIR /

RUN git clone https://github.com/ryujaehun/pytorch-gpu-benchmark.git \
    && cd pytorch-gpu-benchmark \
    && git checkout 03b0dd59cb9b9b5e4810369995f9c89a4234e74d

WORKDIR /pytorch-gpu-benchmark


ARG PYTORCH_VERSION
RUN sed -i 's/torch==2.0.0/torch==${PYTORCH_VERSION}/g' requirement.txt && pip install -r requirement.txt

ENV PYTHONUNBUFFERED=1

ENTRYPOINT ["python3", "benchmark_models.py", "-g"]
CMD ["1"]
