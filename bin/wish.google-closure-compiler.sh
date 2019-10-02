#!/usr/bin/env bash

##########################################################################################################

set -e

##########################################################################################################

_gather-environment 'HOME'

##########################################################################################################

: "${WISH_GOOGLE_CLOSURE_COMPILER_DOCKER_IMAGE:=elnebuloso/google-closure-compiler}"
: "${WISH_GOOGLE_CLOSURE_COMPILER_DOCKER_IMAGE_TAG:=latest}"
: "${WISH_GOOGLE_CLOSURE_COMPILER_DOCKER_IMAGE_CMD:=}"

##########################################################################################################

_docker-pull-image "${WISH_GOOGLE_CLOSURE_COMPILER_DOCKER_IMAGE}:${WISH_GOOGLE_CLOSURE_COMPILER_DOCKER_IMAGE_TAG}"

##########################################################################################################

run="docker run --tty --interactive --rm --user $(id -u) --workdir $(pwd) --volume $(pwd):$(pwd)  --env-file /tmp/env ${WISH_GOOGLE_CLOSURE_COMPILER_DOCKER_IMAGE} ${WISH_GOOGLE_CLOSURE_COMPILER_DOCKER_IMAGE_CMD} $@"

##########################################################################################################

_docker-run-image "${run}"

##########################################################################################################
