# for <key_var>, <value_var> in <map> : <key_var> => <value_var>.<output>

output "security_group_id" {
  value = {
    for sg, value in module.security_group : sg => value.sg_id    #(sg_id is coming from child module output)
  }
}

output "subnets_id" {
  value = {
    for subnet, all_subnet_id in module.subnets : subnet => all_subnet_id.subnet_id
  }
}

### Count example
#----------------#
# output "all_sg_ids" {
#   value = [for i in module.sg : i.sg_id]
# }