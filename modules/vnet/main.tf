# Creates an Azure Virtual Network (VNet) to contain subnets, VMs, and gateways

resource "azurerm_virtual_network" "az_vnet" {
  name                = "${var.cluster_name}-vnet"
  location            = var.rg_region
  resource_group_name = var.rg_name
  address_space       = var.vnet_addr_space # CIDR range for the VNet
}
