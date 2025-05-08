output "igw_route_table_id" {
  value = aws_route_table.public_route_table.id
}

output "NAT_route_table_id" {
  value = aws_route_table.private_route_table.id
}