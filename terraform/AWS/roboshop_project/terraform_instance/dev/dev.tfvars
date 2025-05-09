#ami
ami_name = "RHEL-9-DevOps-Practice"
ami_owner = ["973714476881"]
zone_name = "manojpadigineti.cloud"
#subnet_id
public_subnet_id = "subnet-0bfaa32e4d8eb0535"
private_subnet_id = "subnet-07a5d9965563d01df"
#security_group
security_group_id = "sg-0cfb499f276183788"

terraform_instance = {
  terraform_vault = {
    instance_type = "t2.micro"
  }
}
