.PHONY: validate plan apply pull push delete-cluster

BUCKET = gl-manifold
DOMAIN = manifold.infra.gl

validate:
	kubectl get nodes
	kops validate cluster --state s3://$(BUCKET)

plan: validate
	kops update cluster --state s3://$(BUCKET) $(DOMAIN)

apply:
	kops update cluster --state s3://$(BUCKET) $(DOMAIN) --yes
	kops rolling-update cluster --state s3://$(BUCKET) $(DOMAIN) --yes

pull:
	aws s3 sync s3://$(BUCKET)/$(DOMAIN) ./cluster

push:
	aws s3 sync ./cluster s3://$(BUCKET)/$(DOMAIN)

teardown:
	kops delete cluster --state s3://$(BUCKET) $(DOMAIN) --yes
