variable "name" {
  default = "example"
}

variable "flavor" {
  default = "m1.small"
}

variable "image" {
  default = "debian-10-ansible"
}

variable "volume_type" {
  default = "ssd"
}

variable "availability_zone" {
  type = string
}

variable "hostname" {
  default = "pihole.example.com"
}

variable "network" {
  type = string
}

variable "subnet" {
  type    = string
  default = null
}

variable "mac_address" {
  type    = string
  default = null
}

variable "fixed_ip_address" {
  type    = string
  default = null
}

variable "port_security_enabled" {
  default = true
}

variable "key_pair" {
  type = string
}

variable "config_drive" {
  default = false
}

variable "custom_config" {
  default     = "# extra vars"
  description = "for parameters checkout https://git.zotha.de/ansible-roles/pihole/-/blob/master/defaults/main.yml"
}

variable "instance_metadata" {
  default = {}
}

variable "additional_interfaces" {
  description = "list of additional interfaces. Use integer keys to ensure interface order"
  default     = {}
  type = map(object({
    network               = string
    subnet                = string
    fixed_ip_address      = string
    mac_address           = string
    port_security_enabled = bool
  }))
}
