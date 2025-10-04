

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


