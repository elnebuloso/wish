#!/bin/bash

##########################################################################################################

set -e

##########################################################################################################

: "${WISH_VERBOSE_LEVEL:=0}"
: "${WISH_DOCKER_IMAGES_PULL_ALWAYS:=yes}"
: "${WISH_DOCKER_IMAGES_PULL_PERIOD:=1 hour}"

##########################################################################################################

if [[ ${WISH_DOCKER_IMAGES_PULL_ALWAYS} = "yes" ]]; then
    if [[ ${WISH_VERBOSE_LEVEL} -gt 0 ]]; then
        echo "wish: pulling image: $1 forced"
        docker pull $1
    else
        docker pull $1 > /dev/null 2>&1
    fi
else
    if [[ "$(docker run --volume is_expired:/tmp elnebuloso/is-expired $1 ${WISH_DOCKER_IMAGES_PULL_PERIOD})" = "yes" ]]; then
        if [[ ${WISH_VERBOSE_LEVEL} -gt 0 ]]; then
            echo "wish: pulling image: $1 expired ${WISH_DOCKER_IMAGES_PULL_PERIOD}"
            docker pull $1
        else
            docker pull $1 > /dev/null 2>&1
        fi
    fi;
fi

##########################################################################################################
