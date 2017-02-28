variable "_src" { default = "github.com/gliderlabs/infra.gl/dns" }

variable "access_key" { type = "string" }
variable "secret_key" { type = "string" }

variable "sandbox_ns" { type = "list" }
variable "manifold_ns" { type = "list" }

provider "aws" {
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
    region = "us-east-1"
}

data "aws_elb_hosted_zone_id" "main" { }
