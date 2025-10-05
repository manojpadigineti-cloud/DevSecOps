variable "eks_cluster_name" {}
variable "subnet_ids" {}
variable "roles" {}
variable "nodegroup_name" {}
variable "addon" {}
variable "policy_roles_1" {
  type = list(string)
  default =  [ "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
                  "arn:aws:iam::aws:policy/eks:DescribeCluster",
                  "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPullOnly",
                  "arn:aws:iam::aws:policy/AmazonEKSComputePolicy",
                  "arn:aws:iam::aws:policy/AmazonEKSBlockStoragePolicy",
                  "arn:aws:iam::aws:policy/AmazonEKSLoadBalancingPolicy",
                  "arn:aws:iam::aws:policy/AmazonEKSNetworkingPolicy",
                  "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
                  "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
                  "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy" ]
}
variable "policy_roles_2" {
  type = list(string)
}
