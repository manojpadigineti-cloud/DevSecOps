#ami
ami_name = "RHEL-DevOps-Manoj" #"RHEL-9-DevOps-Practice"
ami_owner = ["260380093736"] #973714476881
zone_name = "manojpadigineti.cloud"
#subnet_id
public_subnet_id = "subnet-099d2a13753d045e9"
#security_group
security_group_id = "sg-0178f68dfd253f44d"

terraform_instance = {
  terraform_vault = {
    instance_type = "t2.micro"
  }
}
