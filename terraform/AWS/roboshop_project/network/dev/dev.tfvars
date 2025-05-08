vpc = {
  roboshop_vpc = {
    cidr = "14.0.0.0/16"
  }
}

# Subnets
subnets = {
  public-subnet = {
    cidr = "14.0.1.0/24"
  }
  private-subnet = {
    cidr = "14.0.2.0/24"
  }
}

igw = {
  igw-rb = {
    name = "roboshop_igw"
  }
}

# Public Route Table
public_route_table_name  = "roboshop_public_rt"

#public_route
public_route_to_igw_cidr = "0.0.0.0/0"

#Nat_gateway
nat_gateway = {
  roboshop-nat = {
    nat_eip_name = "roboshop_nat-eip"
  }
}

#security_group
security_group = {
  security_group-roboshop = {
    sg_name = "security_group-roboshop"
  }
}

#security_group_rules
security_group_rules = {
  ssh = {
    cidr = ["0.0.0.0/0"]
    port = 22
    protocol = "TCP"
    type = "ingress"
  }
  http = {
    cidr = ["0.0.0.0/0"]
    port = 80
    protocol = "TCP"
    type = "ingress"
  }
  icmp = {
    cidr = ["0.0.0.0/0"]
    port = -1
    protocol = "icmp"
    type = "ingress"
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
  hashicorp_vault = {
    port = 8200
    protocol = "TCP"
    type = "ingress"
    cidr = ["0.0.0.0/0"]
  }
  outbound_traffic = {
    cidr = ["0.0.0.0/0"]
    port = 0
    protocol = "-1"
    type = "egress"
  }
}