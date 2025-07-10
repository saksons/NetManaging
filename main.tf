module "vms" {
    source          = "./modules/kvm/domain"
    mikrotik_count  = 2
}
