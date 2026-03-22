variable "common_tags" {
  description = "Common tag for all resources"
  type        = map(string)
  default = {
    Owner   = "Emart-group"
    Project = "Emart"
    CSP     = "Azure"
  }
}

variable "azure_sub_id" {
  description = "ID of azure subscription"
  type        = string
}

variable "aks_name" {
  description = "Name of AKS cluster"
  type        = string
}

variable "username" {
  description = "ID of the client secret"
  type        = string
}

variable "tenant_id" {
  description = "ID of the tenant"
  type        = string
}

# variable "group_ids" {
#   description = "Common tags for all module resources"
#   type        = list(string)
# }

variable "node_pool_name" {
  type = string
}