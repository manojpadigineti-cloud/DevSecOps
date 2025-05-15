resource "vault_mount" "kv2" {
  path        = var.vault_path
  type        = "kv"
  options     = { version = "2" }
}

resource "vault_kv_secret_v2" "example" {
  mount                      = vault_mount.kv2.path
  name                       = var.secrets_name
  data_json                  = jsonencode( var.secrets )
}

