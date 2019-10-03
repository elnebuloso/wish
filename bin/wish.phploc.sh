#!/usr/bin/env bash

##########################################################################################################

set -e

##########################################################################################################

_gather-environment 'HOME'

##########################################################################################################

: ${WISH_PHPLOC_DOCKER_IMAGE:=elnebuloso/php-phploc}
: ${WISH_PHPLOC_DOCKER_IMAGE_TAG:=4}
: ${WISH_PHPLOC_DOCKER_IMAGE_CMD:=}

##########################################################################################################

_docker-pull-image "${WISH_PHPLOC_DOCKER_IMAGE}:${WISH_PHPLOC_DOCKER_IMAGE_TAG}"

##########################################################################################################

run="docker run --tty --interactive --rm --user $(id -u) --workdir $(pwd) --volume $(pwd):$(pwd) --volume /var/run/docker.sock:/var/run/docker.sock --env-file /tmp/env ${WISH_PHPLOC_DOCKER_IMAGE}:${WISH_PHPLOC_DOCKER_IMAGE_TAG} ${WISH_PHPLOC_DOCKER_IMAGE_CMD} $@"

##########################################################################################################

_docker-run-image "${run}"

##########################################################################################################
