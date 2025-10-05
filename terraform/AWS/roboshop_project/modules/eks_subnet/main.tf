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
#   ROUTE TABLE ASSOC     #
#=========================#

resource "aws_route_table_association" "public_subnet_assoc" {
  for_each = var.subnet_associate
  subnet_id      = aws_subnet.main[each.value].id
  route_table_id = var.routetable_id
}


