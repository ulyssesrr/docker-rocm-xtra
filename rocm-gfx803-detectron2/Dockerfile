FROM ulyssesrr/rocm-gfx803-pytorch:rocm5.1.0_ubuntu20.04_py3.8_pytorch_1.11.0

LABEL org.opencontainers.image.authors="Ulysses R. Ribeiro <ulyssesrr@gmail.com>"

WORKDIR /tmp

# install detectron2 deps
RUN --mount=type=cache,target=/var/cache/apt,rw --mount=type=cache,target=/var/lib/apt,rw \
    apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        python3.8-dev \
        git \
        && rm -rf /var/lib/apt/lists/*

# install detectron2
RUN pip install --no-cache-dir git+https://github.com/facebookresearch/detectron2.git@v0.6

WORKDIR /app

ENTRYPOINT ["bash", "-l"]
