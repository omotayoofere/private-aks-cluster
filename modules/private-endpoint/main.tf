# Create a private endpoint to allow private access to a resource (e.g., Key Vault, Storage)
resource "azurerm_private_endpoint" "endpoint_resource" {
  name = var.endpoint_resource_name
  location = var.location
  resource_group_name = var.resource_group_name
  subnet_id = var.endpoint_subnet_id #subnet of the resource (VMs) that wants to connect to Azure resource via private endpoint

  private_service_connection {
    name = "${var.endpoint_resource_name}-privateserviceconnection"
    private_connection_resource_id = var.private_resource_id #ID of the resource being connected to privately i.e. Azure Key vault
    subresource_names = var.subresource_names#[registry, vault"]
    is_manual_connection = false
  }

  private_dns_zone_group { #private DNS zone for DNS resolution
    name = "${var.endpoint_resource_name}-dns-zone-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.private_dns_zone_resource.id]
  }
}

# Create a Private DNS Zone for the Azure resource to resolve via private endpoint
resource "azurerm_private_dns_zone" "private_dns_zone_resource" {
  name = var.private_dns_zone_resource_name
  resource_group_name = var.resource_group_name
}

# Link the private DNS zone to the virtual network so VMs can resolve private endpoint addresses
resource "azurerm_private_dns_zone_virtual_network_link" "example" {
  name = "${var.private_resource_name}-virtual-network-link"
  resource_group_name = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone_resource.name
  virtual_network_id = var.virtual_network_id
}