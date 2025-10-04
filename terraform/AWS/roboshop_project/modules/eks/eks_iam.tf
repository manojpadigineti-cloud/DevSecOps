resource "aws_iam_role" "eks_cluster_iam_role" {
  name = var.eks_cluster_iam_role
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
          "sts:TagSession"
        ]
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "IAM_policy_attachment" {
  depends_on = [aws_iam_role.eks_cluster_iam_role]
  policy_arn = var.policy_arn
  role       = var.eks_cluster_iam_role
}

