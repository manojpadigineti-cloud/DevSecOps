output "eks_subnet_id" {
  value = aws_subnet.main.id
}
output "vpc_id" {
  value = aws_subnet.main.vpc_id
}