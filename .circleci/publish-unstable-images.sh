#!/bin/bash

set -e

echo "Preparing to push unstable images..."
echo "Branch : ${CIRCLE_BRANCH}"
echo "Tag    : ${CIRCLE_TAG}"
echo "Commit : ${CIRCLE_SHA1}"
echo
echo "Logging into gcr.io..."
# docker login -u _json_key --password-stdin https://gcr.io <<< "$GCR_API_KEY"

# Push with unstable tag
V=1 TAG=unstable CACHE_FROM_TAG=${CIRCLE_SHA1}-cache make images
V=1 TAG=unstable CACHE_FROM_TAG=${CIRCLE_SHA1}-scratch-cache make scratch-images