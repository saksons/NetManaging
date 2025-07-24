# Pool settings
variable "pool_dir" {
  type        = string
  description = "Linux dir for libvirt pool"
}

# Volume settings
variable "base_pool_name" {
  type        = string
  description = "Name of the pool where base image is exist"
  default = "iso"
}

variable "base_image_path" {
  type        = string
  description = "Path to base image in '$base_pool_name'"
}

# Interface settings
variable "UP_link_usable" {
  type        = bool
  description = "Net 'UP_link' will be used"
  default = true
}

variable "UP_link_address_net" {
  type        = string
  description = "Addresses of the net UP-LINK"
  default = "10.10.10.0/24"
}

variable "LAN_usable" {
  type        = bool
  description = ""
  default = false
}

variable "LAN_interface_names" {
  type        = list
  description = "Names of the net LAN"
  nullable = true
  default = null
}

variable "LAN_interface_connect_by_id" {
  type        = list
  description = "List of IDs for connection to LAN net"
  nullable = true
  default = null
}

# Cloud init
variable "cloud_init" {
  type        = bool
  description = "Cloud-init will be used"
  default     = true
}

variable "hostname" {
  type        = string
  description = "Hostname of the VM"
  default    = null
}

variable "domain" {
  type        = string
  description = "Domain name for the VM"
  default     = "soks.local"
  # validation {
  #   condition = strcontains(var.domain, '.')
  #   error_merror_message = "Symbol '.' must be in variable"
  # }
}

variable "public_key" {
  type        = string
  description = "Public key for the ssh on VM"
  nullable    = true
  default = "null"
}

variable "timezone" {
  type        = string
  description = "Timezone for the VM 'Region/City'"
  default     = "Europe/Moscow"
}

# VM settings
variable "name" {
  type        = string
  description = "Name of the VMs"
}

variable "vcpu" {
  type        = number
  description = "Virtual CPU of the VMs"
}

variable "memory" {
  type        = number
  description = "RAM of the VMs"
}

variable "running" {
  type        = bool
  description = "Will be started after applying"
  default     = true
}

variable "autostart" {
  type        = bool
  description = "Autostart at system boot"
  default     = true
}

variable "vm_count" {
  type        = number
  description = "Count of the VMs"
}