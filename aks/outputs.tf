output "aks_identity_principal_id" {
  value = module.aks_data.aks_identity_principal_id
}

output "aks_principal_id" {
  value = module.aks_data.aks_principal_id
}

output "aks_identity_ids" {
  value = module.aks_data.aks_identity_ids
}

output "aks_object_id" {
  value = module.aks_data.kubelet_identity_id
}

output "aks_cluster_name" {
  value = module.aks_data.aks_cluster_name
}

output "aks_cluster_fqdn" {
  value = module.aks_data.aks_cluster_fqdn
}

output "aks_oidc_issuer_url" {
  value = module.aks_data.aks_oidc_issuer_url
}

output "kube_config" {
  value = module.aks_data.kube_config
  sensitive = true
}

output "aks_rg" {
  value = module.aks_data.aks_rg
}