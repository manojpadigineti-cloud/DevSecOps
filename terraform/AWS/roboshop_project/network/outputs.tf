output "security_group_id" {
  value = module.security_group.sg_id
}

output "subnet_id" {
  value = module.subnets.subnet_id
}
