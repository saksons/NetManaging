module "pools" {
    source              = "../pool"
    mikrotik_pool_dir   = "/opt/mikrotikpool"
}

resource "libvirt_volume" "mikrotik_base_image" {
    name            = "mikrotik_base_image.qcow2"
    pool            = "iso"
    source = "/opt/iso/chr-7.19.2-base.qcow2"
}

resource "libvirt_volume" "mikrotik_worker_image" {
    count = var.worker_count
    name            = "mikrotik_worker_${count.index}.qcow2"
    pool            = module.pools.mikrotik_pool_name
    base_volume_id  = libvirt_volume.mikrotik_base_image.id
}
