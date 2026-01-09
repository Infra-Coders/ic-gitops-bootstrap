# ic-gitops-bootstrap
InfraCoders Kube GitOps Bootstraping - **Flux**.
Below documentation is [Flux documentation](https://fluxcd.io/flux/) summary.

## Bootstrap FluxCD

```bash
./scripts/INSTALL_FLUX.sh
```

## How we will use it

At the moment, by default, ic-gitops-central repository will be boostrapped by Flux - clusters/dev directory.
New references can be configured as GitRepository source, remember to put it in the clusters/dev direcotyr in ic-gitops-central.

## Possible Flux repositories structures

Monorepo, repo per environment, repo per team, repo per app [Link](https://fluxcd.io/flux/guides/repository-structure/#repo-per-team).


## Flux Components (ToolKit Components)

Flux consists of multiple components which works together to provide Continous Delivery on Kubernetes - [Flux - components](https://fluxcd.io/flux/components/).

### Source Controllers

Provides a common interface for artifacts acquisition (delivered as API endpoints), those can be:

- Git repositories - [Working with GitRepositories](https://fluxcd.io/flux/components/source/gitrepositories/#working-with-gitrepositories)
- OCI Repositories
- Buckets
- Helm Repositories
- Helm Charts
- External Artifacts - for 3rd party controllers
- Artifact Generators - can be used to compose (from multiple source) or splitting source into multiple deployable artifact

From Flux v2.7.0 can be extended with [Source Watcher](https://fluxcd.io/flux/components/source/#source-watcher).

### Kustomize Controller

Manages infrastructure and workloads defined with Kubernetes manifests and assembled with Kustomize.

### Helm Controller

Watches for Helm Releases.
Supports HelmChart artifacts produced by HelmRepostiries and GitRepositories from Source controllers.

### Notification Controller

Handles inbound and outbound events.
Notifies toolkiy controllers about source changes, can send events to external systems - Slack, MS Team, etc.

### Image reflector and automation controllers

Scans image reopsitories and reflects image metadata in Kubernetes sources.
Image Automation Controller updates yaml files based on the latest images scanned and commits the changes to a given Git repository.
E.g. one can define a policy, for an image repository, to define version range.

### Source Watcher

Allows new artifacts creation out of other resources.

## Create GIT repository source

See - [Git Repositories] https://fluxcd.io/flux/components/source/gitrepositories/.
Put GitRepository Flux manifest in [ic-gitops-central](https://github.com/Infra-Coders/ic-gitops-central) to add new repositories.

### Create PAT

**PAT is not needed for public repositories.**

PAT (Personal Access Token) is required to be provided to Flux so it can, at least, read the repository.
To create one in Git
https://github.com/settings/personal-access-tokens

### Create secret containing PAT token

```bash
flux create secret git flux-system \
  --url=https://gitlab.com/my-org/my-fleet.git \
  --username=git \
  --password=$GITHUB_TOKEN
```
