#!/bin/bash
source env.build.sh

docker_build --build-arg "stable_diffusion_ui_version=$arg_stable_diffusion_ui_version" -t "$docker_image_name:$docker_image_tag" .
