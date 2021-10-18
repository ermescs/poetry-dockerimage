#!/usr/bin/env bash

set -e

if [ "a${1}" == "a" ]; then
    echo "Syntax: ${0} <poetry version> <python version> <debian version>"
    exit 1
fi

REPO="ermescs/poetry:${1}-python${2}-${3}"
BUILD_ARGS="--build-arg POETRY_VERSION=${1} --build-arg PYTHON_VERSION=${2} --build-arg DEBIAN_VERSION=${3}"

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
