
resource "aws_route53_zone" "sandbox_infra_gl" {
  name = "sandbox.infra.gl"
}

resource "aws_route53_record" "sandbox_infra_gl" {
  zone_id = "${aws_route53_zone.sandbox_infra_gl.zone_id}"
  name    = "_docker._tcp"
  type    = "SRV"
  ttl     = "30"
  records = ["${formatlist("0 100 2376 %s", aws_instance.node.*.public_dns)}"]
}
