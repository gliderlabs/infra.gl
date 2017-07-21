variable "_src" { default = "github.com/gliderlabs/infra.gl/sandbox" }

variable "access_key" { type = "string" }
variable "secret_key" { type = "string" }

variable "datadog_key" { type = "string" }

variable "size" {
  default = "t2.medium"
}

variable "count" {
  default = 1
}

variable "region" {
  default = "us-east-1"
}

variable "office_ip" {
  default = "136.62.65.95/32"
}

variable "vpc_id" { type = "string" }

provider "aws" {
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
    region = "${var.region}"
}

module "keys" {
  source = "../keys"
}

output "name_servers" {
  value = "${aws_route53_zone.sandbox_infra_gl.name_servers}"
}
