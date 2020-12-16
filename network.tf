# main interface
data "openstack_networking_network_v2" "pihole" {
  name = var.network
}

data "openstack_networking_subnet_v2" "pihole" {
  count = var.subnet == null ? 0 : 1

  network_id = data.openstack_networking_network_v2.pihole.id
  name       = var.subnet
}

resource "openstack_networking_port_v2" "pihole" {
  name                  = "pihole-${var.name}"
  network_id            = data.openstack_networking_network_v2.pihole.id
  admin_state_up        = "true"
  port_security_enabled = var.port_security_enabled
  security_group_ids    = var.port_security_enabled ? [openstack_networking_secgroup_v2.pihole.id] : []
  mac_address           = var.mac_address

  dynamic "fixed_ip" {
    for_each = data.openstack_networking_subnet_v2.pihole

    content {
      ip_address = var.fixed_ip_address
      subnet_id  = data.openstack_networking_subnet_v2.pihole[fixed_ip.key].id
    }
  }
}

# additional interfaces
data "openstack_networking_network_v2" "extra" {
  for_each = var.additional_interfaces

  name = var.additional_interfaces[each.key].network
}

data "openstack_networking_subnet_v2" "extra" {
  for_each = var.additional_interfaces

  network_id = data.openstack_networking_network_v2.extra[each.key].id
  name       = var.additional_interfaces[each.key].subnet
}

resource "openstack_networking_port_v2" "extra" {
  for_each = var.additional_interfaces

  name           = "pihole-${var.name}-${var.additional_interfaces[each.key].subnet}"
  network_id     = data.openstack_networking_network_v2.extra[each.key].id
  admin_state_up = "true"
  mac_address    = var.additional_interfaces[each.key].mac_address

  fixed_ip {
    ip_address = var.additional_interfaces[each.key].fixed_ip_address
    subnet_id  = data.openstack_networking_subnet_v2.extra[each.key].id
  }

  port_security_enabled = var.additional_interfaces[each.key].port_security_enabled
}
