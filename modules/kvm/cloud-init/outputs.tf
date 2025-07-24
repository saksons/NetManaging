output "private_key" {
    value       = tls_private_key.pki[0].private_key_pem
    description = "Private key for VMs"
    sensitive   = true
}

output "pub_key" {
    value       = tls_private_key.pki[0].public_key_openssh
    description = "Private key for VMs"
    sensitive   = true
}

output "ids" {
    value       =  libvirt_cloudinit_disk.commoninit[*].id
    description = "IDs of the cloudinit disks"
}

output "passwords" {
  value       = random_password.pass[*].result
  description = "Passwords for the VMs (passwords ordered by the creation VM)"
  sensitive   = true
}