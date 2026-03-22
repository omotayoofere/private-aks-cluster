variable "common_tags" {
  description = "Common tag for all resources"
  type = map(string)
  default = {
    Owner = "Emart-group"
    Project = "Emart"
    CSP = "Azure"
  }
}

variable "azure_sub_id" {
  description = "ID of azure subscription"
  type = string
}

variable "vpn_gateway_public_ip_name" {
  type = string
}

variable "vpn_client_address_space" {
  type = list(string)
}

variable "tenant_id" {
  type = string
}

variable "vpn_gateway_pip_zones" {
  type = list(string)
  default = null
}
