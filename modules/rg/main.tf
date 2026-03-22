# Creates a resource group to contain cluster and related network resources

resource "azurerm_resource_group" "rg" {
  name     = var.rg_name # Resource group name tied to cluster
  location = var.rg_region # Region where resources will be deployed
}


