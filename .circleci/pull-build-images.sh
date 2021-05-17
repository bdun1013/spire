#!/bin/bash

set -e

echo "Preparing to pull build images..."
echo "Branch : ${CIRCLE_BRANCH}"
echo "Tag    : ${CIRCLE_TAG}"
echo "Commit : ${CIRCLE_SHA1}"
echo
echo "Logging into gcr.io..."
# docker login -u _json_key --password-stdin https://gcr.io <<< "$GCR_API_KEY"

# Pull build images and tag as latest-local
docker pull docker.io/boxboatbrian/spire-server:${CIRCLE_SHA1}
docker tag docker.io/boxboatbrian/spire-server:${CIRCLE_SHA1} spire-server:latest-local

docker pull docker.io/boxboatbrian/spire-agent:${CIRCLE_SHA1}
docker tag docker.io/boxboatbrian/spire-agent:${CIRCLE_SHA1} spire-agent:latest-local

docker pull docker.io/boxboatbrian/k8s-workload-registrar:${CIRCLE_SHA1}
docker tag docker.io/boxboatbrian/k8s-workload-registrar:${CIRCLE_SHA1} k8s-workload-registrar:latest-local

docker pull docker.io/boxboatbrian/oidc-discovery-provider:${CIRCLE_SHA1}
docker tag docker.io/boxboatbrian/oidc-discovery-provider:${CIRCLE_SHA1} oidc-discovery-provider:latest-local

docker pull docker.io/boxboatbrian/spire-server:${CIRCLE_SHA1}-scratch
docker tag docker.io/boxboatbrian/spire-server:${CIRCLE_SHA1}-scratch spire-server-scratch:latest-local

docker pull docker.io/boxboatbrian/spire-agent:${CIRCLE_SHA1}-scratch
docker tag docker.io/boxboatbrian/spire-agent:${CIRCLE_SHA1}-scratch spire-agent-scratch:latest-local

docker pull docker.io/boxboatbrian/k8s-workload-registrar:${CIRCLE_SHA1}-scratch
docker tag docker.io/boxboatbrian/k8s-workload-registrar:${CIRCLE_SHA1}-scratch k8s-workload-registrar-scratch:latest-local

docker pull docker.io/boxboatbrian/oidc-discovery-provider:${CIRCLE_SHA1}-scratch
docker tag docker.io/boxboatbrian/oidc-discovery-provider:${CIRCLE_SHA1}-scratch oidc-discovery-provider-scratch:latest-local