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
