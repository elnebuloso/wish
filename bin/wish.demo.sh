#!/bin/bash

##########################################################################################################

FLAG=""
DATA=""
ARGS=""

##########################################################################################################

while [[ "$#" -gt 0 ]]
do
  case $1 in
    -f|--flag)
      FLAG="enabled"
      ;;
    -d|--data)
      DATA="$2"
      shift
      ;;
    *)
      ARGS="${ARGS}${1} "
  esac
  shift
done

##########################################################################################################

echo "FLAG: ${FLAG}"
echo "DATA: ${DATA}"
echo "ARGS: ${ARGS}"

##########################################################################################################