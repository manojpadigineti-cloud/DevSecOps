resource "null_resource" "sleep_provisioner" {

  provisioner "local-exec" {
    command = "sleep 300"
  }
}

