#!/usr/bin/env bash

##########################################################################################################

set -e

##########################################################################################################

_gather-environment 'HOME'

##########################################################################################################

: ${PHING_PHPMETRICS2_DOCKER_IMAGE:=elnebuloso/php-phpmetrics}
: ${PHING_PHPMETRICS2_DOCKER_IMAGE_TAG:=2}
: ${PHING_PHPMETRICS2_DOCKER_IMAGE_CMD:=}

##########################################################################################################

_docker-pull-image "${PHING_PHPMETRICS2_DOCKER_IMAGE}:${PHING_PHPMETRICS2_DOCKER_IMAGE_TAG}"

##########################################################################################################

run="docker run --tty --interactive --rm --user $(id -u) --workdir $(pwd) --volume $(pwd):$(pwd) --volume /var/run/docker.sock:/var/run/docker.sock --env-file /tmp/env ${PHING_PHPMETRICS2_DOCKER_IMAGE}:${PHING_PHPMETRICS2_DOCKER_IMAGE_TAG} ${PHING_PHPMETRICS2_DOCKER_IMAGE_CMD} $@"

##########################################################################################################

_docker-run-image "${run}"

##########################################################################################################
