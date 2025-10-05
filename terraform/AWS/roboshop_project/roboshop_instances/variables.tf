variable "ami_name" {}
variable "ami_owner" {}
variable "security_group_id" {}
variable "private_subnet_id" {}
variable "public_subnet_id" {}
variable "zone_name" {}
variable "mount_path" {}
variable "secret_name" {}
variable "vault_token" {}


variable "roboshop_db_instances" {
  type = map(object({
    instance_type = string
  }))
}

variable "roboshop_backend_instances" {
  type = map(object({
    instance_type = string
  }))
}

variable "roboshop_frontend_instances" {
  type = map(object({
    instance_type = string
  }))
}

variable "vpc_id" {}

variable "eks_subnets" {
  type = map(object({
    cidr = string
    subnet_zone = string
  }))
}

variable "EKS" {
  type = map(object({
    subnets = list(string)
  }))
}
variable "addon" {}

variable "policy_roles" {
  type = map(object({
     name = string
  }))
}

variable "attach_policy_role" {
  type = list(string)
}

