output "ip" {
  value = libvirt_domain.mikrotik_vm[*].network_interface.0.addresses.0
}