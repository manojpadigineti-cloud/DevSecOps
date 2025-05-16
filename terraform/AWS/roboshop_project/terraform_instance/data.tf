data "aws_ami" "ami_ec2" {
  most_recent = true
  name_regex  = var.ami_name
  owners = var.ami_owner
}

data "aws_subnet" "public_subnet" {
  id = var.public_subnet_id
}

data "aws_security_group" "security_group" {
  id = var.security_group_id
}

data "aws_route53_zone" "route_53_zone" {
  name         = var.zone_name
  private_zone = false
}