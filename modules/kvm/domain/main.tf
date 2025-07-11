resource "libvirt_domain" "vm" {
    count   = var.vm_count
    name    = "${var.name}_${count.index}"
    vcpu    = var.vcpu
    memory  = var.memory
    running = var.running
    console {
        type = "pty"
        target_type = "serial"
        target_port = "0"
    }
    # check if network interface is exists
    dynamic "network_interface" {
        for_each = var.interface_up_link_id != null ? [var.interface_up_link_id] : []
        content {
            network_id = network_interface.value
            hostname   = "UP"
        }
    }
    dynamic "network_interface" {
        for_each = slice(
            var.interface_lan_ids,
            count.index * var.LAN_interfaces_count,
            (count.index + 1) * var.LAN_interfaces_count
        )
        content {
            network_id = network_interface.value
        }
    }
    disk {
        volume_id = var.worker_image_ids[count.index]
    }
}