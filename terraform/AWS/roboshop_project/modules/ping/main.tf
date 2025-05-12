resource "null_resource" "ping_resource" {

  provisioner "local-exec" {
    command = "ping ${var.server_ip}"
  }

}