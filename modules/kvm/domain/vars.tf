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

variable "interface_up_link_id" {
  type        = string
  description = "ID of the UP-LINK interface"
}

variable "interface_lan_ids" {
  type        = list
  description = "IDs list of the LAN interfaces"
}

variable "LAN_interfaces_count" {
  type        = number
  description = "Count of the LAN interfaces per VM"
}

variable "worker_image_ids" {
  type        = list
  description = "IDs list of the worker volumes"
}