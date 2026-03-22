# Creates a user-assigned managed identity to be used by AKS workloads via Workload Identity

resource "azurerm_user_assigned_identity" "user_assigned_identity" {
  location            = var.rg_region
  name                = var.user_assigned_identity_name #Name of the managed identity
  resource_group_name = var.rg_name #Resource group containing the identity

  tags = var.common_tags
}

# Establishes an OIDC federated identity credential that allows a Kubernetes service account
# to authenticate to Azure as the specified user-assigned managed identity (AKS Workload Identity)
resource "azurerm_federated_identity_credential" "example" {

  name = azurerm_user_assigned_identity.user_assigned_identity.name
  parent_id = azurerm_user_assigned_identity.user_assigned_identity.id
  # resource_group_name = azurerm_user_assigned_identity.user_assigned_identity.resource_group_name
  audience = ["api://AzureADTokenExchange"] #Required audience for Azure AD token exchange
  issuer = var.cluster_oidc_issuer #"https://token.actions.githubusercontent.com". AKS OIDC issuer URL
  subject = "system:serviceaccount:${var.workload_sa_namespace}:${var.workload_sa_name}" #"repo:my-organization/my-repo:environment:prod". Kubernetes service account identity
}