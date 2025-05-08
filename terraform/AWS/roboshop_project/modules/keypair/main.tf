resource "aws_key_pair" "ec2_keypair" {
  public_key = ""
}

resource "aws_instance" "ec2" {
  instance_type = "0"
  associate_public_ip_address = true
  key_name = aws_key_pair.ec2_keypair.key_name
}
