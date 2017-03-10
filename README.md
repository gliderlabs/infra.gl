## TF State

The Terraform state produced from this code is kept on S3 for distributed coordination. It's also public, meaning it can easily be used as a sort of light
read-only API for Glider Labs infrastructure.

 * https://s3.amazonaws.com/gl-infra/infra.tfstate
 * https://s3.amazonaws.com/gl-infra/zones.tfstate

## AWS Accounts

|Name|Account|Description|Modules|
|---|---|---|---|
|infra.gl|197859916071|Top level infrastructure, payer account|dns|
|manifold.infra.gl|055471703963|Kubernetes + Sandbox cluster|manifold,sandbox|
|[dev.infra.gl](https://233115379322.signin.aws.amazon.com/console)|233115379322|For experiments, has user accounts||
||364456219779|Unused||

Only `dev.infra.gl` allows manual experimentation via user accounts.
All others need to be modified via PRs to `master`. Admins are allowed to run Terraform locally, but any changes that change infrastructure state MUST be pushed to a public branch immediately after at the very least.

## Bootstrapping

Although it should rarely be necessary, bootstrapping this infrastructure
from scratch requires some initial steps.

 1. Create a bucket called `gl-infra` in the main account for TF state
 1. Create stable DNS zones with `make zones`
 1. Now you can provision everything else with `make apply`

Any apps will need to be re-bootstrapped. This process is generally:

 1. Apply secrets spec for the app in the approrpriate namespace
 1. Make an `<app>-ci` service account with `manifold/scripts/service-account`
 1. Base64 encode this output and set `KUBE_CONFIG` env var in the app CI
 1. Build (or just rebuild) the app on CI
 1. Update DNS records with the created Kubernetes service endpoint

## Manifold Namespaces

Manifold uses Kubernetes namespaces. There are three namespaces currently:

 * `default` - the default namespace is for experiments and should be kept empty
 * `gliderlabs` - where we run misc production daemons and services
 * `cmd` - production namespace for Cmd.io and its release channels

Any major application that has multiple release channels should live in its
own namespace. You should add that namespace to the `namespaces.yaml` spec in
`manifold/specs` and then manually apply that spec.

## Teardown

When developing or debugging a test/dev deployment, you'll probably be tearing
down everything quite a bit to make sure everything comes up correctly. This
is currently a two step process:

 1. Teardown the Manifold Kubernetes cluster: `make -C manifold teardown`
 2. Destroy remaining resources with Terraform: `terraform destroy`
