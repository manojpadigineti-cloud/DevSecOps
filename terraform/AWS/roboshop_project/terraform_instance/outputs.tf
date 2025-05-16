output "output_after_provision_of_terraform_Vault_instance" {
  value = "Provision hashicor_vault_secrets_module and provide vault_token using -var, Before provisioning roboshop instances add github_token Manually"
}

output "Iam_instance_profile" {
  value = module.IAM_policy_instance_profile.Instance_policy_name
}