resource "null_resource" "ansible_playbook" {
  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = var.password
    host     = var.server_ip
  }

  provisioner "remote-exec" {
    inline = [
      # "cd /home/ec2-user/DevSecOps_Project/ansible_terraform; bash ansible_run.sh ${join(" ", var.instances)}"
      "ansible-pull -i localhost -u https://github.com/ManojPadigineti/ansible_playbook.git  playbook.yml -e var_file=${var.instances}"
    ]
  }
}