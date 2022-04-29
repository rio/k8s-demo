#!/bin/bash

set -euo pipefail

cd "$(dirname $0)/.."

# this passes dns request on through docker's dns into the host machine's dns resolver.
export K3D_FIX_DNS=1

if [ -z "$(k3d cluster get k8s-demo --no-headers)" ]; then
    k3d cluster create --config=k3d-config.yaml --wait
fi