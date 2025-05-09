# for <key_var>, <value_var> in <map> : <key_var> => <value_var>.<output>

output "security_group_id" {
  value = {
    for sg, value in module.security_group : sg => value.sg_id
  }
}

output "subnets_id" {
  value = {
    for subnet, all_subnet_id in module.subnets : subnet => all_subnet_id.subnet_id
  }
}
