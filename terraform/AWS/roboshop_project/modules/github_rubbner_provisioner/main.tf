resource "null_resource" "github_runner" {
  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = var.password
    host     = var.private_ip
  }
  provisioner "remote-exec" {
    inline = [
        "git clone https://github.com/manojpadigineti-cloud/DevSecOps.git",
        "cd /home/ec2-user/DevSecOps/ansible; git pull ;  ansible-playbook -i localhost playbook.yml -e var_file=github_runner -e vault_token=${var.vault_token}"
    ]
  }
}