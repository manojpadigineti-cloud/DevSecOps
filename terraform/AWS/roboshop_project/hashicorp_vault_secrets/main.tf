module "vault_token" {
  source = "../modules/hashicorp_vault"
  secrets = var.secrets
  vault_path = var.vault_path
  secrets_name = var.secrets_name
}

