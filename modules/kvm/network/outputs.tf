output "mikrotik_interface_up_link_id" {
  value       = libvirt_network.mikrotik_network_up_link[*].id
}

output "mikrotik_interface_p2p_id" {
  value       = libvirt_network.mikrotik_network_P2P[*].id
}

output "mikrotik_interface_lan_id" {
  value       = libvirt_network.mikrotik_network_LAN[*].id
}