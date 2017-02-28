
data "aws_route53_zone" "gliderlabs_io" {
  name = "gliderlabs.io."
}

resource "aws_route53_record" "gliderlabs_io" {
   zone_id = "${data.aws_route53_zone.gliderlabs_io.zone_id}"
   name = "gliderlabs.io"
   type = "A"
   ttl = "300"
   records = ["151.101.44.133"]
}
