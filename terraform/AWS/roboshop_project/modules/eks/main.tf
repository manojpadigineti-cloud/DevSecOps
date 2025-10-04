

resource "aws_eks_cluster" "eks_cluster" {
  depends_on = [aws_iam_role.eks_cluster_iam_role, aws_iam_role_policy_attachment.IAM_policy_attachment]

  name = var.eks_cluster_name

  access_config {
    authentication_mode = "API_AND_CONFIG_MAP"
    bootstrap_cluster_creator_admin_permissions = true
  }

  role_arn = aws_iam_role.eks_cluster_iam_role.arn
  version  = "1.31"

  vpc_config {
    subnet_ids = var.subnet_ids
  }

}


###################
#   Node Group    #
###################

resource "aws_eks_node_group" "node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = var.nodegroup_name
  node_role_arn   = aws_iam_role.eks_cluster_iam_role.arn
  subnet_ids      = var.subnet_ids

  scaling_config {
    desired_size = 1
    max_size     = 3
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

}


