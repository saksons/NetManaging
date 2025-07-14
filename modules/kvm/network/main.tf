resource "libvirt_network" "network_up_link" {
    count     = var.UP_link_usable ? 1 : 0
    name      = "${var.UP_link_name}_up_link"
    mode      = "nat"
    addresses = ["${var.UP_link_address_net}"]
    autostart = var.autostart
}

resource "libvirt_network" "network_LAN" {
    count   = var.LAN_usable ? length(var.LAN_interface_names) * var.LAN_count : 0
    name    = "${var.LAN_interface_names[count.index]}_LAN"
    mode    = "none"
    autostart = var.autostart
}