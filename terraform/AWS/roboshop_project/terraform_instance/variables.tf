#data_sources
variable "ami_name" {}
variable "ami_owner" {}
variable "zone_name" {}
variable "password" {
  default = "DevOps321"
}
variable "public_subnet_id" {
  type = string
}
variable "security_group_id" {}
variable "private_subnet_id" {
  type = string
}

variable "terraform_instance" {
  type = map(object({
    instance_type = string
  }))
}
variable "vault_token" {}