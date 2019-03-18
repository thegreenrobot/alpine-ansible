#!/bin/bash -e

REVISION=$(git rev-parse HEAD)

build_docker_image () {
  docker build --tag "thegreenrobot/alpine-ansible" --file ./Dockerfile .
  docker tag thegreenrobot/alpine-ansible:latest thegreenrobot/alpine-ansible:$REVISION
}

upload_docker_image () {
  docker push thegreenrobot/alpine-ansible:latest
  docker push thegreenrobot/alpine-ansible:$REVISION
}

echo "Building docker image..."
build_docker_image
echo "Uploading docker image..."
upload_docker_image
echo "Success!"
