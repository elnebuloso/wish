#!/bin/bash

##########################################################################################################

set -e

##########################################################################################################

_gather-environment 'HOME'

##########################################################################################################

ARGS=""
IMAGE="composer"
TAG="latest"

while [[ "$#" -gt 0 ]]
do
  case $1 in
    -i|--image)
      IMAGE="$2"
      shift
      ;;
    -t|--tag)
      TAG="$2"
      shift
      ;;
    *)
      ARGS="${ARGS}${1} "
  esac
  shift
done

##########################################################################################################

_docker-pull-image "${IMAGE}:${TAG}"

##########################################################################################################

run="docker run --tty --interactive --rm ${IMAGE}:${TAG} ${ARGS}"

##########################################################################################################

_docker-run-image "${run}"

##########################################################################################################
