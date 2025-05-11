module "terraform_vault_ec2" {
  for_each = var.terraform_instance
  source = "../modules/ec2-spot"
  ami    = data.aws_ami.ami_ec2.id
  ec2_subnet = data.aws_subnet.public_subnet.id
  instance_name = each.key
  instance_type = each.value.instance_type
  security_group = data.aws_security_group.security_group.id
}

module "eip" {
  depends_on = [module.terraform_vault_ec2]
  for_each = var.terraform_instance
  source = "../modules/eip"
  instance_id = module.terraform_vault_ec2[each.key].ec2_instance_output_id
}

module "hashicorp_vault_route_53" {
  depends_on = [module.eip, module.terraform_vault_ec2]
  for_each = var.terraform_instance
  source = "../modules/route53_record"
  record_name = "${each.key}-public"
  route53_records = module.terraform_vault_ec2[each.key].ec2_instance_output_public_ip
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
  public_ip = module.terraform_vault_ec2["terraform_vault"].ec2_instance_output_public_ip
  vault_token = var.vault_token
}

