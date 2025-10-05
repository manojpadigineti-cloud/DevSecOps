resource "aws_iam_role" "eks_cluster_iam_role" {
  for_each = var.roles
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
          Service = [ "eks.amazonaws.com", "ec2.amazonaws.com" ]
        }
      },
    ]
  })
}

resource "aws_iam_role" "eks_pod_identity_role" {
  name = "roboshop-pod-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "pods.eks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Attach policies needed by that pod
resource "aws_iam_role_policy_attachment" "pod_policy" {
  role       = aws_iam_role.eks_pod_identity_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

resource "aws_iam_role_policy_attachment" "IAM_policy_attachment" {
  for_each = toset(var.policy_roles_1)
  depends_on = [aws_iam_role.eks_cluster_iam_role]
  policy_arn = each.value
  role       = aws_iam_role.eks_cluster_iam_role["policy_role1"].name
}

resource "aws_iam_role_policy_attachment" "IAM_policy_attachment2" {
  for_each = toset(var.policy_roles_2)
  depends_on = [aws_iam_role.eks_cluster_iam_role]
  policy_arn = each.value
  role       = aws_iam_role.eks_cluster_iam_role["policy_role2"].name
}
