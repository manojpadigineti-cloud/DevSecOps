# # IAM Role for EC2 to assume
# resource "aws_iam_role" "terraform_vault_role" {
#   name = "workload_full_access_role"
#
#   assume_role_policy = jsonencode({
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Effect": "Allow",
#             "Principal": {
#                "Service": "ec2.amazonaws.com"
#             },
#             "Action": "sts:AssumeRole"
#         }
#     ]
#   })
#   tags = {
#     Name = "workload_full_access_role"
#   }
# }
#
# #  IAM Policy (ec2:*)
# resource "aws_iam_policy" "iam_policy" {
#   policy = jsonencode({
# 	"Version": "2012-10-17",
# 	"Statement": [
#         {
#             "Sid": "FullAccess",
#             "Effect": "Allow",
#             "Action": "*",
#             "Resource": "*"
#         }
# 	]
#   })
# }
#
# # Attach policy to role
# resource "aws_iam_policy_attachment" "attach_iam" {
#   name       = "iam_policy_ec2_attach"
#   policy_arn = aws_iam_policy.iam_policy.arn
#   roles = [aws_iam_role.terraform_vault_role.name]
# }
#
# #  Create instance profile (needed to link role to EC2)
# resource "aws_iam_instance_profile" "ec2_instance_profile" {
#   name = "ec2-instance-profile"
#   role = aws_iam_role.terraform_vault_role.name
# }


resource "aws_instance" "ec2" {
  ami = var.ami
  instance_type = var.instance_type
  subnet_id = var.ec2_subnet
  vpc_security_group_ids = [var.security_group]
  iam_instance_profile = var.instance_profile
  root_block_device {
    volume_size = "70" #70GB
  }
  instance_market_options {
    market_type = "spot"
    spot_options {
      instance_interruption_behavior = "stop"
      spot_instance_type = "persistent"
  }
  }
  tags = {
    Name = "${var.instance_name}-spot"
  }
}