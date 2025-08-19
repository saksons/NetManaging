resource "tls_private_key" "pki" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "libvirt_pool" "openstack_server" {
  name = "openstack_server_pool"
  type = "dir"
  target {
    path = "/opt/libvirt_data/openstack_server"
  }
}

resource "libvirt_volume" "openstack_server_base_image" {
  name   = "openstack_server_base_image.qcow2"
  pool   = libvirt_pool.openstack_server.name
  source = "/opt/iso/ubuntu-24.10-server-cloudimg-amd64.img"
  format = "qcow2"
}

resource "libvirt_volume" "openstack_server_worker_image" {
  name            = "openstack_server_worker.qcow2"
  pool            = libvirt_pool.openstack_server.name
  base_volume_id  = libvirt_volume.openstack_server_base_image.id
  format = "qcow2"
}

resource "libvirt_volume" "openstack_server_worker_image_for_servers" {
  name            = "openstack_server_worker_for_servers.qcow2"
  pool            = libvirt_pool.openstack_server.name
  size = 240000000000
  format = "qcow2"
}

resource "libvirt_network" "network_up_link" {
  name      = "openstack_server_up_link"
  mode      = "nat"
  addresses = [local.envs.KVM_NET]
  autostart = true
  dhcp {
      enabled = false
  }
}

resource "random_password" "pass" {
  length      = 8
  special     = false
  numeric     = true
  min_lower   = 3
  min_numeric = 2
  min_upper   = 3
}

data "template_file" "user_data" {
  template = file("cloud-init.cfg")
  vars     = {"hostname"       = "openstack_server",
              "domain"         = "soks.local",
              "password"       = random_password.pass.result,
              "ssh_public_key" = tls_private_key.pki.public_key_openssh,
              "timezone"       = "Europe/Moscow"}
}


resource "libvirt_cloudinit_disk" "commoninit" {
  name      = "commoninit.iso"
  user_data = data.template_file.user_data.rendered
  pool      = libvirt_pool.openstack_server.name
}

resource "libvirt_domain" "vm" {
  name      = "openstack_server"
  vcpu      = 4
  memory    = 8192
  running   = true
  autostart = true
  console {
    type        = "pty"
    target_type = "serial"
    target_port = "0"
  }
  network_interface {
    network_id     = libvirt_network.network_up_link.id
    addresses      = [local.envs.UBUNTU_ADDRESS]
    mac            = "AA:BB:CC:11:22:22"
    wait_for_lease = true
  }
  disk {
    volume_id = libvirt_volume.openstack_server_worker_image.id
  }
  disk {
    volume_id = libvirt_volume.openstack_server_worker_image_for_servers.id
  }

  cloudinit = libvirt_cloudinit_disk.commoninit.id
}