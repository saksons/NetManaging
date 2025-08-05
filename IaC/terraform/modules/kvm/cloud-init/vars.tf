variable "cloud_init" {
  type        = bool
  description = "Cloud-init will be used"
  default     = true
}

variable "cloud_init_count" {
  type        = number
  description = "Count of the cloud-init"
}

variable "hostname" {
  type        = string
  description = "Hostname of the VM"
}

variable "domain" {
  type        = string
  description = "Domain name for the VM"
}

variable "public_key" {
  type        = string
  description = "Public key for the ssh on VM"
  nullable    = true
}

variable "timezone" {
  type        = string
  description = "Timezone for the VM 'Region/City'"
}

variable "pool_name" {
  type        = string
  description = "Name of the pool for cloud_init.iso"
}