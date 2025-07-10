output "mikrotik_worker_image_id" {
  value       = libvirt_volume.mikrotik_worker_image[*].id
}
