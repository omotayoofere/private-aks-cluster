variable "key_permissions" {
  description = "Name of the cluster"
  type = list(string)
  default = []
}

variable "secret_permissions" {
  description = "Name of resource group"
  type = list(string)
  default = []
}

variable "azure_key_vault_id" {
  description = "ID of the Azure Key vault"
  type = string
}

variable "azure_tenant_id" {
  description = "ID of Azure tenant"
  type = string
}

variable "azure_user_object_id" {
  description = "ID of the user object"
  type = string
}

