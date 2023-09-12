ARG UBUNTU_VERSION

ARG ROCM_MAJOR_VERSION
ARG ROCM_MINOR_VERSION
ARG ROCM_PATCH_VERSION
ARG ROCM_BUILD_NUMBER
ARG ROCM_LIBPATCH_VERSION
ARG ROCM_VERSION
ARG ROCM_VERSION_DOCKER

FROM ulyssesrr/rocm-xtra-builder-rocblas:ubuntu${UBUNTU_VERSION}_rocm${ROCM_VERSION} as rocblas-package-builder

FROM rocm/dev-ubuntu-${UBUNTU_VERSION}:${ROCM_VERSION_DOCKER}-complete

LABEL org.opencontainers.image.authors="Ulysses R. Ribeiro <ulyssesrr@gmail.com>"

# MIOpen deps
RUN --mount=type=cache,target=/var/cache/apt,rw --mount=type=cache,target=/var/lib/apt,rw \
    apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    git \
    unzip \
    make \
    pkg-config \
    libnuma1 \
    cmake \
    ninja-build \
    libbz2-dev \
    libboost-system-dev \
    libboost-filesystem-dev \
    libsqlite3-dev \
    nlohmann-json3-dev \
    libeigen3-dev \
    && rm -rf /var/lib/apt/lists/*

# Unpackaged deps

## Unpackaged deps > half
ARG LIB_HALF_VERSION=2.2.0
RUN --mount=type=cache,target=/tmp/cache/download,rw \
    curl -L -o /tmp/cache/download/half-${LIB_HALF_VERSION}.zip https://sourceforge.net/projects/half/files/half/${LIB_HALF_VERSION}/half-${LIB_HALF_VERSION}.zip/download \
    && mkdir -p /tmp/src \
    && unzip /tmp/cache/download/half-${LIB_HALF_VERSION}.zip -d /tmp/src/half-${LIB_HALF_VERSION} \
    && rm -f /tmp/cache/download/half-${LIB_HALF_VERSION}.zip \
    && install -Dm644 "/tmp/src/half-${LIB_HALF_VERSION}/include/half.hpp" "/usr/include/half/half.hpp" \
    && rm -rf /tmp/src/half-${LIB_HALF_VERSION}

## Unpackaged deps > https://github.com/Dobiasd/FunctionalPlus
ARG LIB_FUNCTIONAL_PLUS_VERSION=0.2.18-p0
RUN git clone --depth 1 -b "v${LIB_FUNCTIONAL_PLUS_VERSION}" https://github.com/Dobiasd/FunctionalPlus
RUN cmake -S FunctionalPlus -B FunctionalPlus/build -Wno-dev -DCMAKE_INSTALL_PREFIX=/usr
RUN cmake --build FunctionalPlus/build
RUN cmake --install FunctionalPlus/build

## Unpackaged deps > https://github.com/Dobiasd/frugally-deep
ARG LIB_FRUGALLY_DEEP_VERSION=0.15.20-p0
RUN git clone --depth 1 -b "v${LIB_FRUGALLY_DEEP_VERSION}" https://github.com/Dobiasd/frugally-deep
RUN cmake -S frugally-deep -B frugally-deep/build -Wno-dev -DCMAKE_INSTALL_PREFIX=/usr
RUN cmake --build frugally-deep/build
RUN cmake --install frugally-deep/build
    
COPY --from=rocblas-package-builder /deb/*.deb /tmp/rocblas/
RUN dpkg -i /tmp/rocblas/*.deb \
    && rm -f /tmp/rocblas/*.deb

WORKDIR /src

## Unpackaged deps > https://github.com/ROCmSoftwarePlatform/rocMLIR
ARG MLIR_VERSION=5.5.0 # Not updated/tagged up to 5.6.1
RUN --mount=type=cache,target=/tmp/cache/download,rw \
    curl -L -o /tmp/cache/download/rocMLIR-${MLIR_VERSION}.tar.gz https://github.com/ROCmSoftwarePlatform/rocMLIR/archive/rocm-${MLIR_VERSION}.tar.gz \
    && tar -xf /tmp/cache/download/rocMLIR-${MLIR_VERSION}.tar.gz -C /src \
    && rm -f /tmp/cache/download/rocMLIR-${MLIR_VERSION}.tar.gz

ARG ROCM_VERSION
RUN git clone --depth 1 -b "rocm-${ROCM_VERSION}-gfx1010" https://github.com/ulyssesrr/MIOpen.git

# Disable tests as they require an AMD GPU at build time
RUN sed -i '/add_subdirectory(test)/d' "/src/MIOpen/CMakeLists.txt"

ARG ROCM_ALL_ARCH_SCSV
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

ENV CC=/opt/rocm/llvm/bin/clang
ENV CXX=/opt/rocm/llvm/bin/clang++

## Build rocMLIR
RUN cmake \
    -Wno-dev \
    -G Ninja \
    -B /src/build-mlir \
    -S "/src/rocMLIR-rocm-${MLIR_VERSION}" \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DMLIR_MIOPEN_SQLITE_ENABLED=ON \
    -DROCM_TEST_CHIPSET=gfx900 \
    -DBUILD_FAT_LIBROCKCOMPILER=ON

RUN cmake --build /src/build-mlir --target librockCompiler -j$(nproc)
RUN DESTDIR="/src/deps" cmake --install /src/build-mlir --component librockCompiler

## Unpackaged deps > https://github.com/ROCmSoftwarePlatform/composable_kernel

### Version from https://github.com/ROCmSoftwarePlatform/MIOpen/blob/rocm-X.Y.Z/requirements.txt
#ARG ROCM_CK_VERSION="0a8dac4ef1a232abd8f6896a5b016f9e76192ddd"
RUN git clone --depth 1 -b "rocm-${ROCM_VERSION}-gfx1010" https://github.com/ulyssesrr/composable_kernel.git
ARG CK_SRC_DIR="/src/composable_kernel"

# RUN --mount=type=cache,target=/tmp/cache/download,rw \
#     curl -L -o /tmp/cache/download/composable_kernel-${ROCM_CK_VERSION}.tar.gz https://github.com/ROCmSoftwarePlatform/composable_kernel/archive/${ROCM_CK_VERSION}.tar.gz \
#     && tar -xf /tmp/cache/download/composable_kernel-${ROCM_CK_VERSION}.tar.gz -C /src \
#     && rm -f /tmp/cache/download/composable_kernel-${ROCM_CK_VERSION}.tar.gz

    
### Remove tests as they require a supported AMD GPU to run
RUN sed -i '/add_subdirectory(test)/d' "${CK_SRC_DIR}/CMakeLists.txt"

RUN cmake \
    -Wno-dev \
    -B /src/build-composable_kernel \
    -S "${CK_SRC_DIR}" \
    -DCMAKE_CXX_COMPILER=/opt/rocm-${ROCM_VERSION}/bin/hipcc \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_DEV=OFF \
    -DCMAKE_INSTALL_PREFIX=/opt/rocm-${ROCM_VERSION} \
    -DGPU_TARGETS="${ROCM_ALL_ARCH_SCSV}"

RUN cmake --build /src/build-composable_kernel -j$(nproc)
RUN cmake --install /src/build-composable_kernel

# Build MIOpen
RUN cmake \
    -Wno-dev \
    -G Ninja \
    -B /src/build-miopen \
    -S "/src/MIOpen" \
    -DMIOPEN_BACKEND=HIP \
    -DCMAKE_BUILD_TYPE=Release \
    -DHALF_INCLUDE_DIR=/usr/include/half \
    -DCMAKE_PREFIX_PATH="/src/deps/usr/lib/cmake" \
    -DCMAKE_INSTALL_PREFIX=/opt/rocm-${ROCM_VERSION} \
    -DBUILD_FILE_REORG_BACKWARD_COMPATIBILITY=ON \
    -DCPACK_SET_DESTDIR=OFF \
    -DCPACK_PACKAGING_INSTALL_PREFIX=/opt/rocm-${ROCM_VERSION}
RUN cmake --build build --target package -j$(nproc)

WORKDIR /deb

RUN cp /src/build-miopen/*.deb .
