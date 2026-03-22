data "terraform_remote_state" "base" {
  backend = "local"

  config = {
    path = "../base/terraform.tfstate"
  }
}

data "terraform_remote_state" "aks" {
  backend = "local"

  config = {
    path = "../aks/terraform.tfstate"
  }
}

data "terraform_remote_state" "addons" {
  backend = "local"

  config = {
    path = "../addons/terraform.tfstate"
  }
}

data "azurerm_kubernetes_cluster" "credentials" {
  name = data.terraform_remote_state.aks.outputs.aks_cluster_name
  resource_group_name = data.terraform_remote_state.aks.outputs.aks_rg
}