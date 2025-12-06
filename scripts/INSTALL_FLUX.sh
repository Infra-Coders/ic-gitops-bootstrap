#!/bin/bash

set -uo pipefail

podman_helm upgrade --install flux-operator oci://ghcr.io/controlplaneio-fluxcd/charts/flux-operator --namespace flux-system --create-namespace --wait 

podman_kubectl create -f ./fluxinstance-values/fluxinstance.yaml
