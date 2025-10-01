ami_name = "RHEL-DevOps-Manoj"
owner_id = ["260380093736"]
private_subnet_id = "subnet-0c6bb7036857981d6"
security_group_id = "sg-055ec21053a42f5de"
instance_profile_name = "ec2-instance-profile"
mount = "kv"
secret_name = "credentials"
# Instances
github_runners = {
  runner1 = {
    instance_type = "t2.micro"
  }
}