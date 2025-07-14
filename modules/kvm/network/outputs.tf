output "UP_LINK_interface_id" {
  value       = var.UP_link_usable ? libvirt_network.network_up_link[0].id : null
  description = "ID of the UP-LINK net"
   
}

output "LAN_interface_ids" {
  value       = libvirt_network.network_LAN[*].id
  description = "IDs of the LAN net"
}

output "LAN_ids_by_names" {
  value       = tomap({for net in libvirt_network.network_LAN : net.name => net.id})
  description = "IDs of the exists LAN net by name"
}