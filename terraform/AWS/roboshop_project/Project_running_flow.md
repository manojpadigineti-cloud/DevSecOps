1. Create network
2. Replace sg, subnet id's on all variable vars files in the project
3. create terraform instance, it will create hashicorp vault.
4. Login to terraform-vault instance create hashicorp vault secrets in the terraform-vault instance
5. create github_token and its value as secret before running the github runner instance in terraform-vault instance
6. Login to terraform-vault instance and run terraform for github_runner instance  
7. check the runner is added in github actions and run the terraform apply workflow which will create roboshop instances