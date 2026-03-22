variable "resource_name" {
  description = "Name of resource"
  type = string
}

variable "resource_repository" {
  description = "Name of resource repository"
  type = string
}

variable "resource_chart" {
  description = "resource chart"
  type = string
}

variable "resource_namespace" {
  description = "Namespace of resource"
  type = string
}

variable "resource_version" {
  description = "resource version"
  type = string
  default = ""
}

variable "create_namespace" {
  description = "resource version"
  type = bool
  default = true
}


variable "helm_sets" {
  description = "List of name/value pairs for Helm chart set blocks"
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "helm_sets_extra" {
  description = "List of name/value pairs for Helm chart set blocks"
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

# variable "list_of_modules" {
#   type = list(any)  # list of module/resource references
# }

variable "helm_values" {
  type    = list(string)
  default = []
}

