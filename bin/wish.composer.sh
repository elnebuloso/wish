#!/bin/bash

##########################################################################################################

set -e

##########################################################################################################

_gather-environment 'HOME'

##########################################################################################################

: "${WISH_COMPOSER_DOCKER_IMAGE:=composer}"
: "${WISH_COMPOSER_DOCKER_IMAGE_TAG:=latest}"
: "${WISH_COMPOSER_DOCKER_IMAGE_CMD:=}"
: "${WISH_COMPOSER_DOCKER_IMAGE_CACHE_VOLUME:=WISH_COMPOSER_DOCKER_IMAGE_CACHE_VOLUME}"
: "${WISH_COMPOSER_DOCKER_IMAGE_CACHE_DIR:=/tmp}"

##########################################################################################################

_docker-pull-image "${WISH_COMPOSER_DOCKER_IMAGE}:${WISH_COMPOSER_DOCKER_IMAGE_TAG}"

##########################################################################################################

run="docker run --tty --interactive --rm --user $(id -u) --workdir $(pwd) --volume $(pwd):$(pwd) --volume /var/run/docker.sock:/var/run/docker.sock --volume ${WISH_COMPOSER_DOCKER_IMAGE_CACHE_VOLUME}_UID_$(id -u):${WISH_COMPOSER_DOCKER_IMAGE_CACHE_DIR} --env-file /tmp/env ${WISH_COMPOSER_DOCKER_IMAGE}:${WISH_COMPOSER_DOCKER_IMAGE_TAG} ${WISH_COMPOSER_DOCKER_IMAGE_CMD} $@"

##########################################################################################################

_docker-run-image "${run}"

##########################################################################################################
