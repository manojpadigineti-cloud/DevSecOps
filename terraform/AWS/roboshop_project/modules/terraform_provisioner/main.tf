resource "null_resource" "terraform_provisioner" {

  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = var.password
    host     = var.public_ip
  }

  provisioner "remote-exec" {
    inline = [
        "git clone https://github.com/manojpadigineti-cloud/DevSecOps.git",
        "git pull ; sudo bash /home/ec2-user/DevSecOps/ansible/Install_terraform.sh",
        "sudo bash /home/ec2-user/DevSecOps/ansible/install_ansible.sh",
        "cd /home/ec2-user/DevSecOps/ansible ; ansible-playbook -i localhost playbook.yml -e var_file=hashicorp"
    ]
  }
}


