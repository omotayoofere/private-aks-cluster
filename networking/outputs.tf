output "aks_VNET_id" {
  value = module.aks_VNET.vnet_id
}

output "aks_VNET_name" {
  value = module.aks_VNET.vnet_name
}

output "vnet_gateway_subnet_id" {
  value = module.vnet_gateway_subnet.subnet_id
}

output "vnet_gateway_subnet_name" {
  value = module.vnet_gateway_subnet.subnet_name
}

output "api_server_subnet_id" {
  value = module.api_server_subnet.subnet_id
}

output "api_server_subnet_name" {
  value = module.api_server_subnet.subnet_name
}

output "aks-nodes-sec-group_id" {
  value = module.aks-nodes-sec-group.nsg_id
}

output "aks-nodes-sec-group-rule" {
  value = module.aks-nodes-sec-group.nsg_rule
}

output "aks_nodes_subnet_id" {
  value = module.aks_nodes_subnet.subnet_id
}

output "aks_nodes_subnet_name" {
  value = module.aks_nodes_subnet.subnet_name
}

output "nat_ip_id" {
  value = module.nat_public_ip.ip_address_id
}

output "nat_ip" {
  value = module.nat_public_ip.ip_address
}

output "nat_id" {
  value = module.nat_gateway.nat_id
}