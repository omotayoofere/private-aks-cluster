output "private_endpoint_resource_id" {
  value = azurerm_private_endpoint.endpoint_resource.id
}

output "private_dns_zone_id"  {
  value = azurerm_private_dns_zone.private_dns_zone_resource.id
}