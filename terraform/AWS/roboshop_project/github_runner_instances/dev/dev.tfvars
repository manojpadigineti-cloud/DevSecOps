ami_name = "RHEL-DevOps-Manoj"
owner_id = ["965985314336"]
private_subnet_id = "subnet-013e0293b77b828d9"
security_group_id = "sg-01ac7168f056035b1"
instance_profile_name = "ec2-instance-profile"
mount = "kv"
secret_name = "credentials"
# Instances
github_runners = {
  runner1 = {
    instance_type = "t2.micro"
  }
}