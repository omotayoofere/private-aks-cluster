output "kubelet_identity_id" {
  value = azurerm_kubernetes_cluster.k8s.id
}

output "aks_identity_id" {
  value = azurerm_kubernetes_cluster.k8s.id
}

output "aks_identity_principal_id" {
  value = azurerm_kubernetes_cluster.k8s.identity
}

output "aks_principal_id" {
  value = azurerm_kubernetes_cluster.k8s.identity[0].principal_id
}

output "aks_identity_ids" {
  value = azurerm_kubernetes_cluster.k8s.identity[0].identity_ids
}

output "aks_identity_client_id" {
  value = azurerm_kubernetes_cluster.k8s.workload_identity_enabled
}

output "aks_cluster_name" {
  value = azurerm_kubernetes_cluster.k8s.name
}

output "aks_cluster_fqdn" {
  value = azurerm_kubernetes_cluster.k8s.fqdn
}

output "aks_oidc_issuer_url" {
  value = azurerm_kubernetes_cluster.k8s.oidc_issuer_url
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.k8s.kube_config_raw
  sensitive = true
}

output "aks_rg" {
  value = azurerm_kubernetes_cluster.k8s.resource_group_name
}