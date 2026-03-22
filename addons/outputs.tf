output "acr_id" {
  value = module.acr_module.acr_id
}

output "akv_id" {
  value = module.akv.akv_id
}

output "cert_user_assigned_client_id" {
    value = module.cert_user_assigned_id.user_assigned_client_id
}

output "emart_akv_user_assigned_client_id" {
    value = module.emart_akv_user_assigned_id.user_assigned_client_id
}