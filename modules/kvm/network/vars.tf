variable "UP_link_name" {
  type        = string
  description = "Name of the net UP-LINK"
}

variable "UP_link_address_net" {
  type        = string
  description = "Addresses of the net UP-LINK"
}

variable "LAN_count" {
  type        = number
  description = "Count of the net LAN from VMS"
}

variable "LAN_interfaces_count" {
  type        = number
  description = "Count of the LAN interfaces per VM"
}

variable "LAN_name" {
  type        = string
  description = "Name of the net LAN"
}

variable "autostart" {
  type        = bool
  description = "Autostart at system boot"
}