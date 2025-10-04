resource "aws_subnet" "main" {
  vpc_id     = var.vpc_id
  cidr_block = var.cidr
  availability_zone = var.subnet_zone

  tags = {
    Name = var.subnet_name
  }
}


