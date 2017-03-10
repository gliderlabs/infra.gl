variable "_src" { default = "github.com/gliderlabs/infra.gl/manifold" }

variable "access_key" { type = "string" }
variable "secret_key" { type = "string" }

variable "region" {
  default = "us-east-1"
}

variable "cidr_block" {
  default= "10.1.0.0/16"
}

provider "aws" {
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
    region = "${var.region}"
}

module "keys" {
  source = "../keys"
}

output "name_servers" {
  value = "${aws_route53_zone.manifold_infra_gl.name_servers}"
}

output "vpc_id" {
  value = "${aws_vpc.main.id}"
}

output "repos" {
  value = "${
    map(
      "cmd", "${aws_ecr_repository.cmd.repository_url}"
    )
  }"
}
