#!/bin/bash

set -e

echo "Preparing to push build images..."
echo "Branch : ${CIRCLE_BRANCH}"
echo "Tag    : ${CIRCLE_TAG}"
echo "Commit : ${CIRCLE_SHA1}"
echo
echo "Logging into gcr.io..."
# docker login -u _json_key --password-stdin https://gcr.io <<< "$GCR_API_KEY"

# Push builder and release images with git sha tag
V=1 TAG=${CIRCLE_SHA1} make builder-image
V=1 TAG=${CIRCLE_SHA1} CACHE_FROM_TAG=${CIRCLE_SHA1} make images

V=1 TAG=${CIRCLE_SHA1} make builder-image-scratch
V=1 TAG=${CIRCLE_SHA1} CACHE_FROM_TAG=${CIRCLE_SHA1} make scratch-images
