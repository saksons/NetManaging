module "mikrotik" {
  source = "./modules/kvm"
  pool_dir = "/opt/libvirt_data/mikrotik"
  base_image_path = "/opt/iso/chr-7.19.2-base.qcow2"
  lan_interface_count = 3
  name = "mikrotik"
  vcpu = 1
  memory = 1024
  running = false
  vm_count = 2
}