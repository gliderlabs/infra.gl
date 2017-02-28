
data "aws_route53_zone" "gliderlabs_com" {
  name = "gliderlabs.com."
}

resource "aws_route53_record" "A_gliderlabs_com" {
  zone_id = "${data.aws_route53_zone.gliderlabs_com.zone_id}"
  name = "gliderlabs.com"
  type = "A"
  ttl = "300"
  records = ["151.101.44.133"]
}

resource "aws_route53_record" "MX_gliderlabs_com" {
  zone_id = "${data.aws_route53_zone.gliderlabs_com.zone_id}"
  name = "gliderlabs.com"
  type = "MX"
  ttl = "300"
  records = [
    "5 alt2.aspmx.l.google.com.",
    "10 aspmx2.googlemail.com.",
    "10 aspmx3.googlemail.com.",
    "5 alt1.aspmx.l.google.com.",
    "1 aspmx.l.google.com."
  ]
}

resource "aws_route53_record" "TXT_gliderlabs_com" {
  zone_id = "${data.aws_route53_zone.gliderlabs_com.zone_id}"
  name = "gliderlabs.com"
  type = "TXT"
  ttl = "300"
  records = [
    "v=spf1 include:mailgun.org ~all",
    "v=spf1 a include:_spf.google.com ~all",
    "google-site-verification=TUXuOcDGYxmIZPhW4QqgXtO9dUN9caUKks92fGPu5dE"
  ]
}

resource "aws_route53_record" "domainkey_gliderlabs_com" {
  zone_id = "${data.aws_route53_zone.gliderlabs_com.zone_id}"
  name = "mailo._domainkey.gliderlabs.com"
  type = "TXT"
  ttl = "300"
  records = [
    "k=rsa\\; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDA0/NSdYqmCYw395erGHk72Kk+5mhgbjZALaO6VhL+8l/YPeHUiRoet19c/Z3RNkmzv42SIbgyVc7cYcClxClIcEmFgTgJW4ZYkcE4YhncMcOGIXq0bJ1UgoZeETAPfw2DA8ZApIftJebHS/8Umou4T73TNHj30K7D2b8zeeaUHwIDAQAB"
  ]
}

resource "aws_route53_record" "jabber_SRV_gliderlabs_com" {
  zone_id = "${data.aws_route53_zone.gliderlabs_com.zone_id}"
  name = "_jabber._tcp.gliderlabs.com"
  type = "SRV"
  ttl = "300"
  records = [
    "5 0 5269 xmpp-server.l.google.com.",
    "20 0 5269 xmpp-server4.l.google.com.",
    "20 0 5269 xmpp-server2.l.google.com.",
    "20 0 5269 xmpp-server3.l.google.com.",
    "20 0 5269 xmpp-server1.l.google.com."
  ]
}

resource "aws_route53_record" "alpine_gliderlabs_com" {
  zone_id = "${data.aws_route53_zone.gliderlabs_com.zone_id}"
  name = "alpine.gliderlabs.com"
  type = "CNAME"
  ttl = "300"
  records = ["global.prod.fastly.net."]
}

resource "aws_route53_record" "cloudfront_gliderlabs_com" {
  zone_id = "${data.aws_route53_zone.gliderlabs_com.zone_id}"
  name = "cloudfront.gliderlabs.com"
  type = "CNAME"
  ttl = "300"
  records = ["d12ac2txctrje7.cloudfront.net."]
}

resource "aws_route53_record" "mailgun_gliderlabs_com" {
  zone_id = "${data.aws_route53_zone.gliderlabs_com.zone_id}"
  name = "mailgun.gliderlabs.com"
  type = "CNAME"
  ttl = "300"
  records = ["mailgun.org."]
}

resource "aws_route53_record" "fastly_gliderlabs_com" {
  zone_id = "${data.aws_route53_zone.gliderlabs_com.zone_id}"
  name = "fastly.gliderlabs.com"
  type = "CNAME"
  ttl = "300"
  records = ["global.prod.fastly.net."]
}

resource "aws_route53_record" "mail_gliderlabs_com" {
  zone_id = "${data.aws_route53_zone.gliderlabs_com.zone_id}"
  name = "mail.gliderlabs.com"
  type = "CNAME"
  ttl = "300"
  records = ["ghs.googlehosted.com."]
}

resource "aws_route53_record" "calendar_gliderlabs_com" {
  zone_id = "${data.aws_route53_zone.gliderlabs_com.zone_id}"
  name = "calendar.gliderlabs.com"
  type = "CNAME"
  ttl = "300"
  records = ["ghs.googlehosted.com."]
}


resource "aws_route53_record" "docs_gliderlabs_com" {
  zone_id = "${data.aws_route53_zone.gliderlabs_com.zone_id}"
  name = "docs.gliderlabs.com"
  type = "CNAME"
  ttl = "300"
  records = ["ghs.googlehosted.com."]
}


resource "aws_route53_record" "slack_gliderlabs_com" {
  zone_id = "${data.aws_route53_zone.gliderlabs_com.zone_id}"
  name = "slack.gliderlabs.com"
  type = "CNAME"
  ttl = "300"
  records = ["glider-slackin.herokuapp.com."]
}

resource "aws_route53_record" "www_gliderlabs_com" {
  zone_id = "${data.aws_route53_zone.gliderlabs_com.zone_id}"
  name = "www.gliderlabs.com"
  type = "CNAME"
  ttl = "300"
  records = ["gliderlabs.github.io."]
}
