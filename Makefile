all:
	echo "TODO! :)"
rocblas_fixed_package:
	cd rocm-xtra-rocblas-builder && ./docker-build.sh
dev: rocblas_fixed_package
	cd rocm-xtra-dev && ./docker-build.sh
llamacpp: dev
	cd rocm-xtra-llamacpp && ./docker-build.sh
pytorch_base: dev
	cd rocm-gfx803-pytorch-base && ./docker-build.sh

pytorch: pytorch_base
	cd rocm-gfx803-pytorch && ./docker-build.sh

stable_diffusion_webui: pytorch
	cd rocm-gfx803-stable-diffusion-webui && ./docker-build.sh

pytorch_builder: pytorch_base
	cd rocm-gfx803-pytorch-builder && ./docker-build.sh
