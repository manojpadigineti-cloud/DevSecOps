output "eip_id" {
  value = aws_eip.eip.id
}

output "eip_publicip" {
  value = aws_eip.eip.public_ip
}