# Creates a user-assigned managed identity for use by AKS workloads or other resources
# Decoupled from AKS cluster lifecycle, reusable across workloads

resource "azurerm_user_assigned_identity" "user_assigned_identity" {
  location            = var.rg_region
  name                = var.user_assigned_identity_name 
  resource_group_name = var.rg_name

  tags = var.common_tags
}
