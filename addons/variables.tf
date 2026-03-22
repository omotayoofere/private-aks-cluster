variable "acr_name" {
  description = "Name of the acr"
  type        = string
}

variable "azure_sub_id" {
  description = "ID of azure subscription"
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

variable "akv_endpoint_resource_name" {
  type = string
}

variable "acr_endpoint_resource_name" {
  type = string
}

variable "akv_private_resource_name" {
  type = string
}

variable "acr_private_resource_name" {
  type = string
}

variable "cluster_name" {
  description = "Name of the cluster"
  type        = string
}

variable "emart_akv_workload_sa_namespace" {
  description = "cluster namespace for user assigned managed identity"
  type        = string
}

variable "emart_akv_workload_sa_name" {
  description = "cluster name for user assigned managed identity"
  type        = string
}

variable "emart_akv_user_assigned_identity_name" {
  description = "Name of user assigned managed identity"
  type = string
}

variable "dns_zone_id" {
  description = "ID of the DNS zone"
  type        = string
}

variable "dns_user_assigned_identity_name" {
  description = "Name of user assigned managed identity"
  type        = string
}

variable "cert_workload_sa_namespace" {
  description = "cluster namespace for user assigned managed identity"
  type        = string
}

variable "cert_workload_sa_name" {
  description = "cluster name for user assigned managed identity"
  type        = string
}

variable "current_user_id" {
  description = "ID of the current user"
  type = string
}

variable "tenant_id" {
  description = "ID of the tenant"
  type        = string
}

variable "role_definition_name" {
  description = "Name of the role"
  type        = string
}

variable "aks_aks_rg_role_name" {
  description = "Name of the role"
  type        = string
}