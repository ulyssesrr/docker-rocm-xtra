#!/bin/bash
source .env.build.sh

docker push "$docker_image_name:$docker_image_tag"
docker tag "$docker_image_name:$docker_image_tag" "$docker_image_name:latest"
docker push "$docker_image_name:latest"