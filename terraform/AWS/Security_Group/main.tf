module "sg-rules" {
  for_each = var.sg_rules
  source = "./modules/security_group"
  cidr   = each.value.cidr
  port   = each.value.port
  protocol = each.value.protocol
  sg_name = each.value.sgname
  type = each.value.type
}

