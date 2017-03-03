## TF State

The Terraform state produced from this code is kept on S3 for distributed coordination. It's also public, meaning it can easily be used as a sort of light
read-only API for Glider Labs infrastructure.

 * https://s3.amazonaws.com/gl-infra/infra.tfstate
 * https://s3.amazonaws.com/gl-infra/zones.tfstate

## AWS Accounts

|Name|Account|Description|Modules|
|---|---|---|---|
|infra.gl|197859916071|Top level infrastructure, payer account|dns|
|manifold.infra.gl|055471703963|Kubernetes service platform|manifold|
|sandbox.infra.gl|364456219779|Docker cluster w/ strong isolation|sandbox|
|[dev.infra.gl](https://233115379322.signin.aws.amazon.com/console)|233115379322|For experiments, has user accounts||

Only `dev.infra.gl` allows manual experimentation via user accounts.
All others need to be modified via PRs to `master`. Admins are allowed to run Terraform locally, but any changes that change infrastructure state MUST be pushed to a public branch immediately after at the very least.

## Bootstrapping

Although it should never be necessary, bootstrapping this infrastructure
from scratch requires some initial steps.

 1. Create a *public* bucket called `gl-infra` in the main account for TF state
 1. Create stable DNS zones with `make zones`
