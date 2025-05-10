# ├── main.pkr.hcl              # Main packer build + provisioners
# ├── variables.pkr.hcl         # Input variables (optional)
# ├── providers.pkr.hcl         # Provider (e.g., AWS, Azure, GCP)
# ├── scripts/
# │   └── install-tools.sh      # Shell provisioning scripts


source "amazon-ebs" "ec2" {
  ami_name      = "RHEL-DevOps-Manoj"
  instance_type = "t2.micro"
  region        = "us-east-1"
  # subnet_id =

  subnet_filter {
    filters = {
          "tag:Name" = "public-subnet"
    }
    most_free = true
    random = false
  }

  source_ami_filter {
    filters = {
      name                = "RHEL-9-DevOps-Practice"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["973714476881"]
  }
  ssh_username = "ec2-user"
  temporary_key_pair  = true
}

build {
  name    = "build_aws_ec2_ami"
  sources = [ "source.amazon-ebs.ec2" ]
  provisioner "shell" {
    inline = [
        "git clone https://github.com/manojpadigineti-cloud/DevSecOps.git",
        "git pull ; sudo bash /home/ec2-user/DevSecOps/ansible/Install_terraform.sh",
        "sudo bash /home/ec2-user/DevSecOps/ansible/install_ansible.sh"
    ]
}
}



