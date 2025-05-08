#-----------------------------#
#  Network [ VPC , SUBNET ]   #
#-----------------------------#

module "vpc" {
  for_each = var.vpc
  source = "./modules/vpc"
  cidr = each.value.cidr
  vpc_name = each.key
}

module "subnet" {
  for_each = var.subnet
  source = "./modules/subnet"
  subnet_name = each.key
  subnet_cidr = each.value.subnet_cidr
  vpc_id = module.vpc["roboshop_vpc"].vpc_id
}

#---------#
#  IGW    #
#---------#

module "igw" {
  depends_on = [module.vpc]
  source = "./modules/igw"
  vpc_id_igw = module.vpc["roboshop_vpc"].vpc_id
  igw_name = var.igw_name
}

#---------#
#   NAT   #
#---------#

module "nat" {
  depends_on = [module.subnet]
  source = "./modules/nat_gateway"
  nat_subnet = module.subnet["public_subnet"].subnet_id
  nat_name = var.nat_name
}

#---------------#
#  Route_table  #
#---------------#

module "route_table" {
  depends_on = [module.vpc, module.subnet]
  source = "./modules/route_table"
  igw_id = module.igw.igw_id
  vpc_id = module.vpc["roboshop_vpc"].vpc_id
  public_subnet = module.subnet["public_subnet"].subnet_id
  nat_gateway_id = module.nat.roboshop_nat
  private_subnet = module.subnet["private_subnet"].subnet_id
}

#------------------------------------------#
# Security_group & Security_group_rule's   #
#------------------------------------------#

module "security_group" {
  for_each = var.sg_group_configure
  source = "./modules/security_group"
  project_name = each.value.project_name
  security_group_name = each.key
  vpc_id = module.vpc["roboshop_vpc"].vpc_id
}

module "security_group_rule" {
  depends_on = [module.security_group]
  for_each = var.sg_rules
  source = "./modules/security_group_rules"
  port   = each.value.port
  protocol = each.value.protocol
  sg_id = module.security_group["robo-sg"].sg_id
  type = each.value.type
  cidr  = each.value.cidr
}

#----------------#
#    S3_Bucket   #
#----------------#

# module "s3" {
#   source = "./modules/s3"
#   bucket_name = var.bucket_name
# }


#---------------#
#   Instances   #
#---------------#

module "db_instances" {
  depends_on = [module.vpc, module.subnet, module.nat, module.security_group]
  for_each = var.db_instances
  source = "./modules/ec2"
  ami_image_name = var.ami_image_name
  ami_owner = var.ami_owner
  instance_type = each.value.instance_type
  microservice_name = each.key
  ec2_subnet = module.subnet[each.value.ec2_subnet].subnet_id
  security_group = module.security_group["robo-sg"].sg_id
}

module "backend_instances" {
  depends_on = [module.vpc, module.subnet, module.nat, module.security_group, module.db_instances, module.frontend_instances]
  for_each = var.backend_instances
  source = "./modules/ec2"
  ami_image_name = var.ami_image_name
  ami_owner = var.ami_owner
  instance_type = each.value.instance_type
  microservice_name = each.key
  ec2_subnet = module.subnet[each.value.ec2_subnet].subnet_id
  security_group = module.security_group["robo-sg"].sg_id
}


module "frontend_instances" {
  depends_on = [module.vpc, module.subnet, module.nat, module.security_group, module.db_instances]
  for_each = var.frontend_instances
  source = "./modules/ec2"
  ami_image_name = var.ami_image_name
  ami_owner = var.ami_owner
  instance_type = each.value.instance_type
  microservice_name = each.key
  ec2_subnet = module.subnet[each.value.ec2_subnet].subnet_id
  security_group = module.security_group["robo-sg"].sg_id
}

# module "ansible_instance" {
#   depends_on = [module.vpc, module.subnet, module.nat, module.security_group]
#   for_each = var.ansible_instance
#   source = "./modules/ec2"
#   ami_image_name = var.ami_image_name
#   ami_owner = var.ami_owner
#   instance_type = each.value.instance_type
#   microservice_name = each.key
#   ec2_subnet = module.subnet[each.value.ec2_subnet].subnet_id
#   security_group = module.security_group["robo-sg"].sg_id
# }

#----------------#
#      EIP       #
#----------------#

module "frontend_eip" {
  depends_on = [module.frontend_instances]
  for_each = { for k, v in var.frontend_instances : k => v if v.ec2_subnet == "public_subnet" }
  source = "./modules/eip"
  instance = each.key
  eip_instances = module.frontend_instances[each.key].ec2_id
}

module "backend_eip" {
  depends_on = [module.backend_instances]
  for_each = { for k, v in var.backend_instances : k => v if v.ec2_subnet == "public_subnet" }
  source = "./modules/eip"
  instance = each.key
  eip_instances = module.backend_instances[each.key].ec2_id
}

module "db_eip" {
  depends_on = [module.db_instances]
  for_each = { for k, v in var.db_instances : k => v if v.ec2_subnet == "public_subnet" }
  source = "./modules/eip"
  instance = each.key
  eip_instances = module.db_instances[each.key].ec2_id
}

# module "ansible_eip" {
#   depends_on = [module.ansible_instance]
#   for_each = var.ansible_instance
#   source = "./modules/eip"
#   instance = each.key
#   eip_instances = module.ansible_instance[each.key].ec2_id
# }


#--------------------#
#    EIP Associate   #
#--------------------#

module "frontend_eip_associate" {
  depends_on = [module.frontend_eip]
  for_each = { for k, v in var.frontend_instances : k => v if v.ec2_subnet == "public_subnet" }
  source = "./modules/eip_associate"
  eip_allocate_id = module.frontend_eip[each.key].eip_id
  instance_id = module.frontend_instances[each.key].ec2_id
}

module "backend_eip_associate" {
  depends_on = [module.backend_eip]
  for_each = { for k, v in var.backend_instances : k => v if v.ec2_subnet == "public_subnet" }
  source = "./modules/eip_associate"
  eip_allocate_id = module.backend_eip[each.key].eip_id
  instance_id = module.backend_instances[each.key].ec2_id
}

module "db_eip_associate" {
  depends_on = [module.db_eip]
  for_each = { for k, v in var.db_instances : k => v if v.ec2_subnet == "public_subnet" }
  source = "./modules/eip_associate"
  eip_allocate_id = module.db_eip[each.key].eip_id
  instance_id = module.db_instances[each.key].ec2_id
}

# module "ansible_eip_associate" {
#   depends_on = [module.ansible_eip]
#   for_each = { for k, v in var.ansible_instance : k => v if v.ec2_subnet == "public_subnet" }
#   source = "./modules/eip_associate"
#   eip_allocate_id = module.ansible_eip[each.key].eip_id
#   instance_id = module.ansible_instance[each.key].ec2_id
# }

#-------------------#
#  Route_53_Record  #
#-------------------#

module "frontend_route53_record" {
  depends_on = [module.frontend_instances, module.frontend_eip, module.frontend_eip_associate, module.Frontend_sleep_provisioner, module.backend_route53_record]
  for_each = var.frontend_instances
  source = "./modules/route53"
  hosted_zone_name = "manojpadigineti.cloud"
  instance  = each.key
  record_ip = module.frontend_instances[each.key].public_ip
}

module "backend_route53_record" {
  depends_on = [module.backend_instances, module.backend_eip, module.backend_eip_associate, module.db_route53_record]
  for_each = var.backend_instances
  source = "./modules/route53"
  hosted_zone_name = "manojpadigineti.cloud"
  instance  = each.key
  record_ip = each.key == "frontend" ? module.backend_instances[each.key].public_ip : module.backend_instances[each.key].private_ip
}

module "db_route53_record" {
  depends_on = [module.db_instances, module.db_eip, module.db_eip_associate]
  for_each = var.db_instances
  source = "./modules/route53"
  hosted_zone_name = "manojpadigineti.cloud"
  instance  = each.key
  record_ip = module.db_instances[each.key].private_ip
}

#-----------------------#
#  Ansible_Provisioner  #
#-----------------------#

#Server Password required in runtime
module "db_Ansible_provisioner" {
  depends_on = [module.db_instances, module.db_eip_associate, module.frontend_route53_record, module.security_group_rule]
  for_each = var.db_instances
  source = "./modules/ansible_provisioner"
  password = var.server_password
  server_ip = module.db_instances[each.key].private_ip
}

module "backend_Ansible_provisioner" {
  depends_on = [module.backend_instances, module.backend_eip_associate, module.frontend_route53_record, module.security_group_rule, module.db_Ansible_provisioner]
  for_each = var.backend_instances
  source = "./modules/ansible_provisioner"
  password = var.server_password
  server_ip = module.backend_instances[each.key].private_ip
}

module "frontend_Ansible_provisioner" {
  depends_on = [module.frontend_instances, module.frontend_eip_associate, module.frontend_route53_record, module.security_group_rule, module.backend_Ansible_provisioner]
  for_each = var.frontend_instances
  source = "./modules/ansible_provisioner"
  password = var.server_password
  server_ip = module.frontend_instances[each.key].public_ip
}

#----------------------#
#   Sleep_Provisioner  #
#----------------------#

module "Frontend_sleep_provisioner" {
  depends_on = [module.frontend_eip, module.frontend_eip_associate, module.frontend_instances]
  source = "./modules/provisioner"
}

#-------------------------#
#   Playbook_Provisioner  #
#-------------------------#

module "dbs_playbook_provisioner" {
  depends_on = [module.db_route53_record, module.frontend_route53_record, module.frontend_Ansible_provisioner]
  for_each = var.db_instances
  source = "./modules/ansible_execute"
  password  = var.server_password
  server_ip = module.db_instances[each.key].private_ip
  instances = each.key
}

module "backend_playbook_provisioner" {
  for_each = { for k, v in var.backend_instances : k => v if k != "ansible" }
  depends_on = [module.dbs_playbook_provisioner, module.db_route53_record, module.backend_Ansible_provisioner]
  source = "./modules/ansible_execute"
  password  = var.server_password
  server_ip = module.backend_instances[each.key].private_ip
  instances = each.key
}

#{ for k, v in var.db_instances : k => v if k != "ansible" && k != "frontend" } - Example for two conditions
module "frontend_playbook_provisioner" {
  for_each = { for k, v in var.frontend_instances : k => v if k != "hashicorp-vault " }
  depends_on = [module.backend_playbook_provisioner, module.db_route53_record, module.frontend_Ansible_provisioner, module.backend_playbook_provisioner]
  source = "./modules/ansible_execute"
  password  = var.server_password
  server_ip = module.frontend_instances[each.key].private_ip
  instances = each.key
}