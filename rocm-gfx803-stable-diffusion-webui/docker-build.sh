#!/bin/bash
source .env.build.sh

docker_build --build-arg "stable_diffusion_commit=$arg_stable_diffusion_commit" -t "$docker_image_name:$docker_image_tag" .