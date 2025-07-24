output "private_key" {
  value     = tls_private_key.pki.private_key_openssh
  sensitive = true
}

output "public_key" {
  value     = tls_private_key.pki.public_key_openssh
  sensitive = true
}

output "passwords_main_arch_server" {
  value = module.main_arch_server.passwords
  sensitive = true
}

output "passwords_test_arch_server" {
  value = module.test_arch_server.passwords
  sensitive = true
}

output "passwords_k8s_control" {
  value = module.k8s_cluster_control.passwords
  sensitive = true
}

output "passwords_k8s_worker" {
  value = module.k8s_cluster_worker.passwords
  sensitive = true
}

output "console" {
  value = file("bash ./console.sh")
}