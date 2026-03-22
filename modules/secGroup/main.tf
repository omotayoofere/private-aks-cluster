# Creates a Network Security Group (NSG) to define inbound and outbound security rules for subnets

resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name
  location              = var.rg_region
  resource_group_name   = var.rg_name

  tags = var.tags
}

# Defines individual security rules within the NSG
# Iterates over var.sec_rules to create multiple rules (allow/deny, ports, IPs)
resource "azurerm_network_security_rule" "example" {
  for_each = var.sec_rules

  name                        = each.value.name
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  resource_group_name         = var.rg_name
  network_security_group_name = azurerm_network_security_group.nsg.name  

}

# Associates the NSG with a specific subnet to enforce the defined security rules
resource "azurerm_subnet_network_security_group_association" "public-subnet-nsg-assoc" {
  subnet_id                 = var.public_subnet_id
  network_security_group_id = azurerm_network_security_group.nsg.id
}