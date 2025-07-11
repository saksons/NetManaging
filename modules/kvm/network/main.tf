resource "libvirt_network" "network_up_link" {
    count     = var.UP_link_name != null && var.UP_link_address_net != null ? 1 : 0
    name      = "${var.UP_link_name}_up_link"
    mode      = "nat"
    addresses = ["${var.UP_link_address_net}"]
    autostart = var.autostart
}

resource "libvirt_network" "network_LAN" {
    count   = 3 * var.LAN_count
    name    = "${var.LAN_name}_LAN_${count.index}"
    mode    = "none"
    autostart = var.autostart
}