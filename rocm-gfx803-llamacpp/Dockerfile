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

FROM ulyssesrr/rocm-gfx803-dev:ubuntu${UBUNTU_VERSION}-rocm${ROCM_VERSION}-complete

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
ARG LLAMACPP_COMMIT_ID
ARG LLAMACPP_HIPBLAS_PULL_ID

LABEL org.opencontainers.image.authors="Ulysses R. Ribeiro <ulyssesrr@gmail.com>"

WORKDIR /git

# # shallow clone
RUN mkdir llamacpp && \
    cd llamacpp && \
    git init . && \
    git remote add origin ${LLAMACPP_REPO_URL} && \
    git fetch origin pull/${LLAMACPP_HIPBLAS_PULL_ID}/head:hipblas && \
    git checkout hipblas

# # full git clone
# RUN git clone ${LLAMACPP_REPO_URL} llamacpp
# 
# WORKDIR /git/llamacpp
# 
# # fetch hipBLAS PR
# RUN git fetch origin pull/${LLAMACPP_HIPBLAS_PULL_ID}/head:hipblas

WORKDIR /git/llamacpp

# set target for hipcc
ENV HCC_AMDGPU_TARGET=${ROCM_ARCH}
ENV GPU_TARGETS=${ROCM_ARCH}

COPY patches /patches

RUN git -C /git/llamacpp apply /patches/allow_overriding_gpu_targets.patch

# build with hipBLAS
RUN make -j${NUM_CPU_CORES} LLAMA_HIPBLAS=1

# add llama.cpp to path
ENV PATH="/git/llamacpp:$PATH"

ENTRYPOINT ["main"]
