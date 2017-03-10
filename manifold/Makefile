.PHONY: validate plan apply pull push sync teardown

BUCKET = gl-manifold
DOMAIN = manifold.infra.gl

validate:
	kubectl get nodes
	kops validate cluster --state s3://$(BUCKET)

plan: validate
	kops update cluster --state s3://$(BUCKET) $(DOMAIN)

config:
	kops export kubecfg --state s3://$(BUCKET) $(DOMAIN)

apply:
	kops update cluster --state s3://$(BUCKET) $(DOMAIN) --yes
	kops rolling-update cluster --node-interval 8m --state s3://$(BUCKET) $(DOMAIN) --yes

pull:
	aws s3 sync --exact-timestamps s3://$(BUCKET)/$(DOMAIN) ./cluster

push:
	aws s3 sync --exact-timestamps ./cluster s3://$(BUCKET)/$(DOMAIN)

sync:
	$(MAKE) pull
	$(MAKE) push

teardown:
	kops delete cluster --state s3://$(BUCKET) $(DOMAIN) --yes
