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
    mesa-common-dev \
    comgr \
    cmake \
    rpm \
    && rm -rf /var/lib/apt/lists/*

RUN --mount=type=cache,target=/root/.cache/pip \
    pip install CppHeaderParser==2.7.4

WORKDIR /src

RUN git clone --depth 1 -b "rocm-${ROCM_VERSION}" https://github.com/ROCm-Developer-Tools/hipamd.git
RUN git clone --depth 1 -b "rocm-${ROCM_VERSION}" https://github.com/ROCm-Developer-Tools/hip.git
RUN git clone --depth 1 -b "rocm-${ROCM_VERSION}" https://github.com/ROCm-Developer-Tools/ROCclr.git
RUN git clone --depth 1 -b "rocm-${ROCM_VERSION}" https://github.com/RadeonOpenCompute/ROCm-OpenCL-Runtime.git

WORKDIR /src/build

ARG UBUNTU_VERSION
ARG ROCM_MAJOR_VERSION
ARG ROCM_MINOR_VERSION
ARG ROCM_PATCH_VERSION
ARG ROCM_BUILD_NUMBER
ARG ROCM_LIBPATCH_VERSION

ENV ROCM_PATH=/opt/rocm-${ROCM_VERSION}
ENV ROCM_MAJOR_VERSION=${ROCM_MAJOR_VERSION}
ENV ROCM_MINOR_VERSION=${ROCM_MINOR_VERSION}
ENV ROCM_PATCH_VERSION=${ROCM_PATCH_VERSION}
ENV ROCM_LIBPATCH_VERSION=${ROCM_LIBPATCH_VERSION}
ENV ROCM_PKGTYPE=DEB
ENV CPACK_DEBIAN_PACKAGE_RELEASE=${ROCM_BUILD_NUMBER}~${UBUNTU_VERSION}

RUN cmake \
    -Wno-dev \
    -S "/src/hipamd" \
    -DHIP_COMMON_DIR="/src/hip" \
    -DAMD_OPENCL_PATH="/src/ROCm-OpenCL-Runtime" \
    -DROCCLR_PATH="/src/ROCclr" \
    #-DHIP_PLATFORM=amd \
    -DCMAKE_BUILD_TYPE=RelWithDebug \
    -DROCM_DIR="/opt/rocm-${ROCM_VERSION}" \
    -DCMAKE_INSTALL_PREFIX="/opt/rocm-${ROCM_VERSION}" \
    -DCPACK_SET_DESTDIR=OFF \
    -DCPACK_PACKAGING_INSTALL_PREFIX="/opt/rocm-${ROCM_VERSION}"


RUN make package -j$(nproc)

#RUN cmake --install .

#RUN echo "/opt/rocm-${ROCM_VERSION}/hip/lib" > /etc/ld.so.conf.d/hip-runtime-amd.conf && ldconfig