#!/bin/bash

set -eo pipefail

cd "$(dirname $0)/.."

COMMAND="$1"

function start () {
    if [ -z "$(docker container ls --quiet --filter 'name=k8s-toolbox')" ]; then
        docker run -d --name k8s-toolbox -v /var/run/docker.sock:/var/run/docker.sock --privileged --network host ghcr.io/rio/k8s-demo:v1 sleep infinity
    fi

    docker exec -ti k8s-toolbox /bin/bash
}

function stop () {
    if [ -n "$(docker container ls --quiet --filter 'name=k8s-toolbox')" ]; then
        docker exec k8s-toolbox /root/scripts/destroy.sh
        docker stop k8s-toolbox
        docker rm k8s-toolbox
    fi
}

case "$COMMAND" in
    stop)
        stop;;
    *)
        start;;
esac