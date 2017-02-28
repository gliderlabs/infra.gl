variable "_src" { default = "github.com/gliderlabs/infra.gl/manifold" }

variable "access_key" { type = "string" }
variable "secret_key" { type = "string" }

provider "aws" {
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
    region = "us-east-1"
}

output "name_servers" {
  value = "${aws_route53_zone.manifold_infra_gl.name_servers}"
}
