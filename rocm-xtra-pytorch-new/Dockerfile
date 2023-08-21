ARG UBUNTU_VERSION
ARG ROCM_VERSION
ARG PYTORCH_VERSION
ARG ROCM_VERSION_DOCKER

#FROM ulyssesrr/rocm-xtra-pytorch-builder:rocm${ROCM_VERSION}_ubuntu${UBUNTU_VERSION}_pytorch${PYTORCH_VERSION} as rocm-xtra-pytorch-builder
FROM ulyssesrr/rocm-xtra-builder-rocblas:ubuntu${UBUNTU_VERSION}_rocm${ROCM_VERSION} as rocblas-package-builder

ARG UBUNTU_VERSION
ARG ROCM_VERSION
ARG ROCM_VERSION_DOCKER
ARG PYTORCH_VERSION

FROM rocm/pytorch:rocm${ROCM_VERSION_DOCKER}_ubuntu${UBUNTU_VERSION}_pytorch_${PYTORCH_VERSION}

LABEL org.opencontainers.image.authors="Ulysses R. Ribeiro <ulyssesrr@gmail.com>"

# replace rocblas with fixed version
WORKDIR /tmp/rocblas
COPY --from=rocblas-package-builder /deb/*.deb .

RUN dpkg -i /tmp/rocblas/*.deb \
    && rm -f /tmp/rocblas/*.deb

# COPY --from=rocm-xtra-pytorch-builder /build/*.whl /tmp/pytorch/

# # install pytorch
# RUN pip install --no-cache-dir /tmp/pytorch/torch-*.whl

# # install torchvision
# RUN pip install --no-cache-dir /tmp/pytorch/torchvision-*.whl

# # install torchaudio
# RUN pip install --no-cache-dir /tmp/pytorch/torchaudio-*.whl

# RUN rm -f /tmp/pytorch/*.whl

# # install opencv
# RUN pip install --no-cache-dir opencv-python==${OPENCV_VERSION}

WORKDIR /app
