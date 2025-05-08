resource "aws_route53_record" "route53_records" {
  zone_id = var.zoneid
  name    = var.record_name
  type    = "A"
  ttl     = 300
  records = [var.route53_records]
}


