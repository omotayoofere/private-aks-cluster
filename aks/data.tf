data "terraform_remote_state" "base" {
  backend = "local"

  config = {
    path = "../base/terraform.tfstate"
  }
}

data "terraform_remote_state" "rg" {
  backend = "local"

  config = {
    path = "../rg/terraform.tfstate"
  }
}

data "terraform_remote_state" "networking" {
  backend = "local"

  config = {
    path = "../networking/terraform.tfstate"
  }
}

# data "azurerm_kubernetes_cluster" "credentials" {
#   name = module.aks_data.aks_cluster_name
#   resource_group_name = data.terraform_remote_state.base.outputs.rg_name
# }