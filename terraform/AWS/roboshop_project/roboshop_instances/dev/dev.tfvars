ami_name = "RHEL-9-DevOps-Practice"
ami_owner = ["973714476881"]
security_group_id = "sg-0a6a20a132abde36f"
public_subnet_id = "subnet-07ab41a9a6bd6b40b"
private_subnet_id = "subnet-067bcd5f95415d17e"
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