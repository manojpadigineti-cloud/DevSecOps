ami_name = "RHEL-DevOps-Manoj"
owner_id = ["260380093736"]
private_subnet_id = "subnet-024909327b7a6665b"
security_group_id = "sg-0178f68dfd253f44d"
instance_profile_name = "ec2-instance-profile"
mount = "kv"
secret_name = "credentials"
# Instances
github_runners = {
  runner1 = {
    instance_type = "t2.micro"
  }
}