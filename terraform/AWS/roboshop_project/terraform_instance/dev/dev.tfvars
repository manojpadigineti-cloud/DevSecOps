#ami
ami_name = "RHEL-DevOps-Manoj" #"RHEL-9-DevOps-Practice"
ami_owner = ["965985314336"] #973714476881
zone_name = "manojpadigineti.cloud"
#subnet_id
public_subnet_id = "subnet-03601ea5063941677"
private_subnet_id = "subnet-07846c85a96c61cfc"
#security_group
security_group_id = "sg-0a603c354d601f962"

terraform_instance = {
  terraform_vault = {
    instance_type = "t2.micro"
  }
}
