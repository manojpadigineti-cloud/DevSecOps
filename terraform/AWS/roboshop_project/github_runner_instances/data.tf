data "aws_ami" "ami" {
  most_recent      = true
  name_regex       = var.ami_name
  owners           = [var.owner_id]
}

data "aws_subnet" "runner_subnet" {
  id = var.private_subnet_id
}

data "aws_security_group" "sg" {
  id = var.security_group_id
}

data "vault_kv_secret_v2" "vault_secret" {
  mount = var.mount
  name  = var.secret_name
}