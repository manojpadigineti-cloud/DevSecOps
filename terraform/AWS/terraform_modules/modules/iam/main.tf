# resource "aws_iam_role" "ec2_role" {
#   name = var.ec2_role_name
#
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Effect = "Allow",
#         Principal = {
#           Service = "ec2.amazonaws.com"
#         },
#         Action = "sts:AssumeRole"
#       }
#     ]
#   })
#
#   description = "Role for EC2 instances to have full access to EC2 service"
# }
#
#
# resource "aws_iam_instance_profile" "ec2_profile" {
#   name = var.ec2_profile_name
#   role = aws_iam_role.ec2_role.name
# }
#
#
# # #  create an IAM role with the necessary assume role policy.
# # resource "aws_iam_role" "ec2_role" {
# #   name = var.ec2_role_name
# #   assume_role_policy = file("iam_role.json")
# # }
# #
# # # create the IAM policies that you want to attach to the role.
# # resource "aws_iam_policy" "ec2_policy" {
# #   name = var.ec2_policy_name
# #   policy = file("iam_policy.json")
# # }
# #
# # # Attach the created policies to the IAM role.
# # resource "aws_iam_policy_attachment" "ec2-trust-policy" {
# #   name = "ec2-trust-policy"
# #   roles = [aws_iam_role.ec2_role.name]
# #   policy_arn = aws_iam_policy.ec2_policy.arn
# # }
# #
# # # Create an instance profile and associate it with the IAM role.
# # resource "aws_iam_instance_profile" "ec2_instance_profile" {
# #   name = "ec2-instance-profile"
# #   role = aws_iam_role.ec2_role.name
# # }
# #
# # variable "ec2_role_name" { roboshop_terraform_role }
# # variable "ec2_policy_name" { ec2-policy}
# # variable "role_file" {}
# # variable "policy_name" {}
# # variable "" {}