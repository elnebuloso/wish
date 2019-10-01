#!/bin/bash

##########################################################################################################

set -e

##########################################################################################################

: "${WISH_VERBOSE_LEVEL:=0}"

##########################################################################################################

printenv | sort > /tmp/env

# remove environment variables that should not be gathered
for i in $(echo $1 | sed "s/,/ /g")
do
    sed -i "/^$i/d" /tmp/env
done

if [[ ${WISH_VERBOSE_LEVEL} -gt 1 ]]; then
    cat /tmp/env
fi

##########################################################################################################
