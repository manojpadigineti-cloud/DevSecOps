

resource "aws_eks_cluster" "eks_cluster" {
  depends_on = [aws_iam_role.eks_cluster_iam_role, aws_iam_role_policy_attachment.IAM_policy_attachment]

  name = var.eks_cluster_name

  access_config {
    authentication_mode = "API_AND_CONFIG_MAP"
    bootstrap_cluster_creator_admin_permissions = true
  }

  role_arn = aws_iam_role.eks_cluster_iam_role["policy_role1"].arn
  version  = "1.34"

  vpc_config {
    subnet_ids = var.subnet_ids
  }

}


###################
#   Node Group    #
###################

resource "aws_eks_node_group" "node_group" {
  depends_on = [aws_eks_cluster.eks_cluster, aws_eks_pod_identity_association.pod_identity]
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = var.nodegroup_name
  node_role_arn   = aws_iam_role.eks_cluster_iam_role["policy_role2"].arn
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

###################
#     ADD-ON      #
###################

resource "aws_eks_addon" "eks_addon" {
  for_each = toset(var.addon)
  cluster_name                = aws_eks_cluster.eks_cluster.name
  addon_name                  = each.key
  # addon_version               = "v1.10.1-eksbuild.1" #e.g., previous version v1.9.3-eksbuild.3 and the new version is v1.10.1-eksbuild.1
  # resolve_conflicts_on_update = "PRESERVE"
}

resource "aws_eks_pod_identity_association" "pod_identity" {
  depends_on = [aws_iam_role_policy_attachment.pod_policy]
  cluster_name    = aws_eks_cluster.eks_cluster.name
  namespace       = "kube-system"
  service_account = "pod-serviceaccount"
  role_arn        = aws_iam_role.eks_pod_identity_role.arn
}

resource "aws_eks_access_entry" "example" {
  cluster_name      = aws_eks_cluster.eks_cluster.name
  principal_arn     =  "arn:aws:iam::260380093736:root"
}