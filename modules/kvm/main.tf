module "pool" {
  source    = "./pool"
  pool_name = var.name
  pool_dir  = var.pool_dir
}

module "images" {
  source           = "./volume"
  base_name        = var.name
  base_pool_name   = var.base_pool_name
  base_image_path  = var.base_image_path
  worker_count     = var.vm_count
  worker_name      = var.name
  worker_pool_name = module.pool.pool_name
}

module "interfaces" {
  source               = "./network"
  UP_link_name         = var.name
  UP_link_address_net  = var.UP_link_address_net
  UP_link_usable       = var.UP_link_usable
  LAN_usable           = var.LAN_usable 
  LAN_count            = var.vm_count
  LAN_interface_names  = var.LAN_interface_names
  autostart            = var.autostart
}

module "cloud_init" {
  source           = "./cloud-init"
  cloud_init_count = var.vm_count
  hostname         = var.hostname != null ? var.hostname : var.name
  pool_name        = module.pool.pool_name
  domain           = var.domain
  public_key       = var.public_key 
  timezone         = var.timezone
}

module "vm" {
  source               = "./domain"
  vm_count             = var.vm_count
  name                 = var.name
  vcpu                 = var.vcpu
  memory               = var.memory
  running              = var.running
  autostart            = var.autostart
  UP_LINK_interface_id = module.interfaces.UP_LINK_interface_id
  LAN_interface_ids    = module.interfaces.LAN_interface_ids
  LAN_interface_connect_by_id = var.LAN_interface_connect_by_id
  LAN_interfaces_count = var.LAN_usable ? length(var.LAN_interface_names) : 0
  worker_image_ids     = module.images.worker_image_ids
  cloud_init_ids        = module.cloud_init.ids
}