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
variable "UP_link_address_net" {
  type        = string
  description = "Addresses of the net UP-LINK"
  default = "10.10.10.0/24"
}

variable "lan_interface_count" {
  type        = number
  description = "Count of the net LAN from VMS"
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
  default = true
}

variable "vm_count" {
  type        = number
  description = "Count of the VMs"
}