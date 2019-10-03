#!/usr/bin/env bash

##########################################################################################################

set -e

##########################################################################################################

_gather-environment 'HOME'

##########################################################################################################

: ${WISH_PHPCPD_DOCKER_IMAGE:=elnebuloso/php-phpcpd}
: ${WISH_PHPCPD_DOCKER_IMAGE_TAG:=4}
: ${WISH_PHPCPD_DOCKER_IMAGE_CMD:=}

##########################################################################################################

_docker-pull-image "${WISH_PHPCPD_DOCKER_IMAGE}:${WISH_PHPCPD_DOCKER_IMAGE_TAG}"

##########################################################################################################

run="docker run --tty --interactive --rm --user $(id -u) --workdir $(pwd) --volume $(pwd):$(pwd) --volume /var/run/docker.sock:/var/run/docker.sock --env-file /tmp/env ${WISH_PHPCPD_DOCKER_IMAGE}:${WISH_PHPCPD_DOCKER_IMAGE_TAG} ${WISH_PHPCPD_DOCKER_IMAGE_CMD} $@"

##########################################################################################################

_docker-run-image "${run}"

##########################################################################################################
