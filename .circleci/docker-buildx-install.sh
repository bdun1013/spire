#!/bin/bash

set -e

echo "Installing buildx v0.5.1..."

mkdir -p ~/.docker/cli-plugins
curl -sSLo ~/.docker/cli-plugins/docker-buildx https://github.com/docker/buildx/releases/download/v0.5.1/buildx-v0.5.1.linux-amd64
chmod +x ~/.docker/cli-plugins/docker-buildx
docker run --privileged --rm tonistiigi/binfmt:latest --uninstall qemu-*
docker run --privileged --rm tonistiigi/binfmt:latest --install all
docker context create tls-environment
docker buildx create --driver=docker-container --name=buildkit-builder --use tls-environment
docker buildx inspect --bootstrap
docker buildx install