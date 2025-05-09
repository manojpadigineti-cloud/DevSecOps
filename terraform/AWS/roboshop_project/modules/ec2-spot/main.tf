resource "aws_instance" "ec2" {
  ami = var.ami
  instance_type = var.instance_type
  subnet_id = var.ec2_subnet
  vpc_security_group_ids = [var.security_group]
  instance_market_options {
    market_type = "spot"
    spot_options {
      instance_interruption_behavior = "stop"
      spot_instance_type = "persistent"
  }
  }
  tags = {
    Name = "${var.instance_name}-spot"
  }
}