terraform {
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
    }
    mikrotik = {
      source = "ddelnano/mikrotik"
      version = "0.16.1"
    }
  }
}