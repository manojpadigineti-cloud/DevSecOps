#ami
ami_name = "RHEL-DevOps-Manoj" #"RHEL-9-DevOps-Practice"
ami_owner = ["965985314336"] #973714476881
zone_name = "manojpadigineti.cloud"
#subnet_id
public_subnet_id = "subnet-0350cc3807c16013a"
private_subnet_id = "subnet-0c5c4953342e5019a"
#security_group
security_group_id = "sg-0860b896fcbb71f9d"

terraform_instance = {
  terraform_vault = {
    instance_type = "t2.micro"
  }
}
