#=========================#
#       INSTANCES         #
#=========================#

module "roboshop_db_instances" {
  # depends_on = [module.roboshop_frontend_instances]
  for_each = var.roboshop_db_instances
  source = "../modules/ec2"
  ami    = data.aws_ami.ami_ec2.id
  ec2_subnet = data.aws_subnet.public_subnet.id
  instance_name = each.key
  instance_type = each.value.instance_type
  security_group = data.aws_security_group.security_group.id
}
#
# module "roboshop_backend_instances" {
#   depends_on = [module.roboshop_db_instances]
#   for_each = var.roboshop_backend_instances
#   source = "../modules/ec2"
#   ami    = data.aws_ami.ami_ec2.id
#   ec2_subnet = data.aws_subnet.private_subnet.id
#   instance_name = each.key
#   instance_type = each.value.instance_type
#   security_group = data.aws_security_group.security_group.id
# }
#
# module "roboshop_frontend_instances" {
#   for_each = var.roboshop_frontend_instances
#   source = "../modules/ec2"
#   ami    = data.aws_ami.ami_ec2.id
#   ec2_subnet = data.aws_subnet.public_subnet.id
#   instance_name = each.key
#   instance_type = each.value.instance_type
#   security_group = data.aws_security_group.security_group.id
# }

#===================#
#       EIP         #
#===================#
module "roboshop_eip-db" {
  depends_on = [module.roboshop_db_instances]
  for_each = var.roboshop_db_instances
  source = "../modules/eip"
  instance_id = module.roboshop_db_instances[each.key].ec2_instance_output_id
  eip_name = each.key
}
# module "roboshop_eip" {
#   depends_on = [module.roboshop_backend_instances]
#   for_each = var.roboshop_frontend_instances
#   source = "../modules/eip"
#   instance_id = module.roboshop_frontend_instances[each.key].ec2_instance_output_id
#   eip_name = each.key
# }
#
# module "eip_associate" {
#   depends_on = [module.roboshop_eip]
#   for_each = var.roboshop_frontend_instances
#   source = "../modules/eip_associate"
#   allocation_id = module.roboshop_eip[each.key].eip_id
#   instance_id   = module.roboshop_frontend_instances[each.key].ec2_instance_output_id
# }

#========================#
#       Route_53         #
#========================#

module "db_route53_records" {
  depends_on = [module.roboshop_eip-db]
  for_each = var.roboshop_db_instances
  source = "../modules/route53_record"
  record_name = each.key
  route53_records = module.roboshop_eip-db[each.key].eip_publicip
  zoneid = data.aws_route53_zone.route_53_zone.id
}

# module "backend_route53_records" {
#   depends_on = [module.db_route53_records]
#   for_each = var.roboshop_backend_instances
#   source = "../modules/route53_record"
#   record_name = each.key
#   route53_records = module.roboshop_backend_instances[each.key].ec2_instance_output_private_ip
#   zoneid = data.aws_route53_zone.route_53_zone.id
# }
#
# module "frontend_route53_records" {
#   depends_on = [module.roboshop_frontend_instances, module.backend_route53_records, module.eip_associate]
#   for_each = var.roboshop_frontend_instances
#   source = "../modules/route53_record"
#   record_name = each.key
#   route53_records = module.eip_associate[each.key].eip_associate_publicip
#   zoneid = data.aws_route53_zone.route_53_zone.id
# }

#===================================#
#       Ansible Provisioner         #
#===================================#

module "db_provisioner" {
  # depends_on = [module.frontend_route53_records]
  for_each = var.roboshop_db_instances
  source = "../modules/ansible_provisioner"
  password  = data.vault_kv_secret_v2.credentials.data["password"]
  public_ip = module.roboshop_eip-db[each.key].eip_publicip
  server_name = each.key
  username = data.vault_kv_secret_v2.credentials.data["username"]
  vault_token = var.vault_token
}

# module "backend_provisioner" {
#   depends_on = [module.db_provisioner]
#   for_each = var.roboshop_backend_instances
#   source = "../modules/ansible_provisioner"
#   password  = data.vault_kv_secret_v2.credentials.data["password"]
#   public_ip = module.roboshop_backend_instances[each.key].ec2_instance_output_private_ip
#   server_name = each.key
#   username = data.vault_kv_secret_v2.credentials.data["username"]
#   vault_token = var.vault_token
# }
#
# module "frontend_provisioner" {
#   depends_on = [module.backend_provisioner]
#   for_each = var.roboshop_frontend_instances
#   source = "../modules/ansible_provisioner"
#   password  = data.vault_kv_secret_v2.credentials.data["password"]
#   public_ip = module.roboshop_frontend_instances[each.key].ec2_instance_output_private_ip
#   server_name = each.key
#   username = data.vault_kv_secret_v2.credentials.data["username"]
#   vault_token = var.vault_token
# }

#=================================#
#       EKS Kubernete Cluster     #
#=================================#

module "EKS_Subnets" {
  source = "../modules/eks_subnet"
  for_each = var.eks_subnets
  cidr        = each.value.cidr
  subnet_name = each.key
  subnet_zone = each.value.subnet_zone
  vpc_id      = var.vpc_id
  routetable_id = var.routetable_id
  subnet_associate = var.eks_subnets
}



module "EKS_Cluster" {
  source = "../modules/eks"
  for_each = var.EKS
  eks_cluster_name     = each.key
  subnet_ids           = [for subnets in each.value.subnets: module.EKS_Subnets[subnets].eks_subnet_id]
  nodegroup_name = "${each.key}-nodegroup"
  addon   = var.addon
  roles   = var.policy_roles
  policy_roles_2 = var.attach_policy_role
  ## If any key is accepting list we can use (For Looping) this method, if a key is expecting only one value we can use toset method as above we applied for Ppolicy-arn
  # for subnets in each.value.subnets --> Loops the value in variable 1st- eks-subnet-1    2nd - eks-subnet-2
  # module.EKS_Subnets[subnets].eks_subnet_id  ---> filters the required value from EKS_Subnets module and get its id from output
}