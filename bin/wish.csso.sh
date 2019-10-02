#!/bin/bash

##########################################################################################################

set -e

##########################################################################################################

_gather-environment 'HOME'

##########################################################################################################

ARGS=""

: "${WISH_CSSO_DOCKER_IMAGE:=elnebuloso/csso-cli}"
: "${WISH_CSSO_DOCKER_IMAGE_TAG:=latest}"
: "${WISH_CSSO_DOCKER_IMAGE_CMD:=}"

##########################################################################################################

while [[ "$#" -gt 0 ]]
do
  case $1 in
    -i|--img)
      WISH_CSSO_DOCKER_IMAGE="$2"
      shift
      ;;
    -t|--tag)
      WISH_CSSO_DOCKER_IMAGE_TAG="$2"
      shift
      ;;
    -c|--cmd)
      WISH_CSSO_DOCKER_IMAGE_CMD="$2"
      shift
      ;;
    *)
      ARGS="${ARGS}${1} "
  esac
  shift
done

##########################################################################################################

_docker-pull-image "${WISH_CSSO_DOCKER_IMAGE}:${WISH_CSSO_DOCKER_IMAGE_TAG}"

##########################################################################################################

run="docker run --tty --interactive --rm --user $(id -u) --workdir $(pwd) --volume $(pwd):$(pwd) --env-file /tmp/env ${WISH_CSSO_DOCKER_IMAGE}:${WISH_CSSO_DOCKER_IMAGE_TAG} ${WISH_CSSO_DOCKER_IMAGE_CMD} ${ARGS}"

##########################################################################################################

_docker-run-image "${run}"

##########################################################################################################