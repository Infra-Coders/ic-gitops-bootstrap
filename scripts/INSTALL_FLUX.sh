#!/bin/bash

set -uo pipefail

helm upgrade --install flux-operator oci://ghcr.io/controlplaneio-fluxcd/charts/flux-operator --namespace flux-system --create-namespace --wait 

kubectl create -f ./fluxinstance-values/fluxinstance.yaml
