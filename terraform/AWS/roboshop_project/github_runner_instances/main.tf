module "github_runner" {
  for_each = var.github_runners
  source = "../modules/ec2-spot"
  ami    = data.aws_ami.ami.id
  ec2_subnet = data.aws_subnet.runner_subnet.id
  instance_name = each.key
  instance_type = each.value.instance_type
  security_group = data.aws_security_group.sg.id
}

module "runner_provisioner" {
  source = "../modules/github_rubbner_provisioner"
  password  = data.vault_kv_secret_v2.vault_secret.data["password"]
  private_ip = module.github_runner["runner1"].ec2_instance_output_private_ip
  vault_token = var.vault_token
}