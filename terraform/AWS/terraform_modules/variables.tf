variable "ami_owner" {
  type = string
}
variable "ami_image_name" {
  type = string
}
# variable "bucket_name" {
#   type = string
# }

variable "igw_name" {
  type = string
}

variable "nat_name" {
  type = string
}
variable "server_password" {
  default = "DevOps321"
}

variable "sg_group_configure" {
  type = map(object({
    project_name = string
  }))
}

variable "sg_rules" {
  type = map(object({
    port = number
    protocol = string
    type = string
    cidr = list(string)
  }))
}

# variable "microservice" {
#   type = list(string)
# }

variable "db_instances" {
  type = map(object({
    instance_type = string
    ec2_subnet = string
  }))
}


variable "backend_instances" {
  type = map(object({
    instance_type = string
    ec2_subnet = string
  }))
}


variable "frontend_instances" {
  type = map(object({
    instance_type = string
    ec2_subnet = string
  }))
}

variable "ansible_instance" {
  type = map(object({
    instance_type = string
    ec2_subnet = string
  }))
}

variable "vpc" {
  type = map(object({
    cidr = string
  }))
}

variable "subnet" {
  type = map(object({
    subnet_cidr = string
  }))
}