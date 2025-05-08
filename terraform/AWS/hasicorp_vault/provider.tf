terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "4.5.0"
    }
  }
}
provider "vault" {
  address = "http://52.6.241.250:8200"
  token = var.vault_token
  skip_tls_verify = true
}