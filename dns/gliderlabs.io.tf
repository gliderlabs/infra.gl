
resource "aws_route53_zone" "gliderlabs_io" {
  name = "gliderlabs.io"
  comment = "${var._src}"
}

resource "aws_route53_record" "gliderlabs_io" {
   zone_id = "${aws_route53_zone.gliderlabs_io.zone_id}"
   name = "gliderlabs.io"
   type = "A"
   ttl = "300"
   records = ["127.0.0.1"]
}
