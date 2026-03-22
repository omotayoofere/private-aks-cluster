output "nsg_id" {
  value = azurerm_network_security_group.nsg.id
}

output "nsg_rule" {
  value = azurerm_network_security_group.nsg.security_rule
}