1. All required Instances and EKS creation will be done in this directory
2. Create an s3 bucket manually to store the backend state file
2. Create network for project using terraform in local
2. Replace sg, subnet id's on all variable vars files in the project
3. Create terraform-vault instance in local using terraform apply, it will create hashicorp vault. 
4. Login to terraform-vault instance create "hashicorp_vault_secrets" in the terraform-vault instance
5. Create github_token and its value as Hashicorp vault secret before running the github runner instance in terraform-vault instance
6. Login to terraform-vault instance and run terraform for github_runner instance (It will fetch the github_token value from Hashicorp vault) 
7. Add secret value of VAULT_TOKEN in github actions secrets
8. Check the runner is added in github actions and run the terraform apply workflow which will create Roboshop project required instances