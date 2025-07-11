output "worker_image_ids" {
  value       = libvirt_volume.worker_image[*].id
  description = "Libvirt volume ids for creating disk in vm"
}
