
resource "aws_route53_zone" "gliderlabs_com" {
  name = "gliderlabs.com"
  comment = "${var._src}"
}

resource "aws_route53_record" "gliderlabs_com" {
   zone_id = "${aws_route53_zone.gliderlabs_com.zone_id}"
   name = "gliderlabs.com"
   type = "A"
   ttl = "300"
   records = ["127.0.0.1"]
}
