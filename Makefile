.PHONY: plan show apply destroy clean setup zones

plan: .terraform
	terraform plan -input=false

show: .terraform
	terraform show

apply: .terraform
	terraform apply -parallelism=20 -input=false

clean:
	rm -rf .terraform

test:
	circleci-builder build --config circle.yml -v $(shell pwd):/src

setup: clean .terraform

zones:
	$(MAKE) -C dns/zones apply

.terraform:
	terraform get
	terraform remote config \
      -backend=s3 \
      -backend-config="bucket=gl-infra" \
      -backend-config="key=infra.tfstate"
