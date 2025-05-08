resource "aws_vpc" "roboshop_vpc" {
  cidr_block = var.cidr

  tags = {
    Name = var.vpc_name
  }
}

