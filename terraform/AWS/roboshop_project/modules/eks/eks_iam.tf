resource "aws_iam_role" "eks_cluster_iam_role" {
  for_each = var.policy_roles
  name = each.key
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
          Service = [ "eks.amazonaws.com", "ec2.amazonaws.com", "pods.eks.amazonaws.com" ]
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "IAM_policy_attachment" {
  for_each = toset(var.policy_roles)
  depends_on = [aws_iam_role.eks_cluster_iam_role]
  policy_arn = each.value
  role       = each.key
}

