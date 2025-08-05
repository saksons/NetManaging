resource "libvirt_pool" "pool" {
    name    = "${var.pool_name}_volume_pool"
    type    = "dir"
    target {
        path = var.pool_dir
    }
}