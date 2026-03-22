# Assigns a role (e.g., Contributor, Reader) to a principal on a specific Azure resource
# skip_service_principal_aad_check is set to true for service principals that may not yet exist in AAD

resource "azurerm_role_assignment" "resources" {
  principal_id = var.principal_id
  role_definition_name = var.role_definition_name #Role to assign
  scope = var.resource_id #Target resource or resource group
  skip_service_principal_aad_check = true
}