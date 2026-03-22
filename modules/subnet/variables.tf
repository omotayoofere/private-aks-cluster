variable "subnet_addr_space" {
  description = "Address space of public subnet"
  type = list(string)
}

variable "rg_name" {
  description = "Name of resource group"
  type = string
}

variable "subnet_name" {
  description = "Name of subnet"
  type = string
}

variable "vnet_name" {
  description = "Name of vnet"
  type = string
}

variable "delegation_name" {
  description = "Name of delegation"
  type = string
  default = null
}

variable "service_delegation_name" {
  description = "Name of service delegation"
  type = string
  default = null
}

variable "service_delegation_actions" {
  description = "List of service delegation actions"
  type = list(string)
  default = null
}
