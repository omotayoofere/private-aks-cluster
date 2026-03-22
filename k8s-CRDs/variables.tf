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

# variable "enable_ingress" {
#   type    = bool
#   default = false
# }

variable "argocd_resource_name" {
  description = "Name of resource"
  type        = string
}

variable "argocd_resource_repository" {
  description = "Name of resource repository"
  type        = string
}

variable "argocd_resource_chart" {
  description = "resource chart"
  type        = string
}

variable "argocd_resource_namespace" {
  description = "Namespace of resource"
  type        = string
}

variable "argocd_resource_version" {
  description = "resource version"
  type        = string
}

variable "argocd_sets" {
  description = "List of name/value pairs for Helm chart set blocks"
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "cert_manager_resource_name" {
  description = "Name of resource"
  type        = string
}

variable "cert_manager_resource_repository" {
  description = "Name of resource repository"
  type        = string
}

variable "cert_manager_resource_chart" {
  description = "resource chart"
  type        = string
}

variable "cert_manager_resource_namespace" {
  description = "Namespace of resource"
  type        = string
}

variable "cert_manager_resource_version" {
  description = "resource version"
  type        = string
}