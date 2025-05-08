
resource "null_resource" "ansible_provisioner" {
  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = var.password
    host     = var.server_ip
  }
    provisioner "remote-exec" {
      inline = [
        "cd /home/ec2-user/",
        "sudo dnf install git -y",
        "git clone https://github.com/ManojPadigineti/DevSecOps_Project.git",
        "cd /home/ec2-user/DevSecOps_Project/ansible_terraform",
        "sudo bash /home/ec2-user/DevSecOps_Project/ansible_terraform/install_ansible.sh"
      ]
    }
}