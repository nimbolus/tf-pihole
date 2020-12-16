data "openstack_images_image_v2" "pihole" {
  name        = var.image
  most_recent = true
}

data "openstack_compute_flavor_v2" "pihole" {
  name = var.flavor
}

resource "openstack_blockstorage_volume_v3" "root" {
  name              = "pihole-${var.name}-root"
  image_id          = data.openstack_images_image_v2.pihole.id
  size              = 10
  availability_zone = var.availability_zone
  volume_type       = var.volume_type

  timeouts {
    create = "60m"
  }
}

resource "openstack_compute_instance_v2" "pihole" {
  name              = "pihole-${var.name}"
  flavor_id         = data.openstack_compute_flavor_v2.pihole.id
  availability_zone = var.availability_zone
  key_pair          = var.key_pair
  config_drive      = var.config_drive

  network {
    access_network = true
    port           = openstack_networking_port_v2.pihole.id
  }

  dynamic "network" {
    for_each = var.additional_interfaces
    content {
      port = openstack_networking_port_v2.extra[network.key].id
    }
  }

  block_device {
    delete_on_termination = false
    uuid                  = openstack_blockstorage_volume_v3.root.id
    source_type           = "volume"
    destination_type      = "volume"
  }

  user_data = templatefile("${path.module}/cloud-init/cloud-init.yml", {
    hostname      = var.hostname
    requirements  = filebase64("${path.module}/cloud-init/requirements.yml")
    playbook      = filebase64("${path.module}/cloud-init/playbook.yml")
    custom_config = var.custom_config
    mac_address   = openstack_networking_port_v2.pihole.mac_address
    subnets       = data.openstack_networking_subnet_v2.extra
    ports         = openstack_networking_port_v2.extra
  })

  metadata = var.instance_metadata
}
