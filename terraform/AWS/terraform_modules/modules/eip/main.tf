resource "aws_eip" "instance-eip" {
  instance = var.eip_instances
  tags = {
    Name = "${var.instance}-eip"
  }
}