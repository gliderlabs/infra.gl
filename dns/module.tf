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

output "name_servers" {
  value = "${
    map(
      "gliderlabs.io", "${aws_route53_zone.gliderlabs_io.name_servers}",
      "gliderlabs.com", "${aws_route53_zone.gliderlabs_com.name_servers}",
      "infra.gl", "${aws_route53_zone.infra_gl.name_servers}"
    )
  }"
}
