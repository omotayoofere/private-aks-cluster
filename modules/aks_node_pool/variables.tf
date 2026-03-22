variable "node_pool_name" {
  type = string
}

variable "aks_id" {
  type = string
}

variable "vnet_subnet_id" {
  description = "Location of resource group"
  type = string
}

variable "common_tags" {
  description = "Common tags for all module resources"
  type        = map(string)
}