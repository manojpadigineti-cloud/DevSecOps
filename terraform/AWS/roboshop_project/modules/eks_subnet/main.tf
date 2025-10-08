resource "aws_subnet" "main" {
  vpc_id     = var.vpc_id
  cidr_block = var.cidr
  availability_zone = var.subnet_zone
  map_public_ip_on_launch = true

  tags = {
    Name = var.subnet_name
  }
}

#=========================#
#   ROUTE TABLE CREATE    #
#=========================#

resource "aws_route_table" "rt" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.IGW_id
  }

  tags = {
    Name = "eks_route_table"
  }
}

#=========================#
#   ROUTE TABLE ASSOC     #
#=========================#

resource "aws_route_table_association" "public_subnet_assoc" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.rt.id
}


