# Grants the specified Azure AD identity permissions to access keys and secrets in the Key Vault


resource "azurerm_key_vault_access_policy" "kv_policy" {
  key_vault_id = var.azure_key_vault_id #Target Key Vault resource ID
  tenant_id    = var.azure_tenant_id #Azure AD tenant ID
  object_id    = var.azure_user_object_id #Object ID of the identity being granted access

  key_permissions = var.key_permissions #Permissions for Key Vault keys (e.g., Get, WrapKey)

  secret_permissions = var.secret_permissions #Permissions for Key Vault secrets (e.g., Get, List)
}