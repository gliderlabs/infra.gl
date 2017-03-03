.PHONY: validate cluster plan apply pull push delete-cluster

ZONE = $(AWS_DEFAULT_REGION)a
BUCKET = gl-manifold
DOMAIN = manifold.infra.gl
INFRA_STATE = "https://s3.amazonaws.com/gl-infra/infra.tfstate"
VPC_ID = $(shell curl -s $(INFRA_STATE) | jq -r .modules[0].outputs.vpc_id.value)

validate:
	kubectl get nodes
	kops validate cluster --state s3://$(BUCKET)

cluster:
	kops create cluster --vpc $(VPC_ID) --state s3://$(BUCKET) --zones $(ZONE) $(DOMAIN) --yes

plan: validate
	kops update cluster --state s3://$(BUCKET) $(DOMAIN)

apply:
	kops update cluster --state s3://$(BUCKET) $(DOMAIN) --yes
	kops rolling-update cluster --state s3://$(BUCKET) $(DOMAIN) --yes

addons:
	kubectl apply -f https://raw.githubusercontent.com/kubernetes/kops/master/addons/kubernetes-dashboard/v1.5.0.yaml
	kubectl apply -f https://raw.githubusercontent.com/kubernetes/kops/master/addons/monitoring-standalone/v1.2.0.yaml

pull:
	aws s3 sync s3://$(BUCKET)/$(DOMAIN) ./cluster

push:
	aws s3 sync ./cluster s3://$(BUCKET)/$(DOMAIN)

delete-cluster:
	kops delete cluster --state s3://$(BUCKET) $(DOMAIN) --yes
