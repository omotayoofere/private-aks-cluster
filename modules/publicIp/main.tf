# Creates a static, standard SKU public IP for exposing resources (e.g., AKS load balancer, NAT Gateway)

resource "azurerm_public_ip" "public_ip" {
  name = var.ip_name
  location = var.rg_region
  resource_group_name = var.rg_name
  allocation_method = "Static" # Ensures IP does not change over time
  sku = "Standard" # Standard SKU for zone-redundancy and 
  zones = var.pip_zones

  tags = var.tags
}