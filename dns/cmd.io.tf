
data "aws_route53_zone" "cmd_io" {
  name = "cmd.io."
}

resource "aws_route53_record" "www_cmd_io" {
  zone_id = "${data.aws_route53_zone.cmd_io.zone_id}"
  name = "www.cmd.io"
  type = "CNAME"
  ttl = "300"
  records = ["progrium.github.io."]
}

resource "aws_route53_record" "alpha_cmd_io" {
  zone_id = "${data.aws_route53_zone.cmd_io.zone_id}"
  name = "alpha.cmd.io"
  type = "CNAME"
  ttl = "300"
  records = ["alpha-cmd-io-app-SRL5TBI-1256468209.us-east-1.elb.amazonaws.com."]
}

resource "aws_route53_record" "beta_cmd_io" {
  zone_id = "${data.aws_route53_zone.cmd_io.zone_id}"
  name = "beta.cmd.io"
  type = "A"

  alias {
    name = "dualstack.afe66be0cfa1411e6972012bfb514bbc-1840468626.us-east-1.elb.amazonaws.com."
    zone_id = "${data.aws_elb_hosted_zone_id.main.id}"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "cmd_io" {
  zone_id = "${data.aws_route53_zone.cmd_io.zone_id}"
  name = "cmd.io"
  type = "A"

  alias {
    name = "dualstack.alpha-cmd-io-app-srl5tbi-1256468209.us-east-1.elb.amazonaws.com."
    zone_id = "${data.aws_elb_hosted_zone_id.main.id}"
    evaluate_target_health = false
  }
}
