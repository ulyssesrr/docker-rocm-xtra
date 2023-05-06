#!/bin/bash
source .env.build.sh

docker_build -t "$docker_image_name:$docker_image_tag" .