# Route table Association
resource "aws_route_table_association" "public_rt_associate_igw" {
  subnet_id     = var.public_subnet
  route_table_id = var.route_table_id_IGW
}

resource "aws_route_table_association" "private_rt_associate_nat" {
  subnet_id      = var.private_subnet
  route_table_id = var.route_table_id__NAT
}


