provider "azurerm" {
  features {}
  subscription_id = var.azure_sub_id
}

#Creates a user-assigned identity for the AKS cluster
module "user_assigned_id" {
  source = "../modules/user_assigned_id"
  rg_name = data.terraform_remote_state.rg.outputs.rg_name
  rg_region = data.terraform_remote_state.rg.outputs.rg_region
  user_assigned_identity_name = var.aks_user_assigned_identity_name
  common_tags = merge(
    local.common_tags
  )
}