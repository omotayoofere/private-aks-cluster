provider "azurerm" {
  features {}
  subscription_id = var.azure_sub_id
}

#Creates AKS cluster
module "aks_data" {
  source = "../modules/aks_data"
  rg_name = data.terraform_remote_state.rg.outputs.rg_name
  rg_region = data.terraform_remote_state.rg.outputs.rg_region
  api_server_subnet_id = data.terraform_remote_state.networking.outputs.api_server_subnet_id
  aks_nodes_subnet_id  = data.terraform_remote_state.networking.outputs.aks_nodes_subnet_id
  aks_identity_ids = [data.terraform_remote_state.base.outputs.user_assigned_aks_id]
  aks_name = "${var.aks_name}-${terraform.workspace}"
  common_tags = merge(
    local.common_tags
  )
  # node_count = var.node_count
  username  = var.username
  # group_ids = var.group_ids
  tenant_id = var.tenant_id
}

#Creates a different node pool aside the default one
module "aks_node_group_1" {
  source = "../modules/aks_node_pool"
  vnet_subnet_id = data.terraform_remote_state.networking.outputs.aks_nodes_subnet_id
  node_pool_name = var.node_pool_name
  aks_id = module.aks_data.aks_identity_id
  common_tags = merge(
    local.common_tags
  )
}