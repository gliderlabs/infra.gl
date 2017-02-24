
## AWS Accounts

|Name|Account|Description|Modules|
|---|---|---|---|
|infra.gl|197859916071|Top level infrastructure, payer account|dns|
|manifold.infra.gl|055471703963|Kubernetes service platform|manifold|
|sandbox.infra.gl|364456219779|Docker cluster w/ strong isolation|sandbox|
|[dev.infra.gl](https://233115379322.signin.aws.amazon.com/console)|233115379322|For experiments, has user accounts||

Only `dev.infra.gl` allows manual experimentation via user accounts.
All others need to be modified via PRs to `master`.
