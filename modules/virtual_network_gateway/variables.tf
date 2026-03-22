variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "vnet_gateway_name" {
  type = string
}

variable "vpn_gateway_pip_id" {
  type = string
}

variable "vpn_gateway_subnet_id" {
  type = string
}

variable "vpn_client_address_space" {
  type = list(string)
}

variable "tenant_id" {
  description = "ID of the tenant"
  type = string
}