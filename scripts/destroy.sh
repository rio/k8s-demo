#!/bin/bash

set -euo pipefail

cd "$(dirname $0)/.."

if command -v k3d; then
    if [ -n "$(k3d cluster list k8s-demo --no-headers)" ]; then
        k3d cluster delete k8s-demo
    fi
fi
