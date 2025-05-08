
data "aws_route53_zone" "route53" {
  name         = var.hosted_zone_name
  private_zone = false
}