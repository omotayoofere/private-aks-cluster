variable "rg_name" {
  description = "Name of resource group"
  type = string
}

variable "api_server_subnet_id" {
  description = "ID of subnet for api server"
  type = string
}

variable "aks_nodes_subnet_id" {
  description = "ID of aks subnet"
  type = string
}

variable "aks_name" {
  description = "Name of AKS cluster"
  type = string
}

variable "rg_region" {
  description = "Location of resource group"
  type = string
}

variable "aks_identity_ids" {
  description = "IDs of user-assigned managed identities"
  type = list(string)
}

variable "username" {
  description = "ID of the client secret"
  type = string
}

variable "common_tags" {
  description = "Common tags for all module resources"
  type        = map(string)
}

variable "tenant_id" {
  description = "ID of the tenant"
  type = string
}

# variable "group_ids" {
#   description = "Common tags for all module resources"
#   type        = list(string)
# }