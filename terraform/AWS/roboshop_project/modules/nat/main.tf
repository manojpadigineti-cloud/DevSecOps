resource "aws_eip" "nat_eip" {
  domain   = "vpc"
  tags = {
    Name = var.nat_eip_name
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = var.public_subnet_nat
  tags = {
    Name = var.nat_name
  }
}


