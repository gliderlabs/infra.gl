.PHONY: validate cluster plan apply pull push delete-cluster

ZONE = $(AWS_DEFAULT_REGION)a
BUCKET = gl-infra-manifold
DOMAIN = manifold.infra.gl

validate:
	kubectl get nodes
	kops validate cluster

cluster:
	kops create cluster --state s3://$(BUCKET) --zones $(ZONE) $(DOMAIN) --yes

plan: validate
	kops update cluster --state s3://$(BUCKET) $(DOMAIN)

apply:
	kops update cluster --state s3://$(BUCKET) $(DOMAIN) --yes
	kops rolling-update cluster --state s3://$(BUCKET) $(DOMAIN) --yes

pull:
	aws s3 sync s3://$(BUCKET)/$(DOMAIN) ./cluster

push:
	aws s3 sync ./cluster s3://$(BUCKET)/$(DOMAIN)

delete-cluster:
	kops delete cluster $(DOMAIN) --yes
