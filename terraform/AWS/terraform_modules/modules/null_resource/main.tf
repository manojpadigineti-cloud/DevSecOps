resource "null_resource" "public_ip_checker" {
  triggers = { # If anything changes, terraform will re-run, If EC2 gets a new Public IP, automatically re-run Route53 updates.
    public_ip = var.public_ip
  }
}