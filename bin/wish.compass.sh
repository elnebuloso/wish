#!/usr/bin/env bash

##########################################################################################################

set -e

##########################################################################################################

_gather-environment 'HOME'

##########################################################################################################

: "${WISH_COMPASS_DOCKER_IMAGE:=elnebuloso/compass}"
: "${WISH_COMPASS_DOCKER_IMAGE_TAG:=latest}"
: "${WISH_COMPASS_DOCKER_IMAGE_CMD:=compass}"

##########################################################################################################

_docker-pull-image "${WISH_COMPASS_DOCKER_IMAGE}:${WISH_COMPASS_DOCKER_IMAGE_TAG}"

##########################################################################################################

run="docker run --tty --interactive --rm --user $(id -u) --workdir $(pwd) --volume $(pwd):$(pwd) --volume /var/run/docker.sock:/var/run/docker.sock --env-file /tmp/env ${WISH_COMPASS_DOCKER_IMAGE}:${WISH_COMPASS_DOCKER_IMAGE_TAG} ${WISH_COMPASS_DOCKER_IMAGE_CMD} $@"

##########################################################################################################

_docker-run-image "${run}"

##########################################################################################################
