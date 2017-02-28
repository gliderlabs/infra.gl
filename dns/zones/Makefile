.PHONY: plan show apply destroy clean setup

plan: .terraform
	terraform plan -input=false

show: .terraform
	terraform show

apply: .terraform
	terraform apply -input=false

clean:
	rm -rf .terraform

setup: clean .terraform

.terraform:
	terraform remote config \
      -backend=s3 \
      -backend-config="bucket=gl-infra" \
      -backend-config="key=zones.tfstate"
