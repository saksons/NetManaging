resource "random_password" "pass" {
    count       = var.cloud_init ? var.cloud_init_count : 0
    length      = 8
    special     = false
    numeric     = true
    min_lower   = 3
    min_numeric = 2
    min_upper   = 3
}

resource "tls_private_key" "pki" {
    count = var.cloud_init ? 1 : 0
    algorithm = "RSA"
    rsa_bits  = 4096
}

data "template_file" "user_data" {
    count    = var.cloud_init ? var.cloud_init_count : 0
    template = file("${path.module}/configs/base_cloud_init.cfg")
    vars     = {"hostname"       = "${var.hostname}_${count.index}",
                "domain"         = var.domain,
                "password"       = random_password.pass[count.index].result,
                "ssh_public_key" = "${var.public_key == null ? tls_private_key.pki[0].public_key_openssh : var.public_key}",
                "timezone"       = var.timezone}
}


resource "libvirt_cloudinit_disk" "commoninit" {
    count     = var.cloud_init ? var.cloud_init_count : 0
    name      = "commoninit-${count.index}.iso"
    user_data = data.template_file.user_data[count.index].rendered
    pool      = var.pool_name
}