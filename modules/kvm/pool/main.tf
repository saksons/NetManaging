resource "libvirt_pool" "mikrotik_pool" {
    name    = "mikrotik-volume-pool"
    type    = "dir"
    target {
        path = var.mikrotik_pool_dir
    }
}