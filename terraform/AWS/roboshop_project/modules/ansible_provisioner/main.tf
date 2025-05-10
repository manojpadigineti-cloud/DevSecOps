resource "null_resource" "terraform_provisioner" {

  connection {
    type     = "ssh"
    user     = var.username
    password = var.password
    host     = var.public_ip
  }

  provisioner "remote-exec" {
    inline = [
       "git clone https://github.com/ManojPadigineti/ansible_playbook.git",
        "cd /home/ec2-user/ansible_playbook/ ; git pull; pip install hvac; ansible-playbook -i localhost playbook.yml -e var_file=${var.server_name} -e vault_token=${var.vault_token}"
    ]
  }
}


