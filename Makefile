all: dev pytorch llamacpp stable_diffusion_webui
	echo "All built!"
rocblas_fixed_package:
	cd rocm-xtra-builder-rocblas && ./docker-build.sh
rocsparse_fixed_package:
	cd rocm-xtra-builder-rocsparse && ./docker-build.sh
dev: rocblas_fixed_package rocsparse_fixed_package
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
