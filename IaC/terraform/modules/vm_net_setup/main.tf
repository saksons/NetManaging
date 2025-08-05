resource "null_resource" "name" {
  provisioner "local-exec" {
    command = "bash ${path.module}/source/get_pts_and_run.sh > /dev/null 2>&1"
    environment = {
      "path_module"     = path.module
      "domain"          = var.domain_name
      "address"         = var.address
      "net_mask"        = var.net_mask
      "interface"       = var.interface
      "path_for_output" = var.path_for_output
    }
  }
  triggers = {
    run_once = "true"
  }
}