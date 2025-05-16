module "IAM_policy_instance_profile" {
  source = "../modules/iam"
}

module "terraform_vault_ec2" {
  depends_on = [module.IAM_policy_instance_profile]
  for_each = var.terraform_instance
  source = "../modules/ec2-spot"
  ami    = data.aws_ami.ami_ec2.id
  ec2_subnet = data.aws_subnet.public_subnet.id
  instance_name = each.key
  instance_type = each.value.instance_type
  security_group = data.aws_security_group.security_group.id
  instance_profile = module.IAM_policy_instance_profile.Instance_policy_name
}

module "eip" {
  depends_on = [module.terraform_vault_ec2]
  for_each = var.terraform_instance
  source = "../modules/eip"
  instance_id = module.terraform_vault_ec2[each.key].ec2_instance_output_id
}

module "eip_associate" {
  for_each = var.terraform_instance
  source = "../modules/eip_associate"
  allocation_id = module.eip[each.key].eip_id
  instance_id   = module.terraform_vault_ec2[each.key].ec2_instance_output_id
}

module "hashicorp_vault_route_53" {
  depends_on = [module.eip, module.terraform_vault_ec2, module.eip_associate]
  for_each = var.terraform_instance
  source = "../modules/route53_record"
  record_name = "${each.key}-public"
  route53_records = module.eip_associate[each.key].eip_associate_publicip
  zoneid = data.aws_route53_zone.route_53_zone.id
}

module "hashicorp_vault_route_53_private" {
  depends_on = [module.terraform_vault_ec2]
  for_each = var.terraform_instance
  source = "../modules/route53_record"
  record_name = each.key
  route53_records = module.terraform_vault_ec2[each.key].ec2_instance_output_private_ip
  zoneid = data.aws_route53_zone.route_53_zone.id
}

module "terraform_provisioner" {
  depends_on = [module.hashicorp_vault_route_53]
  source = "../modules/terraform_provisioner"
  password  = var.password
  public_ip = module.eip_associate["terraform_vault"].eip_associate_publicip
}