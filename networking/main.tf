provider "azurerm" {
  features {}
  subscription_id = var.azure_sub_id
}

# Creates VNET
module "aks_VNET" {
  source = "../modules/vnet"
  vnet_addr_space = var.vnet_addr_space
  cluster_name = var.cluster_name
  rg_name = data.terraform_remote_state.rg.outputs.rg_name
  rg_region = data.terraform_remote_state.rg.outputs.rg_region
}

# Subnet creation with optional service delegation
module "vnet_gateway_subnet" {
  source = "../modules/subnet"
  rg_name = data.terraform_remote_state.rg.outputs.rg_name
  subnet_addr_space = var.vpn_gateway_address_space
  subnet_name = var.vpn_gateway_subnet_name
  vnet_name = module.aks_VNET.vnet_name
}

# Subnet creation with optional service delegation
module "api_server_subnet" {
  source = "../modules/subnet"
  rg_name = data.terraform_remote_state.rg.outputs.rg_name
  subnet_addr_space = var.api_server_subnet_addr_space
  subnet_name = var.api_server_subnet_name
  vnet_name = module.aks_VNET.vnet_name
  delegation_name = var.api_server_subnet_delegation_name
  service_delegation_name = var.api_server_subnet_service_delegation_name
  service_delegation_actions = var.api_server_subnet_delegation_actions
}

# Assigning the Network Contributor role to the subnet of the api-server
module "api_server_contrib_role" {
  source = "../modules/roles"
  # depends_on = [module.aks_data]
  role_definition_name = var.aks_aks_rg_role_name
  principal_id = data.terraform_remote_state.base.outputs.user_assigned_aks_principal_id
  resource_id = module.api_server_subnet.subnet_id
}

# Subnet creation with optional service delegation
module "aks_nodes_subnet" {
  source = "../modules/subnet"
  rg_name = data.terraform_remote_state.rg.outputs.rg_name
  subnet_addr_space = var.aks_nodes_subnet_addr_space
  subnet_name = var.aks_nodes_subnet_name
  vnet_name = module.aks_VNET.vnet_name
}

# Assigning the Network Contributor role to the subnet of the aks-nodes
module "aks_nodes_contrib_role" {
  source = "../modules/roles"
  # depends_on = [module.aks_data]
  role_definition_name = var.aks_aks_rg_role_name
  principal_id = data.terraform_remote_state.base.outputs.user_assigned_aks_principal_id
  resource_id = module.aks_nodes_subnet.subnet_id
}

# Creates the public IP to be assigned to the NAT
module "nat_public_ip" {
  source = "../modules/publicIp"
  ip_name = var.nat_ip_name
  rg_region = data.terraform_remote_state.rg.outputs.rg_region
  rg_name = data.terraform_remote_state.rg.outputs.rg_name
  tags = merge(
    local.common_tags
  )
}

# Creates NAT Gateway for outbound internet connection for aks_node_subnet and jump_host subnet
module "nat_gateway" {
  source = "../modules/nat"
  depends_on = [module.nat_public_ip, module.aks_nodes_subnet]
  rg_name = data.terraform_remote_state.rg.outputs.rg_name
  rg_region = data.terraform_remote_state.rg.outputs.rg_region
  vnet_name = module.aks_VNET.vnet_name
  subnet_id = module.aks_nodes_subnet.subnet_id
  subnet_name = module.aks_nodes_subnet.subnet_name
  nat_public_ip = module.nat_public_ip.ip_address_id
}

module "aks-nodes-sec-group" {
  source = "../modules/secGroup"
  rg_name = data.terraform_remote_state.rg.outputs.rg_name
  rg_region = data.terraform_remote_state.rg.outputs.rg_region
  public_subnet_id = module.aks_nodes_subnet.subnet_id
  nsg_name = var.aks_node_nsg_name
  sec_rules = var.aks_nodes_sec_rules
  tags = merge(
    local.common_tags
  )
} 