#!/bin/bash

set -e

echo "Preparing to push release images..."
echo "Branch : ${CIRCLE_BRANCH}"
echo "Tag    : ${CIRCLE_TAG}"
echo "Commit : ${CIRCLE_SHA1}"
echo
echo "Logging into gcr.io..."
# docker login -u _json_key --password-stdin https://gcr.io <<< "$GCR_API_KEY"

# Strip the leading "v" off of the tag name. SPIRE images are
# tagged with just the version number.
TAG=${CIRCLE_TAG##v}

V=1 TAG=${TAG} CACHE_FROM_TAG=${CIRCLE_SHA1}-cache make images
V=1 TAG=${TAG} CACHE_FROM_TAG=${CIRCLE_SHA1}-scratch-cache make scratch-images
