provider "azurerm" {
  features {}
  subscription_id = var.azure_sub_id
}

# Creates an Azure Container Registry
module "acr_module" {
  source = "../modules/acr"
  rg_name = data.terraform_remote_state.rg.outputs.rg_name
  rg_region = data.terraform_remote_state.rg.outputs.rg_region
  acr_name = var.acr_name
}

# Private Endpoint for secure access to ACR resource
module "acr_private_endpoint" {
  source = "../modules/private-endpoint"
  subresource_names = ["registry"]
  resource_group_name = data.terraform_remote_state.rg.outputs.rg_name
  location = data.terraform_remote_state.rg.outputs.rg_region
  private_resource_name  = var.acr_private_resource_name
  endpoint_resource_name = var.acr_endpoint_resource_name
  virtual_network_id = data.terraform_remote_state.networking.outputs.aks_VNET_id
  private_resource_id = module.acr_module.acr_id
  endpoint_subnet_id = data.terraform_remote_state.networking.outputs.aks_nodes_subnet_id
  private_dns_zone_resource_name = "privatelink.azurecr.io"
}

# Creates an Azure Key Vault
module "akv" {
  source = "../modules/akv"
  rg_name = data.terraform_remote_state.rg.outputs.rg_name
  rg_region = data.terraform_remote_state.rg.outputs.rg_region
  cluster_name = var.cluster_name
}

# Private Endpoint for secure access to AKV resource
module "akv_private_endpoint" {
  source = "../modules/private-endpoint"
  subresource_names = ["vault"]
  resource_group_name = data.terraform_remote_state.rg.outputs.rg_name
  location = data.terraform_remote_state.rg.outputs.rg_region
  private_resource_name  = var.akv_private_resource_name
  endpoint_resource_name = var.akv_endpoint_resource_name
  virtual_network_id = data.terraform_remote_state.networking.outputs.aks_VNET_id
  private_resource_id = module.akv.akv_id
  endpoint_subnet_id = data.terraform_remote_state.networking.outputs.aks_nodes_subnet_id
  private_dns_zone_resource_name = "privatelink.vaultcore.azure.net"
}

# Creates a federated user-assigned managed identity for the Azure key vault
module "emart_akv_user_assigned_id" {
  source = "../modules/federated_id"
  rg_name = data.terraform_remote_state.rg.outputs.rg_name
  rg_region = data.terraform_remote_state.rg.outputs.rg_region
  user_assigned_identity_name = var.emart_akv_user_assigned_identity_name
  workload_sa_namespace = var.emart_akv_workload_sa_namespace
  cluster_oidc_issuer = data.terraform_remote_state.aks.outputs.aks_oidc_issuer_url
  workload_sa_name = var.emart_akv_workload_sa_name
  common_tags = merge(
    local.common_tags
  )
}

# Grants the federated identity permissions in the key vault
# The ID of the Managed Identity would then be annotated with the k8s service account
module "emart_aks_access_policy" {
  source = "../modules/akv_access_policy"
  azure_key_vault_id = module.akv.akv_id
  secret_permissions = ["Get", "List"]
  azure_tenant_id = var.tenant_id
  azure_user_object_id = module.emart_akv_user_assigned_id.user_assigned_principal_id
}

#Creates a federated user-assigned managed identity to assign to SecretProviderClass
module "cert_user_assigned_id" {
  source = "../modules/federated_id"
  rg_name = data.terraform_remote_state.rg.outputs.rg_name
  rg_region = data.terraform_remote_state.rg.outputs.rg_region
  user_assigned_identity_name = var.dns_user_assigned_identity_name
  workload_sa_namespace = var.cert_workload_sa_namespace
  cluster_oidc_issuer = data.terraform_remote_state.aks.outputs.aks_oidc_issuer_url
  workload_sa_name = var.cert_workload_sa_name
  common_tags = merge(
    local.common_tags
  )
}

# Assigns the DNS Zone Contributor role to the user assigned managed identity. This would then be annotated with the service account 
# created for the purpose of modifying DNS zone records
module "aks_dns_cert_role" {
  source = "../modules/roles"
  role_definition_name = "DNS Zone Contributor"
  principal_id = module.cert_user_assigned_id.user_assigned_principal_id
  resource_id = var.dns_zone_id
}

# Optional
# Grants permissions for the current user to perform operations on the keyvault components 
module "current_user_policy" {
  source = "../modules/akv_access_policy"
  azure_key_vault_id = module.akv.akv_id
  azure_tenant_id = var.tenant_id
  key_permissions = ["Get", "List", "Backup", "Delete", "Purge", "Recover", "Restore", "Create"]
  azure_user_object_id = var.current_user_id
  secret_permissions = ["Get", "List", "Backup", "Delete", "Purge", "Recover", "Restore", "Set"]
}

# Grants the user assigned managed identity of the AKS cluster the role to pull images from the ACR initially created
module "aks_acr_pull_role" {
  source = "../modules/roles"
  depends_on = [module.acr_module]
  role_definition_name = var.role_definition_name
  principal_id = data.terraform_remote_state.base.outputs.user_assigned_aks_principal_id
  resource_id = module.acr_module.acr_id
}

# Grants the user assigned managed identity of the AKS cluster the Network contributor role to perform networking functions in the deployed resource group
module "aks_aks_rg_role" {
  source = "../modules/roles"
  role_definition_name = var.aks_aks_rg_role_name
  principal_id = data.terraform_remote_state.base.outputs.user_assigned_aks_principal_id
  resource_id = data.terraform_remote_state.base.outputs.rg_id
}

