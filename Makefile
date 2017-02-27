.PHONY: plan show apply destroy clean setup

plan: .terraform
	terraform plan -input=false

show: .terraform
	terraform show

apply: .terraform
	terraform apply -input=false

clean:
	rm -rf .terraform

test:
	circleci-builder --config circle.local.yml -v $(pwd):/src

setup: clean .terraform

.terraform:
	terraform get
	terraform remote config \
      -backend=s3 \
      -backend-config="bucket=gl-infra" \
      -backend-config="key=infra.tfstate"
