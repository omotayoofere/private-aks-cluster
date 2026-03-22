# Creates a subnet within a virtual network
# Optional delegation allows services like AKS or Azure SQL to manage subnet resources

resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = var.rg_name
  virtual_network_name = var.vnet_name
  address_prefixes     = var.subnet_addr_space

  dynamic "delegation" {
    for_each = var.delegation_name == null ? [] : [1]
    content {
      name = var.delegation_name

      service_delegation {
        name = var.service_delegation_name
        actions = var.service_delegation_actions
      }      
    }
  }
}