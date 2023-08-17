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

FROM ulyssesrr/rocm-xtra-dev:ubuntu${UBUNTU_VERSION}-rocm${ROCM_VERSION}-complete

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

ARG LLAMACPP_REPO_URL
ARG LLAMACPP_HIPBLAS_PULL_ID
ARG LLAMACPP_HIPBLAS_PULL_HASH

LABEL org.opencontainers.image.authors="Ulysses R. Ribeiro <ulyssesrr@gmail.com>"

WORKDIR /git

RUN git clone ${LLAMACPP_REPO_URL} llamacpp \
    && cd llamacpp \
    && git fetch origin pull/${LLAMACPP_HIPBLAS_PULL_ID}/head:hipblas \
    && git checkout hipblas \
    && git checkout ${LLAMACPP_HIPBLAS_PULL_HASH}

WORKDIR /git/llamacpp

#COPY patches /patches
#RUN git -C /git/llamacpp apply /patches/build-all-gfx-archs.patch

# build with hipBLAS
ENV HIPCC_COMPILE_FLAGS_APPEND="-parallel-jobs=${NUM_CPU_CORES}"
ENV HIPCC_LINK_FLAGS_APPEND="-parallel-jobs=${NUM_CPU_CORES}"
RUN make -j${NUM_CPU_CORES} LLAMA_HIPBLAS=1 GPU_TARGETS="$(ls /opt/rocm/lib/rocblas/library/TensileLibrary_lazy_*.dat | grep -o 'gfx[0-9a-z]*')"

# add llama.cpp to path
ENV PATH="/git/llamacpp:$PATH"

ENTRYPOINT ["main"]
