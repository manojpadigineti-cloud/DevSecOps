resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "roboshop_nat_for_private_subnet" {
  depends_on = [aws_eip.nat_eip]
  allocation_id = aws_eip.nat_eip.id  #eip-association
  subnet_id     = var.nat_subnet  # Nat should be in public Subnet

  tags = {
    Name = var.nat_name
  }

}