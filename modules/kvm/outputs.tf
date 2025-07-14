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