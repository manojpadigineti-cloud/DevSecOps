output "eip_associate_output" {
  value = aws_eip_association.eip_assoc.public_ip
}