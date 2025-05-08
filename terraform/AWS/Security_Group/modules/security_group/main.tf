resource "aws_security_group" "sg" {
  name = var.sg_name
}

resource "aws_security_group_rule" "sg_rules" {
  from_port         = var.port
  protocol          = var.protocol
  security_group_id = aws_security_group.sg.id
  to_port           = var.port
  type              = var.type
  cidr_blocks = var.cidr
}