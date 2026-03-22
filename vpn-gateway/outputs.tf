output "vpn_gateway_public_ip_id" {
  value = module.vpn_gateway_public_ip.ip_address_id
}

output "vpn_gateway_public_ip" {
  value = module.vpn_gateway_public_ip.ip_address
}

output "vnet_gateway_id" {
  value = module.vnet_gateway.vnet_gateway_id
}
