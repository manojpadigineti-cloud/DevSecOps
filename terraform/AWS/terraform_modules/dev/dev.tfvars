ami_image_name = "RHEL-9-DevOps-Practice"
ami_owner = "973714476881"
# bucket_name = "manojtf99"

# microservice = ["frontend", "mongodb", "catalogue", "redis", "user", "cart", "mysql", "shipping", "rabbitmq", "payment", "dispatch"]

#DB_Instances
db_instances = {
  mongodb = {
    instance_type = "t2.micro"
    ec2_subnet = "private_subnet"
  }
  redis = {
    instance_type = "t2.micro"
    ec2_subnet = "private_subnet"
  }
  mysql = {
    instance_type = "t2.micro"
    ec2_subnet = "private_subnet"
  }
  rabbitmq = {
    instance_type = "t2.micro"
    ec2_subnet = "private_subnet"
  }
}

# Instance
backend_instances = {
  ansible = {
    instance_type = "t2.micro"
    ec2_subnet = "public_subnet"
  }
  catalogue = {
    instance_type = "t2.micro"
    ec2_subnet = "private_subnet"
  }
  user = {
    instance_type = "t2.micro"
    ec2_subnet = "private_subnet"
  }
  cart = {
    instance_type = "t2.micro"
    ec2_subnet = "private_subnet"
  }
  shipping = {
    instance_type = "t2.micro"
    ec2_subnet = "private_subnet"
  }
  payment = {
    instance_type = "t2.micro"
    ec2_subnet = "private_subnet"
  }
  dispatch = {
    instance_type = "t2.micro"
    ec2_subnet = "private_subnet"
  }
}

frontend_instances = {
  frontend = {
    instance_type = "t2.micro"
    ec2_subnet = "public_subnet"
  }
  hashicorp-vault = {
    instance_type = "t2.micro"
    ec2_subnet = "public_subnet"
  }
}

ansible_instance = {
  ansible = {
    instance_type = "t2.micro"
    ec2_subnet = "public_subnet"
  }
}


vpc = {
  roboshop_vpc = {
    cidr = "15.0.0.0/16"
  }
}

subnet = {
  public_subnet = {
    subnet_cidr = "15.0.1.0/24"
  }
  private_subnet = {
    subnet_cidr = "15.0.2.0/24"
  }
}

# IGW
igw_name = "roboshop_igw"

#NAT
nat_name = "roboshop-nat"


#security_group_configuration
sg_group_configure = {
  robo-sg = {
    project_name = "roboshop"
  }
}

#Security_group_rules
sg_rules = {
  http = {
    port = 80
    protocol = "TCP"
    type = "ingress"
    cidr = ["0.0.0.0/0"]
  }
  ssh = {
    port = 22
    protocol = "TCP"
    type = "ingress"
    cidr = ["0.0.0.0/0"]
  }
  sonar = {
    port = 9000
    protocol = "TCP"
    type = "ingress"
    cidr = ["0.0.0.0/0"]
  }
  jenkins = {
    port = 8080
    protocol = "TCP"
    type = "ingress"
    cidr = ["0.0.0.0/0"]
  }
  mongodb = {
    port = 27017
    protocol = "TCP"
    type = "ingress"
    cidr = ["0.0.0.0/0"]
  }
  redis = {
    port = 6379
    protocol = "TCP"
    type = "ingress"
    cidr = ["0.0.0.0/0"]
  }
  mysql = {
    port = 3306
    protocol = "TCP"
    type = "ingress"
    cidr = ["0.0.0.0/0"]
  }
  rabbitmq = {
    port = 5672
    protocol = "TCP"
    type = "ingress"
    cidr = ["0.0.0.0/0"]
  }
  egress = {
    port = 0
    protocol = "-1"
    type = "egress"
    cidr = ["0.0.0.0/0"]
  }
}


