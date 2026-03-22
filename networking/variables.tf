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

variable "cluster_name" {
  description = "Name of the cluster"
  type = string
}

variable "vnet_addr_space" {
  type = list(string)
}

variable "jump_host_subnet_name" {
  description = "Name of jump host's subnet"
  type = string
}

variable "jump_host_subnet_addr_space" {
  description = "Address space of jump host's subnet"
  type = list(string)
}

variable "jump_host_sec_rules" {
  type = map(object({
    name = string
    priority = number
    direction = optional(string, "Inbound")
    access = optional(string, "Deny")
    protocol = optional(string, "*")
    source_port_range = optional(string, "*")
    destination_port_range = optional(string, "*")
    source_address_prefix = optional(string, "*")
    destination_address_prefix = optional(string, "*")  
  }))
}

variable "jump_host_nsg_name" {
  description = "Name of the NSG"
  type = string
}

variable "api_server_subnet_name" {
  description = "Name of API server subnet"
  type = string
}

variable "api_server_subnet_addr_space" {
  description = "Address space of API server's subnet"
  type = list(string)
}

variable "api_server_subnet_delegation_name" {
  description = "Name of delegation"
  type = string
  default = null
}

variable "api_server_subnet_service_delegation_name" {
  description = "Name of service delegation"
  type = string
  default = null
}

variable "api_server_subnet_delegation_actions" {
  description = "List of service delegation actions"
  type = list(string)
  default = null
}

variable "aks_aks_rg_role_name" {
  description = "Name of the role"
  type = string
}

variable "aks_nodes_subnet_name" {
  description = "Name of AKS node's subnet"
  type = string
}

variable "aks_nodes_subnet_addr_space" {
  description = "Address space of AKS node's  subnet"
  type = list(string)
}

variable "nat_ip_name" {
  description = "Name of the IP"
  type = string
}

variable "aks_nodes_sec_rules" {
  type = map(object({
    name = string
    priority = number
    direction = optional(string, "Inbound")
    access = optional(string, "Deny")
    protocol = optional(string, "*")
    source_port_range = optional(string, "*")
    destination_port_range = optional(string, "*")
    source_address_prefix = optional(string, "*")
    destination_address_prefix = optional(string, "*") 
  }))
}

variable "aks_node_nsg_name" {
  description = "Name of the NSG"
  type = string
}

variable "vpn_gateway_address_space" {
  type = list(string)
}

variable "vpn_gateway_subnet_name" {
  type = string
}