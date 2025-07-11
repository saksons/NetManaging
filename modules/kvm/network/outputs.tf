output "interface_up_link_id" {
  value       = libvirt_network.network_up_link[0].id
  description = "ID of the UP-LINK net"
}

output "interface_lan_ids" {
  value       = libvirt_network.network_LAN[*].id
  description = "IDs of the LAN net"
}