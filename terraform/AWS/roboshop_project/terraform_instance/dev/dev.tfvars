#ami
ami_name = "RHEL-9-DevOps-Practice"
ami_owner = ["973714476881"]
zone_name = "manojpadigineti.cloud"
#subnet_id
public_subnet_id = "subnet-07ab41a9a6bd6b40b"
private_subnet_id = "subnet-067bcd5f95415d17e"
#security_group
security_group_id = "sg-0a6a20a132abde36f"

terraform_instance = {
  terraform_vault = {
    instance_type = "t2.micro"
  }
}
