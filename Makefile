all: dev pytorch llamacpp stable_diffusion_webui
	echo "All built!"
rocblas_fixed_package:
	cd rocm-xtra-builder-rocblas && ./docker-build.sh
rocsparse_package:
	cd rocm-xtra-builder-rocsparse && ./docker-build.sh
rocrand_package:
	cd rocm-xtra-builder-rocrand && ./docker-build.sh
rccl_package:
	cd rocm-xtra-builder-rccl && ./docker-build.sh
rocfft_package:
	cd rocm-xtra-builder-rocfft && ./docker-build.sh
runtime_packages: rocblas_fixed_package rocsparse_package rocrand_package rccl_package rocfft_package
rocprim_package:
	cd rocm-xtra-builder-rocprim && ./docker-build.sh
rocthrust_package: rocprim_package
	cd rocm-xtra-builder-rocthrust && ./docker-build.sh
dev_packages: rocprim_package rocthrust_package
all_packages: runtime_packages dev_packages
dev: all_packages
	cd rocm-xtra-dev && ./docker-build.sh
llamacpp: dev
	cd rocm-xtra-llamacpp && ./docker-build.sh
pytorch: pytorch_base pytorch_builder
	cd rocm-xtra-pytorch && ./docker-build.sh
stable_diffusion_webui: pytorch
	cd rocm-xtra-stable-diffusion-webui && ./docker-build.sh
pytorch_base: dev
	cd rocm-xtra-pytorch-base && ./docker-build.sh
pytorch_builder: pytorch_base
	cd rocm-xtra-pytorch-builder && ./docker-build.sh
