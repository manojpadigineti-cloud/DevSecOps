data "aws_ami" "ami_ec2" {
  most_recent = true
  name_regex  = var.ami_name
  owners = var.ami_owner
}

data "aws_security_group" "security_group" {
  id = var.security_group_id
}

data "aws_subnet" "private_subnet" {
  id = var.private_subnet_id
}

data "aws_subnet" "public_subnet" {
  id = var.public_subnet_id
}

data "aws_route53_zone" "route_53_zone" {
  name         = var.zone_name
  private_zone = false
}

data "vault_kv_secret_v2" "credentials" {
  mount = var.mount_path
  name  = var.secret_name
}