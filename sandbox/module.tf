variable "_src" { default = "github.com/gliderlabs/infra.gl/sandbox" }

variable "access_key" { type = "string" }
variable "secret_key" { type = "string" }

variable "size" {
  default = "t2.medium"
}

variable "count" {
  default = 2
}

variable "office_ip" {
  default = "136.62.65.95/32"
}

provider "aws" {
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
    region = "us-east-1"
}

module "keys" {
  source = "../keys"
}

output "vpc_id" {
  value = "${aws_vpc.main.id}"
}

output "name_servers" {
  value = "${aws_route53_zone.sandbox_infra_gl.name_servers}"
}
