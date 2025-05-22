terraform {
  backend "s3" {
    bucket         = "terraformbackend1977"
    key            = "backend/dev/hashicorp_vault_secrets/terraform.tfstate"
    region         = "us-east-1"
  }
}