resource "aws_instance" "ec2" {
  ami = data.aws_ami.ec2_ami.id
  instance_type = var.instance_type
  subnet_id = var.ec2_subnet
  vpc_security_group_ids = [var.security_group]
  tags = {
    Name = var.microservice_name
  }
}