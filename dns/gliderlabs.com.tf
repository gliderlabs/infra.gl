
resource "aws_route53_zone" "gliderlabs_com" {
  name = "gliderlabs.com"
  comment = "${var._src}"
}

resource "aws_route53_record" "www_gliderlabs_com" {
   zone_id = "${aws_route53_zone.gliderlabs_com.zone_id}"
   name = "www.gliderlabs.com"
   type = "A"
   ttl = "300"
   records = ["104.31.77.199"]
}
