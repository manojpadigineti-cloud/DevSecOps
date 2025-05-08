resource "null_resource" "terraform_provisioner" {

  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = var.password
    host     = var.public_ip
  }

  provisioner "remote-exec" {
    inline = [
        "git clone https://github.com/ManojPadigineti/ansible_playbook.git",
        "cd /home/ec2-user/ansible_playbook ; git pull ; sudo bash /home/ec2-user/ansible_playbook/Install_terraform.sh",
        "sudo bash /home/ec2-user/ansible_playbook/install_ansible.sh",
        "cd /home/ec2-user/ansible_playbook/ ; ansible-playbook -i localhost playbook.yml -e var_file=hashicorp"
    ]
  }
}


