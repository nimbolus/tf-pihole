resource "openstack_networking_secgroup_v2" "pihole" {
  name        = "allow-pihole-${var.name}"
  description = "allow pihole server services"
}

resource "openstack_networking_secgroup_rule_v2" "ssh" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.pihole.id
}

resource "openstack_networking_secgroup_rule_v2" "ssh_v6" {
  count             = var.allow_ipv6 ? 1 : 0
  direction         = "ingress"
  ethertype         = "IPv6"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "::/0"
  security_group_id = openstack_networking_secgroup_v2.pihole.id
}

resource "openstack_networking_secgroup_rule_v2" "http" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 80
  port_range_max    = 80
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.pihole.id
}

resource "openstack_networking_secgroup_rule_v2" "http_v6" {
  count             = var.allow_ipv6 ? 1 : 0
  direction         = "ingress"
  ethertype         = "IPv6"
  protocol          = "tcp"
  port_range_min    = 80
  port_range_max    = 80
  remote_ip_prefix  = "::/0"
  security_group_id = openstack_networking_secgroup_v2.pihole.id
}

resource "openstack_networking_secgroup_rule_v2" "https" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 443
  port_range_max    = 443
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.pihole.id
}

resource "openstack_networking_secgroup_rule_v2" "https_v6" {
  count             = var.allow_ipv6 ? 1 : 0
  direction         = "ingress"
  ethertype         = "IPv6"
  protocol          = "tcp"
  port_range_min    = 443
  port_range_max    = 443
  remote_ip_prefix  = "::/0"
  security_group_id = openstack_networking_secgroup_v2.pihole.id
}

resource "openstack_networking_secgroup_rule_v2" "dns_udp" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "udp"
  port_range_min    = 53
  port_range_max    = 53
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.pihole.id
}

resource "openstack_networking_secgroup_rule_v2" "dns_udp_v6" {
  count             = var.allow_ipv6 ? 1 : 0
  direction         = "ingress"
  ethertype         = "IPv6"
  protocol          = "udp"
  port_range_min    = 53
  port_range_max    = 53
  remote_ip_prefix  = "::/0"
  security_group_id = openstack_networking_secgroup_v2.pihole.id
}

resource "openstack_networking_secgroup_rule_v2" "dns_tcp" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 53
  port_range_max    = 53
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.pihole.id
}

resource "openstack_networking_secgroup_rule_v2" "dns_tcp_v6" {
  count             = var.allow_ipv6 ? 1 : 0
  direction         = "ingress"
  ethertype         = "IPv6"
  protocol          = "tcp"
  port_range_min    = 53
  port_range_max    = 53
  remote_ip_prefix  = "::/0"
  security_group_id = openstack_networking_secgroup_v2.pihole.id
}

resource "openstack_networking_secgroup_rule_v2" "icmp" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.pihole.id
}

resource "openstack_networking_secgroup_rule_v2" "icmp_v6" {
  count             = var.allow_ipv6 ? 1 : 0
  direction         = "ingress"
  ethertype         = "IPv6"
  protocol          = "ipv6-icmp"
  remote_ip_prefix  = "::/0"
  security_group_id = openstack_networking_secgroup_v2.pihole.id
}
