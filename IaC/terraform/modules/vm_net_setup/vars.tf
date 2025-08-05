variable "domain_name" {
  type = string
  description = "Domain name for setup address"
}

variable "address" {
  type = string
  description = "IP address (10.10.10.2)"
}

variable "net_mask" {
  type = string
  description = "IP address mask (32 bits)"
}

variable "interface" {
  type = string
  description = "Interface (etherX; X: number)"
}

variable "path_for_output" {
  type = string
  description = "Path for output net info"
}