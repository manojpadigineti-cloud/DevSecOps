output "eip_associate_publicip" {
  value = aws_eip_association.eip_assoc.public_ip
}