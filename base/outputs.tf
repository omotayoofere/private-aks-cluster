output "user_assigned_aks_principal_id" {
  # value = azurerm_user_assigned_identity.user_assigned_identity.principal_id
  value = module.user_assigned_id.user_assigned_principal_id
}

output "user_assigned_aks_id" {
  # value = azurerm_user_assigned_identity.user_assigned_identity.id
  value = module.user_assigned_id.user_assigned_identity_id
}

output "user_assigned_aks_client_id" {
  # value = azurerm_user_assigned_identity.user_assigned_identity.client_id
  value = module.user_assigned_id.user_assigned_client_id
}