module "images" {
    source          = "../volume"
    worker_count    = var.mikrotik_count
}

module "interfaces" {
    source          = "../network"
    mikrotik_count    = var.mikrotik_count
}

resource "libvirt_domain" "mikrotik_vm" {
    count   = var.mikrotik_count
    name    = "mikrotik-${count.index}"
    vcpu    = 1
    memory  = 512
    console {
        type = "pty"
        target_type = "serial"
        target_port = "0"
    }
    graphics {
        type = "spice"
        listen_type = "address"
        autoport = true
    }
    network_interface {
        network_id     = module.interfaces.mikrotik_interface_up_link_id[count.index]
        hostname       = "UP"
        mac            = "AA:AA:AA:1${count.index}:11:11"
    }

    network_interface {
        network_id     = module.interfaces.mikrotik_interface_p2p_id[count.index]
        hostname       = "P2P"
        mac            = "AA:BB:BB:22:2${count.index}:22"
    }


    dynamic "network_interface" {
        for_each = slice(
            module.interfaces.mikrotik_interface_lan_id,
            count.index * 3,
            (count.index + 1) * 3
        )
        content {
            network_id = network_interface.value
        }
    }

    disk {
        volume_id   = module.images.mikrotik_worker_image_id[count.index]
    }
}