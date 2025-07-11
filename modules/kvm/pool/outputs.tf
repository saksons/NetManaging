output "pool_name" {
    value       = libvirt_pool.pool.name
    description = "libvirt pool name for creating volume"
}