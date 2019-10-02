#!/bin/bash

##########################################################################################################

set -e

##########################################################################################################

_gather-environment 'HOME'

##########################################################################################################

ARGS=""

: "${WISH_PHING_DOCKER_IMAGE:=elnebuloso/phing}"
: "${WISH_PHING_DOCKER_IMAGE_TAG:=latest}"
: "${WISH_PHING_DOCKER_IMAGE_CMD:=phing}"

##########################################################################################################

while [[ "$#" -gt 0 ]]
do
  case $1 in
    -i|--img)
      WISH_PHING_DOCKER_IMAGE="$2"
      shift
      ;;
    -t|--tag)
      WISH_PHING_DOCKER_IMAGE_TAG="$2"
      shift
      ;;
    -c|--cmd)
      WISH_PHING_DOCKER_IMAGE_CMD="$2"
      shift
      ;;
    *)
      ARGS="${ARGS}${1} "
  esac
  shift
done

##########################################################################################################

_docker-pull-image "${WISH_PHING_DOCKER_IMAGE}:${WISH_PHING_DOCKER_IMAGE_TAG}"

##########################################################################################################

run="docker run --tty --interactive --rm --user $(id -u) --workdir $(pwd) --volume $(pwd):$(pwd) --env-file /tmp/env ${WISH_PHING_DOCKER_IMAGE}:${WISH_PHING_DOCKER_IMAGE_TAG} ${WISH_PHING_DOCKER_IMAGE_CMD} ${ARGS}"

##########################################################################################################

_docker-run-image "${run}"

##########################################################################################################