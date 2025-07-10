resource "libvirt_network" "mikrotik_network_up_link" {
    count   = 1 * var.mikrotik_count
    name    = "mikrotik-net-up-link-${count.index}"
    mode    = "nat"
    addresses = ["10.10.${count.index}.0/24"]
}

resource "libvirt_network" "mikrotik_network_P2P" {
    count   = 1 * var.mikrotik_count
    name    = "mikrotik-net-p2p-${count.index}"
    mode    = "none"
}

resource "libvirt_network" "mikrotik_network_LAN" {
    count   = 3 * var.mikrotik_count
    name    = "mikrotik-net-${count.index}"
    mode    = "none"
}