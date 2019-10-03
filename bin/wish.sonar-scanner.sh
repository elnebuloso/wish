#!/usr/bin/env bash

##########################################################################################################

set -e

##########################################################################################################

_gather-environment 'HOME'

##########################################################################################################

: ${WISH_SONAR_SCANNER_DOCKER_IMAGE:=elnebuloso/sonarqube-scanner}
: ${WISH_SONAR_SCANNER_DOCKER_IMAGE_TAG:=latest}
: ${WISH_SONAR_SCANNER_DOCKER_IMAGE_CMD:=sonar-scanner}

##########################################################################################################

_docker-pull-image "${WISH_SONAR_SCANNER_DOCKER_IMAGE}:${WISH_SONAR_SCANNER_DOCKER_IMAGE_TAG}"

##########################################################################################################

run="docker run --tty --interactive --rm --user $(id -u) --workdir $(pwd) --volume $(pwd):$(pwd) --volume /var/run/docker.sock:/var/run/docker.sock --env-file /tmp/env ${WISH_SONAR_SCANNER_DOCKER_IMAGE}:${WISH_SONAR_SCANNER_DOCKER_IMAGE_TAG} ${WISH_SONAR_SCANNER_DOCKER_IMAGE_CMD} $@"

##########################################################################################################

_docker-run-image "${run}"

##########################################################################################################
