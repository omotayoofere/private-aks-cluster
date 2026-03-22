# Create a NAT Gateway for outbound internet connectivity from private subnets

resource "azurerm_nat_gateway" "nat_gw" {
  name                = var.subnet_name #Name of the NAT Gateway (usually tied to subnet)
  location            = var.rg_region
  resource_group_name = var.rg_name
  sku_name            = "Standard" #Standard SKU for higher throughput and zone redundancy
}

# Associate the NAT Gateway with a public IP
resource "azurerm_nat_gateway_public_ip_association" "nat_pip_association" {
  nat_gateway_id       = azurerm_nat_gateway.nat_gw.id
  public_ip_address_id = var.nat_public_ip #Public IP to use for outbound connections
}

# Associate the NAT Gateway with a subnet
resource "azurerm_subnet_nat_gateway_association" "example" {
  subnet_id      = var.subnet_id
  nat_gateway_id = azurerm_nat_gateway.nat_gw.id
}
