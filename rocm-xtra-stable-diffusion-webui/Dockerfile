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

RUN --mount=type=cache,target=/var/cache/apt,rw --mount=type=cache,target=/var/lib/apt,rw \
    apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    git \
    python3-venv \
    libpng16-16 \
    libjpeg-turbo8 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /

ARG repo_url=https://github.com/AUTOMATIC1111/stable-diffusion-webui.git

# When updating the commit, review the prepare_environment() bellow
ARG stable_diffusion_commit

RUN git clone $repo_url stable-diffusion-webui \
    && cd stable-diffusion-webui \
    && git checkout $stable_diffusion_commit

WORKDIR /stable-diffusion-webui
    
SHELL ["/bin/bash", "-c"]

RUN python3 -m venv venv --system-site-packages

RUN source venv/bin/activate

RUN pip install -r requirements.txt

# extracted from launch.py 
# def prepare_environment(): begin
ARG clip_package=git+https://github.com/openai/CLIP.git@d50d76daa670286dd6cacf3bcd80b5e4823fc8e1
RUN pip install $clip_package 

ARG openclip_package=git+https://github.com/mlfoundations/open_clip.git@bb6e834e9c70d9c27d0dc3ecedeebeaeb1ffad6b
RUN pip install $openclip_package 

ARG repo_dir=/stable-diffusion-webui/repositories
ARG stable_diffusion_repo=https://github.com/Stability-AI/stablediffusion.git
ARG stable_diffusion_commit_hash=47b6b607fdd31875c9279cd2f4f16b92e4ea958e
RUN git clone $stable_diffusion_repo $repo_dir/stable-diffusion-stability-ai
RUN git -C $repo_dir/stable-diffusion-stability-ai checkout $stable_diffusion_commit_hash

ARG taming_transformers_repo=https://github.com/CompVis/taming-transformers.git
ARG taming_transformers_commit_hash=24268930bf1dce879235a7fddd0b2355b84d7ea6
RUN git clone $taming_transformers_repo $repo_dir/taming-transformers
RUN git -C $repo_dir/taming-transformers checkout $taming_transformers_commit_hash

ARG k_diffusion_repo=https://github.com/crowsonkb/k-diffusion.git
ARG k_diffusion_commit_hash=5b3af030dd83e0297272d861c19477735d0317ec
RUN git clone $k_diffusion_repo $repo_dir/k-diffusion
RUN git -C $repo_dir/k-diffusion checkout $k_diffusion_commit_hash

ARG codeformer_repo=https://github.com/sczhou/CodeFormer.git
ARG codeformer_commit_hash=c5b4593074ba6214284d6acd5f1719b6c5d739af
RUN git clone $codeformer_repo $repo_dir/CodeFormer
RUN git -C $repo_dir/CodeFormer checkout $codeformer_commit_hash
RUN pip install -r $repo_dir/CodeFormer/requirements.txt

ARG blip_repo=https://github.com/salesforce/BLIP.git
ARG blip_commit_hash=48211a1594f1321b00f14c9f7a5b4813144b2fb9
RUN git clone $blip_repo $repo_dir/BLIP
RUN git -C $repo_dir/BLIP checkout $blip_commit_hash

# Web UI requirements
RUN pip install -r requirements_versions.txt

# prepare_environment(): end

# WORKAROUND: Fix Segmentation fault
RUN pip install protobuf==3.18.3
RUN pip install pydantic==1.10.7

VOLUME /root/.cache

RUN mkdir -p /stable-diffusion-webui/data
VOLUME /stable-diffusion-webui/data
VOLUME /stable-diffusion-webui/outputs

ENV PYTHONUNBUFFERED=1
EXPOSE 7860

ENTRYPOINT ["python3", "launch.py", "--data-dir", "/stable-diffusion-webui/data", "--listen", "--port", "7860"]
CMD ["--medvram"]
