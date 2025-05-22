terraform {
  backend "s3" {
    bucket         = "terraformbackend1977"
    key            = "backend/dev/roboshop_instances/terraform.tfstate"
    region         = "us-east-1"
  }
}