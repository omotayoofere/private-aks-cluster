provider "azurerm" {
  features {}
  subscription_id = var.azure_sub_id
}

module "vpn_gateway_public_ip" {
  source = "../modules/publicIp"
  ip_name = var.vpn_gateway_public_ip_name
  rg_region = data.terraform_remote_state.rg.outputs.rg_region
  rg_name = data.terraform_remote_state.rg.outputs.rg_name
  pip_zones = var.vpn_gateway_pip_zones
  tags = merge(
    local.common_tags
  )
}

module "vnet_gateway" {
  source = "../modules/virtual_network_gateway"
  vpn_client_address_space = var.vpn_client_address_space
  resource_group_name = data.terraform_remote_state.rg.outputs.rg_name
  location = data.terraform_remote_state.base.outputs.rg_region
  vpn_gateway_subnet_id = data.terraform_remote_state.networking.outputs.vnet_gateway_subnet_id
  vnet_gateway_name = data.terraform_remote_state.networking.outputs.vnet_gateway_subnet_name
  vpn_gateway_pip_id = module.vpn_gateway_public_ip.ip_address_id
  tenant_id = var.tenant_id
}