resource "libvirt_domain" "vm" {
    count     = var.vm_count
    name      = "${var.name}_${count.index}"
    vcpu      = var.vcpu
    memory    = var.memory
    running   = var.running
    autostart = var.autostart
    console {
        type = "pty"
        target_type = "serial"
        target_port = "0"
    }
    # Creating UP_LINK if var.interface_up_link_id is not null
    dynamic "network_interface" {
        for_each = var.UP_LINK_interface_id != null ? [var.UP_LINK_interface_id] : []
        content {
            network_id = network_interface.value
            hostname   = "UP"
        }
    }
    # Creating new LAN interfaces if var.interface_lan_ids is not null
    dynamic "network_interface" {
        for_each = var.LAN_interface_ids != null ? var.LAN_interface_ids: []
        content {
            network_id = network_interface.value
        }
    }
    # Connect to exists LAN interfaces by id if var.LAN_interface_connect_by_id is not null
    dynamic "network_interface" {
        for_each = var.LAN_interface_connect_by_id != null ? var.LAN_interface_connect_by_id : []
        content {
            network_id = network_interface.value
        }
    }   

    disk {
        volume_id = var.worker_image_ids[count.index]
    }

    cloudinit = var.cloud_init_ids[count.index]
}