resource "null_resource" "get_net_info" {
  provisioner "local-exec" {
    command = "bash ${path.module}/source/get_net_info.sh"
    environment   = {
      "path_for_output"   = var.path_for_output
      "max_vm_count" = var.max_vm_count - 1
      "domain"  = var.domain_name
    }
  }

  triggers = {
    always_run = timestamp()
  }
}

data "local_file" "mikrotik_net_info" {
  filename = "${var.path_for_output}/mikrotik_net_info.json"
  depends_on = [null_resource.get_net_info]
}
