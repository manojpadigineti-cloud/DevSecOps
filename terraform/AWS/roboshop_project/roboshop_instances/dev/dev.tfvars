ami_name = "RHEL-DevOps-Manoj" #"RHEL-9-DevOps-Practice"
ami_owner = ["965985314336"] #973714476881
security_group_id = "sg-01ac7168f056035b1"
public_subnet_id = "subnet-0942390dfdc9fbe43"
private_subnet_id = "subnet-013e0293b77b828d9"
zone_name = "manojpadigineti.cloud"
mount_path = "kv"
secret_name = "credentials"



roboshop_db_instances = {
  mongodb = {
    instance_type = "t2.micro"
  }
  redis = {
    instance_type = "t2.micro"
  }
  mysql = {
    instance_type = "t2.micro"
  }
  rabbitmq = {
    instance_type = "t2.micro"
  }
}

roboshop_backend_instances = {
  catalogue = {
    instance_type = "t2.micro"
  }
  user = {
    instance_type = "t2.micro"
  }
  cart = {
    instance_type = "t2.micro"
  }
  shipping = {
    instance_type = "t2.micro"
  }
  payment = {
    instance_type = "t2.micro"
  }
  dispatch = {
    instance_type = "t2.micro"
  }
}

roboshop_frontend_instances = {
  frontend = {
    instance_type = "t2.micro"
  }
}