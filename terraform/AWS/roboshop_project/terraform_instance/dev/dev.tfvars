#ami
ami_name = "RHEL-DevOps-Manoj" #"RHEL-9-DevOps-Practice"
ami_owner = ["965985314336"] #973714476881
zone_name = "manojpadigineti.cloud"
#subnet_id
public_subnet_id = "subnet-0942390dfdc9fbe43"
#security_group
security_group_id = "sg-01ac7168f056035b1"

terraform_instance = {
  terraform_vault = {
    instance_type = "t2.micro"
  }
}
