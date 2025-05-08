resource "aws_route_table" "public_route_table" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }
  tags = {
    Name = "public-igw_route"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = var.nat_gateway_id
  }
  tags = {
    Name = "private-natgw-route"
  }
}


resource "aws_route_table_association" "public_rt_associate_igw" {
  subnet_id     = var.public_subnet
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "private_rt_associate_nat" {
  subnet_id      = var.private_subnet
  route_table_id = aws_route_table.private_route_table.id
}

