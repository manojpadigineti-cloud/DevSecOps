resource "aws_route53_record" "route53" {
  zone_id = data.aws_route53_zone.route53.id
  name    = "${var.instance}.manojpadigineti.cloud"
  type    = "A"
  ttl     = 300
  records = [var.record_ip]
}