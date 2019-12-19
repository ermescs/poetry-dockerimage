#!/usr/bin/env bash

set -e

if [ "a${1}" == "a" ]; then
    echo "Syntax: ${0} <python version> (<alpine_version>)"
    exit 1
fi

REPO="ermescs/poetry:python${1}-alpine"
BUILD_ARGS="--build-arg PYTHON_VERSION=${1}"

if [ "a${2}" != "a" ]; then
    REPO="${REPO}${2}"
    BUILD_ARGS="${BUILD_ARGS} --build-arg ALPINE_VERSION=${2}"
fi

echo "Building '${REPO}'"

docker build --pull \
    ${BUILD_ARGS} \
    -t $REPO .

read -p "Do you want to push '${REPO}' to the Docker public registry? [yN] " answer
case $answer in
    [yY] )
        docker push ${REPO}
        ;;
    * )
        ;;
esac
