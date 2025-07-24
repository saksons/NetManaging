resource "tls_private_key" "pki" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

module "mikrotik_vm_controller" {
  source              = "./modules/kvm"
  pool_dir            = "/opt/libvirt_data/mikrotik_control"
  base_image_path     = "/opt/iso/chr-7.19.2-base.qcow2"
  UP_link_usable      = true
  LAN_usable          = true
  LAN_interface_names = ["p2p", "main_server"]
  name                = "mikrotik_control"
  vcpu                = 1
  memory              = 512
  running             = true
  autostart           = true
  vm_count            = 1
  cloud_init          = false
}

module "mikrotik_vm_worker" {
  source                      = "./modules/kvm"
  pool_dir                    = "/opt/libvirt_data/mikrotik_worker"
  base_image_path             = "/opt/iso/chr-7.19.2-base.qcow2"
  UP_link_usable              = false
  LAN_usable                  = true
  LAN_interface_names         = ["k8s", "test_arch_servers"]
  LAN_interface_connect_by_id = [module.mikrotik_vm_controller.LAN_ids_by_names["p2p_LAN"]]
  name                        = "mikrotik_worker"
  vcpu                        = 1
  memory                      = 512
  running                     = true
  autostart                   = true
  vm_count                    = 1
  cloud_init                  = false
}

module "main_arch_server" {
  source                      = "./modules/kvm"
  pool_dir                    = "/opt/libvirt_data/main_arch_server"
  base_image_path             = "/opt/iso/Arch-Linux-x86_64-cloudimg.qcow2"
  UP_link_usable              = false
  LAN_usable                  = false
  LAN_interface_connect_by_id = [module.mikrotik_vm_controller.LAN_ids_by_names["main_server_LAN"]]
  name                        = "main_arch_server"
  vcpu                        = 2
  memory                      = 4096
  running                     = true
  autostart                   = true
  vm_count                    = 1
  hostname                    = "main-arch"
  public_key                  = tls_private_key.pki.public_key_openssh
}

module "test_arch_server" {
  source                      = "./modules/kvm"
  pool_dir                    = "/opt/libvirt_data/test_arch_servers"
  base_image_path             = "/opt/iso/Arch-Linux-x86_64-cloudimg.qcow2"
  UP_link_usable              = false
  LAN_usable                  = false
  LAN_interface_connect_by_id = [module.mikrotik_vm_worker.LAN_ids_by_names["test_arch_servers_LAN"]]
  name                        = "test_arch_server"
  vcpu                        = 1
  memory                      = 1024
  running                     = true
  autostart                   = true
  vm_count                    = 2
  hostname                    = "test-arch"
  public_key                  = tls_private_key.pki.public_key_openssh
}

module "k8s_cluster_control" {
  source                      = "./modules/kvm"
  pool_dir                    = "/opt/libvirt_data/k8s_cluster_control"
  base_image_path             = "/opt/iso/Arch-Linux-x86_64-cloudimg.qcow2"
  UP_link_usable              = false
  LAN_usable                  = false
  LAN_interface_connect_by_id = [module.mikrotik_vm_worker.LAN_ids_by_names["k8s_LAN"]]
  name                        = "k8s_control"
  vcpu                        = 1
  memory                      = 2048
  running                     = true
  autostart                   = true
  vm_count                    = 1
  hostname                    = "control-k8s"
  public_key                  = tls_private_key.pki.public_key_openssh
}

module "k8s_cluster_worker" {
  source                      = "./modules/kvm"
  pool_dir                    = "/opt/libvirt_data/k8s_cluster_worker"
  base_image_path             = "/opt/iso/Arch-Linux-x86_64-cloudimg.qcow2"
  UP_link_usable              = false
  LAN_usable                  = false
  LAN_interface_connect_by_id = [module.mikrotik_vm_worker.LAN_ids_by_names["k8s_LAN"]]
  name                        = "k8s_worker"
  vcpu                        = 1
  memory                      = 1024
  running                     = true
  autostart                   = true
  vm_count                    = 3
  hostname                    = "worker-k8s"
  public_key                  = tls_private_key.pki.public_key_openssh
}