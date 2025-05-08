data "aws_ami" "ec2_ami" {
  owners = [var.ami_owner]
  most_recent      = true
  name_regex       = var.ami_image_name
}
