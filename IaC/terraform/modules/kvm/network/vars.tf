variable "UP_link_usable" {
  type        = bool
  description = "Net 'UP_link' will be used"
  default = true
}

variable "UP_link_name" {
  type        = string
  description = "Name of the net UP-LINK"
  nullable    = true
}

variable "UP_link_address_net" {
  type        = string
  description = "Addresses of the net UP-LINK"
}

variable "LAN_usable" {
  type        = bool
  description = "Net 'LAN' will be used"
}

variable "LAN_count" {
  type        = number
  description = "Count of the net LAN from VMS"
  nullable    = true
}

variable "LAN_interface_names" {
  type        = list
  description = "Names of the net LAN"
  nullable    = true
}

variable "autostart" {
  type        = bool
  description = "Autostart at system boot"
}