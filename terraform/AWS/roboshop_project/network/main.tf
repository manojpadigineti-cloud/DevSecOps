#=============#
#     VPC     #
#=============#
module "vpc" {
  for_each = var.vpc
  source = "../modules/vpc"
  cidr = each.value.cidr
  vpc  = each.key
}

#================#
#     Subnet     #
#================#

module "subnets" {
  depends_on = [module.vpc]
  for_each = var.subnets
  source = "../modules/subnets"
  cidr        = each.value.cidr
  subnet_name = each.key
  vpc_id      = module.vpc["roboshop_vpc"].vpc_id
}

#=============#
#     IGW     #
#=============#

module "igw" {
  depends_on = [module.vpc]
  for_each = var.igw
  source = "../modules/igw"
  igw_name = each.value.name
  vpc_id   = module.vpc["roboshop_vpc"].vpc_id
}

#=======================#
#     Route Table       #
#=======================#

module "route_table" {
  depends_on = [module.igw, module.nat]
  source = "../modules/route_table"
  igw_id = module.igw["igw-rb"].igw_id
  nat_gateway_id = module.nat["roboshop-nat"].nat_gateway_id
  vpc_id = module.vpc["roboshop_vpc"].vpc_id
}

#============================#
#     Route_association      #
#============================#

module "route_table_association" {
  depends_on = [module.route_table]
  source = "../modules/route_table_association"
  private_subnet      = module.subnets["private-subnet"].subnet_id
  public_subnet       = module.subnets["public-subnet"].subnet_id
  route_table_id_IGW  = module.route_table.igw_route_table_id
  route_table_id__NAT = module.route_table.NAT_route_table_id
}

#======================#
#     NAT_Gateway      #
#======================#

module "nat" {
  depends_on = [module.subnets]
  for_each = var.nat_gateway
  source = "../modules/nat"
  nat_eip_name   = each.value.nat_eip_name
  nat_name      =  each.key
  public_subnet_nat = module.subnets["public-subnet"].subnet_id #nat should be in public subnet only
}

#=========================#
#     Security_group      #
#=========================#

module "security_group" {
  depends_on = [module.vpc]
  for_each = var.security_group
  source = "../modules/security_group"
  sg_name = each.value.sg_name
  vpc_id = module.vpc["roboshop_vpc"].vpc_id
}

#==============================#
#     Security_group_rule      #
#==============================#

module "security_group_rule" {
  depends_on = [module.security_group]
  for_each = var.security_group_rules
  source = "../modules/security_group_rules"
  cidr     = each.value.cidr
  port     = each.value.port
  protocol = each.value.protocol
  sg_id    = module.security_group["security_group-roboshop"].sg_id
  rulename = each.key
  type     = each.value.type
}
