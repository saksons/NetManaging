output "private_key" {
  value     = tls_private_key.pki.private_key_openssh
  sensitive = true
}

output "public_key" {
  value     = tls_private_key.pki.public_key_openssh
  sensitive = true
}

output "passwords_main_arch_server" {
  value = random_password.pass.result
  sensitive = true
}

output "console" {
  value = "bash ./console.sh"
}