#Defines a Azure Contasiner Registry (ACR) including its SKU


resource "azurerm_container_registry" "acr" {
  name     = "${var.acr_name}acr"
  resource_group_name   = var.rg_name
  location = var.rg_region
  sku                 = "Premium"
  admin_enabled       = false

#   georeplications { #This is for redundancy
#     location                = "East US"
#     zone_redundancy_enabled = true
#     tags                    = {}
#   }
#   georeplications {
#     location                = "North Europe"
#     zone_redundancy_enabled = true
#     tags                    = {}
#   }
}
