#!/usr/bin/env bash

##########################################################################################################

set -e

##########################################################################################################

_gather-environment 'HOME'

##########################################################################################################

: "${WISH_NPM_DOCKER_IMAGE:=node}"
: "${WISH_NPM_DOCKER_IMAGE_TAG:=lts-alpine}"
: "${WISH_NPM_DOCKER_IMAGE_CMD:=npm}"
: "${WISH_NPM_DOCKER_IMAGE_CACHE_VOLUME:=WISH_NPM_DOCKER_IMAGE_CACHE_VOLUME}"
: "${WISH_NPM_DOCKER_IMAGE_CACHE_DIR:=/tmp/npm/cache}"

##########################################################################################################

_docker-pull-image "${WISH_NPM_DOCKER_IMAGE}:${WISH_NPM_DOCKER_IMAGE_TAG}"

##########################################################################################################

run="docker run --tty --interactive --rm --user $(id -u) --workdir $(pwd) --volume $(pwd):$(pwd) --volume /var/run/docker.sock:/var/run/docker.sock --volume ${WISH_NPM_DOCKER_IMAGE_CACHE_VOLUME}_UID_$(id -u):${WISH_NPM_DOCKER_IMAGE_CACHE_DIR} --env-file /tmp/env ${WISH_NPM_DOCKER_IMAGE}:${WISH_NPM_DOCKER_IMAGE_TAG} ${WISH_NPM_DOCKER_IMAGE_CMD} $@"

##########################################################################################################

_docker-run-image "${run}"

##########################################################################################################
