resource "aws_security_group_rule" "sg-rules" {
  from_port         = var.port
  protocol          = var.protocol
  security_group_id = var.sg_id
  to_port           = var.port
  type              = var.type
  cidr_blocks = var.cidr
}

