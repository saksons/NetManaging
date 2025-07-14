variable "vm_count" {
  type        = number
  description = "Count of the VMs"
}

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
}

variable "autostart" {
  type        = bool
  description = "Autostart at system boot"
}

variable "UP_LINK_interface_id" {
  type        = string
  description = "ID of the UP-LINK interface"
  nullable = true
}

variable "LAN_interface_ids" {
  type        = list
  description = "IDs list of the LAN interfaces"
  nullable    = true
}

variable "LAN_interfaces_count" {
  type        = number
  description = "Count of the LAN interfaces per VM"
  nullable    = true
}

variable "LAN_interface_connect_by_id" {
  type        = list
  description = "List of IDs for connecting to the exists net"
  nullable    = true
}

variable "worker_image_ids" {
  type        = list
  description = "IDs list of the worker volumes"
}