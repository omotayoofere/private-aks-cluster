resource "azurerm_key_vault" "akv" {
  location = var.rg_region
  name = "${var.cluster_name}-aks" #Key Vault name associated with the AKS cluster
  resource_group_name = var.rg_name 
  tenant_id = data.azurerm_client_config.current.tenant_id #Azure AD tenant for the Key Vault
  sku_name = "premium" #Premium SKU required for HSM-backed keys
  soft_delete_retention_days = 7 #Retain deleted vault data for recovery
}

