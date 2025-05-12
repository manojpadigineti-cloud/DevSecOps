#ami
ami_name = "RHEL-DevOps-Manoj" #"RHEL-9-DevOps-Practice"
ami_owner = ["965985314336"] #973714476881
zone_name = "manojpadigineti.cloud"
#subnet_id
public_subnet_id = "subnet-0b876f8ff2b87b3aa"
private_subnet_id = "subnet-0427658e80f3657f8"
#security_group
security_group_id = "sg-059e06bcdc32374ea"

terraform_instance = {
  terraform_vault = {
    instance_type = "t2.micro"
  }
}
