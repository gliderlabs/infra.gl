variable "_src" { default = "github.com/gliderlabs/infra.gl/dns" }

provider "aws" {
    region = "us-east-1"
}

resource "aws_route53_zone" "cmd_io" {
  name = "cmd.io"
  comment = "${var._src}"
}

resource "aws_route53_zone" "gliderlabs_com" {
  name = "gliderlabs.com"
  comment = "${var._src}"
}

resource "aws_route53_zone" "gliderlabs_io" {
  name = "gliderlabs.io"
  comment = "${var._src}"
}

resource "aws_route53_zone" "infra_gl" {
  name = "infra.gl"
  comment = "${var._src}"
}

output "name_servers" {
  value = "${
    map(
      "gliderlabs.io", "${aws_route53_zone.gliderlabs_io.name_servers}",
      "gliderlabs.com", "${aws_route53_zone.gliderlabs_com.name_servers}",
      "infra.gl", "${aws_route53_zone.infra_gl.name_servers}",
      "cmd.io", "${aws_route53_zone.cmd_io.name_servers}"
    )
  }"
}
