variable "azure_sub_id" {
  description = "ID of azure subscription"
  type        = string
}

variable "rg_name" {
  description = "Name of resource group"
  type        = string
}

variable "rg_region" {
  description = "Location of resource group"
  type        = string
}

variable "cluster_name" {
  description = "Name of the cluster"
  type        = string
}

variable "aks_user_assigned_identity_name" {
  description = "Name of the AKS user assigned managed identity"
  type        = string
}

variable "common_tags" {
  description = "Common tag for all resources"
  type        = map(string)
  default = {
    Owner   = "Emart-group"
    Project = "Emart"
    CSP     = "Azure"
  }
}