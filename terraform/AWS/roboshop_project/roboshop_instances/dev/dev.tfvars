ami_name = "RHEL-DevOps-Manoj" #"RHEL-9-DevOps-Practice"
ami_owner = ["260380093736"] #973714476881
security_group_id = "sg-055ec21053a42f5de"
public_subnet_id = "subnet-0a745d094a7bd3915"
private_subnet_id = "subnet-0c6bb7036857981d6"
vpc_id = "vpc-0bf351a4a107e2830"
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

eks_subnets = {
    eks-subnet-1 = {
      cidr = "14.0.3.0/24"
      subnet_zone = "us-east-1d"
  }
    eks-subnet-2 = {
      cidr = "14.0.4.0/24"
      subnet_zone = "us-east-1c"
  }
}


EKS = {
  Roboshop_eks_cluster = {
    subnets = ["eks-subnet-1", "eks-subnet-2" ]
  }
}

# eks_policy_arn = [ "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
#                   "arn:aws:iam::aws:policy/AmazonEKSWorkerNodeMinimalPolicy",
#                   "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPullOnly",
#                   "arn:aws:iam::aws:policy/AmazonEKSComputePolicy",
#                   "arn:aws:iam::aws:policy/AmazonEKSBlockStoragePolicy",
#                   "arn:aws:iam::aws:policy/AmazonEKSLoadBalancingPolicy",
#                   "arn:aws:iam::aws:policy/AmazonEKSNetworkingPolicy",
#                   "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
#                   "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
#                   "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
#                   ]

addon = ["vpc-cni", "coredns" ]

policy_roles = {
  policy_role1 = {
    name = "role1"
  }
  policy_role2 = {
    name = "role2"
  }
}

attach_policy_role = [  "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess",
                        "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
                        "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
                        "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
                        "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
                        "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
                      ]
