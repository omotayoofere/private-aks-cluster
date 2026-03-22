variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "endpoint_subnet_id" {
  type = string
}

variable "endpoint_resource_name" {
  type = string
}

variable "private_resource_id" {
  type = string
}

variable "private_resource_name" {
  type = string
}

variable "private_dns_zone_resource_name" {
  type = string
}

variable "virtual_network_id" {
  type = string
}

variable "subresource_names" {
  type = list(string)
}
