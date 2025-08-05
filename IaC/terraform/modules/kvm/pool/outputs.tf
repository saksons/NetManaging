output "pool_name" {
    value       = libvirt_pool.pool.name
    description = "Libvirt pool name for creating volume"
}