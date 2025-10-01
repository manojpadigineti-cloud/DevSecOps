#ami
ami_name = "RHEL-DevOps-Manoj" #"RHEL-9-DevOps-Practice"
ami_owner = ["260380093736"] #973714476881
zone_name = "manojpadigineti.cloud"
#subnet_id
public_subnet_id = "subnet-0a745d094a7bd3915"
#security_group
security_group_id = "sg-055ec21053a42f5de"

terraform_instance = {
  terraform_vault = {
    instance_type = "t2.micro"
  }
}
