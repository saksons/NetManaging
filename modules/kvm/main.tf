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
    LAN_count            = var.vm_count
    LAN_interfaces_count = var.lan_interface_count
    LAN_name             = var.name
    autostart            = var.autostart
}

module "vm" {
    source               = "./domain"
    vm_count             = var.vm_count
    name                 = var.name
    vcpu                 = var.vcpu
    memory               = var.memory
    running              = var.running
    autostart            = var.autostart
    interface_up_link_id = module.interfaces.interface_up_link_id
    interface_lan_ids    = module.interfaces.interface_lan_ids
    LAN_interfaces_count = var.lan_interface_count
    worker_image_ids     = module.images.worker_image_ids
}