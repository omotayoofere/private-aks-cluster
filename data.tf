data "azurerm_kubernetes_cluster" "credentials" {
  name = module.aks_data.aks_cluster_name
  resource_group_name = module.azure-rg.rg_name
  depends_on = [module.aks_data]
}

# data "http" "istio_addons" {
#   for_each = toset(local.istio_addons)

#   url = "https://raw.githubusercontent.com/istio/istio/release-${local.istio_version}/samples/addons/${each.key}.yaml"
# }

# data "local_file" "vpn_gateway_pubcert" {
#   filename = "/home/tayo/Documents/vpn_gateway/rootcert.cer"
# }