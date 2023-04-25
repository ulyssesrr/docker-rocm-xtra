ARG UBUNTU_VERSION
ARG ROCM_VERSION

FROM rocm/dev-ubuntu-${UBUNTU_VERSION}:${ROCM_VERSION}-complete

ARG ROCBLAS_BASE_URL
ARG ROCBLAS_FILE
ARG ROCBLAS_DEV_FILE

LABEL org.opencontainers.image.authors="Ulysses R. Ribeiro <ulyssesrr@gmail.com>"

# install rocblas
RUN curl -L $ROCBLAS_BASE_URL/$ROCBLAS_FILE --output $ROCBLAS_FILE \
    && dpkg -i ./${ROCBLAS_FILE} \
    && rm -f ./${ROCBLAS_FILE}

# install rocblas-dev
RUN curl -L $ROCBLAS_BASE_URL/$ROCBLAS_DEV_FILE --output $ROCBLAS_DEV_FILE \
    && dpkg -i ./${ROCBLAS_DEV_FILE} \
    && rm -f ./${ROCBLAS_DEV_FILE}
