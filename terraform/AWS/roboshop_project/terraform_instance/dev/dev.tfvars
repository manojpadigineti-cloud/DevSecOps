#ami
ami_name = "RHEL-DevOps-Manoj" #"RHEL-9-DevOps-Practice"
ami_owner = ["965985314336"] #973714476881
zone_name = "manojpadigineti.cloud"
#subnet_id
public_subnet_id = "subnet-0afd4c68c94d97fa4"
private_subnet_id = "subnet-0f04dbec3265a3186"
#security_group
security_group_id = "sg-0acefb77675c98924"

terraform_instance = {
  terraform_vault = {
    instance_type = "t2.micro"
  }
}
