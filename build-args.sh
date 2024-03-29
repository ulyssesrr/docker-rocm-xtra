export BUILDKIT_PROGRESS=plain

join_arr() {
  local IFS="$1"
  shift
  echo "$*"
}

# OS
ARG_UBUNTU_VERSION="22.04"

# ROCm
# Supported archs
ARG_ROCM_ALL_ARCH_ARRAY=("gfx803" "gfx900" "gfx906" "gfx908" "gfx90a" "gfx1010" "gfx1030" "gfx1100" "gfx1101" "gfx1102")
ARG_ROCM_ALL_ARCH_CSV=$(join_arr ',' "${ARG_ROCM_ALL_ARCH_ARRAY[@]}")
ARG_ROCM_ALL_ARCH_SCSV=$(join_arr ';' "${ARG_ROCM_ALL_ARCH_ARRAY[@]}")
ARG_ROCM_ALL_ARCH_SPACED=$(join_arr ' ' "${ARG_ROCM_ALL_ARCH_ARRAY[@]}")

# add/replace the following archs on the upstream package
ARG_ROCM_ARCH_ARRAY=("gfx803" "gfx1010")
ARG_ROCM_ARCH_CSV=$(join_arr ',' "${ARG_ROCM_ARCH_ARRAY[@]}")
ARG_ROCM_ARCH_SCSV=$(join_arr ';' "${ARG_ROCM_ARCH_ARRAY[@]}")
ARG_ROCM_ARCH_SPACED=$(join_arr ' ' "${ARG_ROCM_ARCH_ARRAY[@]}")
ARG_ROCM_MAJOR_VERSION="5"
ARG_ROCM_MINOR_VERSION="5"
ARG_ROCM_PATCH_VERSION="1"
#ARG_ROCM_BUILD_NUMBER="72" # 5.4.0
#ARG_ROCM_BUILD_NUMBER="104" # 5.4.2
#ARG_ROCM_BUILD_NUMBER="121" # 5.4.3
#ARG_ROCM_BUILD_NUMBER="63" # 5.5.0
ARG_ROCM_BUILD_NUMBER="74" # 5.5.1
#ARG_ROCM_BUILD_NUMBER="67" # 5.6.0
#ARG_ROCM_BUILD_NUMBER="93" # 5.6.1

ARG_ROCM_LIBPATCH_VERSION=$(printf "%d%02d%02d" ${ARG_ROCM_MAJOR_VERSION} ${ARG_ROCM_MINOR_VERSION} ${ARG_ROCM_PATCH_VERSION})
ARG_ROCM_VERSION="${ARG_ROCM_MAJOR_VERSION}.${ARG_ROCM_MINOR_VERSION}.${ARG_ROCM_PATCH_VERSION}"
if [ "$ARG_ROCM_PATCH_VERSION" -eq "0" ]; then
    ARG_ROCM_VERSION_DOCKER="${ARG_ROCM_MAJOR_VERSION}.${ARG_ROCM_MINOR_VERSION}"
else
    ARG_ROCM_VERSION_DOCKER=$ARG_ROCM_VERSION
fi

# Magma
ARG_MAGMA_VERSION="2.7.1"

# Python
ARG_PYTORCH_VERSION="2.0.1"
ARG_PYTORCH_VISION_VERSION="0.15.2"
ARG_PYTORCH_AUDIO_VERSION="2.0.2"
ARG_OPENCV_VERSION="4.8.0.76"

# Build
ARG_NUM_CPU_CORES=$(nproc)

docker_build() {
   docker build \
    --build-arg "UBUNTU_VERSION=$ARG_UBUNTU_VERSION" \
    --build-arg "ROCM_ARCH_SCSV=$ARG_ROCM_ARCH_SCSV" \
    --build-arg "ROCM_ALL_ARCH_SCSV=$ARG_ROCM_ALL_ARCH_SCSV" \
    --build-arg "ROCM_ALL_ARCH_SPACED=$ARG_ROCM_ALL_ARCH_SPACED" \
    --build-arg "ROCM_MAJOR_VERSION=$ARG_ROCM_MAJOR_VERSION" \
    --build-arg "ROCM_MINOR_VERSION=$ARG_ROCM_MINOR_VERSION" \
    --build-arg "ROCM_PATCH_VERSION=$ARG_ROCM_PATCH_VERSION" \
    --build-arg "ROCM_BUILD_NUMBER=$ARG_ROCM_BUILD_NUMBER" \
    --build-arg "ROCM_LIBPATCH_VERSION=$ARG_ROCM_LIBPATCH_VERSION" \
    --build-arg "ROCM_VERSION=$ARG_ROCM_VERSION" \
    --build-arg "ROCM_VERSION_DOCKER=$ARG_ROCM_VERSION_DOCKER" \
    --build-arg "MAGMA_VERSION=$ARG_MAGMA_VERSION" \
    --build-arg "PYTORCH_VERSION=$ARG_PYTORCH_VERSION" \
    --build-arg "PYTORCH_VISION_VERSION=$ARG_PYTORCH_VISION_VERSION" \
    --build-arg "PYTORCH_AUDIO_VERSION=$ARG_PYTORCH_AUDIO_VERSION" \
    --build-arg "OPENCV_VERSION=$ARG_OPENCV_VERSION" \
    --build-arg "NUM_CPU_CORES=$ARG_NUM_CPU_CORES" \
    "$@"
}
