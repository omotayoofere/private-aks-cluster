provider "azurerm" {
  features {}
  subscription_id = var.azure_sub_id
}

# Resource group to contain all resources
module "azure-rg" {
  source = "../modules/rg"
  rg_name = var.rg_name
  rg_region = var.rg_region
}

