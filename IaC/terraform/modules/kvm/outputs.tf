output "max_vm_count" {
  value       = var.vm_count
  description = "Variable 'vm_count'"
}

output "domain_name" {
  value       = var.name
  description = "Variable 'name'"
}

output "LAN_ids_by_names" {
  value       = module.interfaces.LAN_ids_by_names
  description = "IDs of the exists LAN net by name"
}

output "private_key" {
  value       = module.cloud_init.private_key
  description = "Private key for VMs"
  sensitive   = true
}

output "pub_key" {
  value       = module.cloud_init.pub_key
  description = "Private key for VMs"
  sensitive   = true
}

output "passwords" {
  value       = module.cloud_init.passwords
  description = "Passwords for the VMs (passwords ordered by the creation VM)"
  sensitive   = true
}