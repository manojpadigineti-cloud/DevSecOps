variable "eks_cluster_name" {}
variable "subnet_ids" {}
# variable "iam_roles" {
#   type = map(object({
#     role_to_attach = string
#   }))
# }
variable "nodegroup_name" {}
variable "addon" {}
variable "policy_roles" {
  type = map(object({
    policy_arn = list(string)
  }))
}
