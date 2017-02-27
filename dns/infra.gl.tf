
resource "aws_route53_zone" "infra_gl" {
  name = "infra.gl"
  comment = "${var._src}"
}

resource "aws_route53_record" "sandbox_infra_gl" {
  zone_id = "${aws_route53_zone.infra_gl.zone_id}"
  name    = "sandbox.infra.gl"
  type    = "NS"
  ttl     = "900"

  records = ["${var.sandbox_ns}"]
}

resource "aws_route53_record" "manifold_infra_gl" {
  zone_id = "${aws_route53_zone.infra_gl.zone_id}"
  name    = "manifold.infra.gl"
  type    = "NS"
  ttl     = "900"

  records = ["${var.manifold_ns}"]
}
