1. All required Instances and EKS creation will be done in this directory
2. Create an s3 bucket manually to store the backend state file
3. Create network for project using terraform in local
4. Replace sg, subnet id's on all variable vars files in the project
5. Create terraform-vault instance in local using terraform apply, it will create hashicorp vault. 
6. Login to terraform-vault instance create "hashicorp_vault_secrets" in the terraform-vault instance
7. Create github_token and its value as Hashicorp vault secret before running the github runner instance in terraform-vault instance
8. Login to terraform-vault instance and run terraform for github_runner instance (It will fetch the github_token value from Hashicorp vault) 
9. Add secret value of VAULT_TOKEN in github actions secrets
10. Check the runner is added in github actions and run the terraform apply workflow which will create Roboshop project required instances