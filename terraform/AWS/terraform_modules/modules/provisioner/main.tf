resource "null_resource" "local_exec_provisioner" {
  provisioner "local-exec" {
    command = "sleep 400"
    interpreter = ["/bin/bash", "-c"]
  }
}