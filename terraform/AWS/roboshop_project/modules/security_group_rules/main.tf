resource "aws_security_group_rule" "security_group_rule" {
  description = "Security_group rule for ${var.rulename}"
  type              = var.type
  from_port         = var.port
  to_port           = var.port
  protocol          = var.protocol
  cidr_blocks       = var.cidr
  security_group_id = var.sg_id
}