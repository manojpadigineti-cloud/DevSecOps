resource "aws_security_group" "sg" {
  name        = var.security_group_name
  description = "Allow or Deny ports for ${var.project_name}"
  vpc_id      = var.vpc_id
  tags = {
    Name = var.security_group_name
  }
}
