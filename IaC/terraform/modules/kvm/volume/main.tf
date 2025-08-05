resource "libvirt_volume" "base_image" {
    name   = "${var.base_name}_base_image.qcow2"
    pool   = var.base_pool_name
    source = var.base_image_path
    format = "qcow2"
}

resource "libvirt_volume" "worker_image" {
    count = var.worker_count
    name            = "${var.worker_name}_worker_${count.index}.qcow2"
    pool            = var.worker_pool_name
    base_volume_id  = libvirt_volume.base_image.id
    format = "qcow2"
}
