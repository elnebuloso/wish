#!/usr/bin/env bash

##########################################################################################################

set -e

##########################################################################################################

_gather-environment 'HOME'

##########################################################################################################

: ${WISH_PHPMETRICS2_DOCKER_IMAGE:=elnebuloso/php-phpmetrics}
: ${WISH_PHPMETRICS2_DOCKER_IMAGE_TAG:=2}
: ${WISH_PHPMETRICS2_DOCKER_IMAGE_CMD:=}

##########################################################################################################

_docker-pull-image "${WISH_PHPMETRICS2_DOCKER_IMAGE}:${WISH_PHPMETRICS2_DOCKER_IMAGE_TAG}"

##########################################################################################################

run="docker run --tty --interactive --rm --user $(id -u) --workdir $(pwd) --volume $(pwd):$(pwd) --volume /var/run/docker.sock:/var/run/docker.sock --env-file /tmp/env ${WISH_PHPMETRICS2_DOCKER_IMAGE}:${WISH_PHPMETRICS2_DOCKER_IMAGE_TAG} ${WISH_PHPMETRICS2_DOCKER_IMAGE_CMD} $@"

##########################################################################################################

_docker-run-image "${run}"

##########################################################################################################
