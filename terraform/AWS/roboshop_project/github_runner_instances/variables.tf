variable "ami_name" {}
variable "owner_id" {}
variable "private_subnet_id" {}
variable "github_runners" {
  type = map(object({
    instance_type = string
  }))
}
variable "security_group_id" {}
variable "vault_token" {}
variable "mount" {}
variable "secret_name" {}
