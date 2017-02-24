.PHONY: plan apply destroy clean setup

plan: .terraform
	terraform plan -input=false

apply: .terraform
	terraform apply -input=false

destroy: .terraform
	terraform destroy -force

clean:
	rm -rf .terraform

test:
	circleci-builder -v $(pwd):/src

setup: clean .terraform

.terraform:
	terraform get
	terraform remote config \
      -backend=s3 \
      -backend-config="bucket=gl-infra" \
      -backend-config="key=infra.tfstate"
