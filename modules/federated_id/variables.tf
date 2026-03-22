variable "rg_name" {
  description = "Name of resource group"
  type = string
}

variable "user_assigned_identity_name" {
  description = "Name of AKS cluster"
  type = string
}

variable "rg_region" {
  description = "Location of resource group"
  type = string
}

variable "common_tags" {
  description = "Common tags for all module resources"
  type        = map(string)
}

variable "cluster_oidc_issuer" {
  description = "AKS cluster issuer"
  type = string
}

variable "workload_sa_namespace" {
  description = "App registration subject"
  type = string
}

variable "workload_sa_name" {
  description = "Name of app registration"
  type = string
}
