provider "azurerm" {
  features {}
  subscription_id = var.azure_sub_id
}

module "install_istio_base" {
  source = "../modules/helm"
  # count = var.enable_ingress ? 1 : 0
  # depends_on = [data.azurerm_kubernetes_cluster.credentials]
  resource_chart = "base"
  resource_name = "istio-base"
  resource_namespace = "istio-system"
  resource_repository = "https://istio-release.storage.googleapis.com/charts"
  resource_version = "1.28.2"
  # list_of_modules = [module.aks_data]
}

module "install_istiod" {
  source = "../modules/helm"
  # count = var.enable_ingress ? 1 : 0
  # depends_on = [data.azurerm_kubernetes_cluster.credentials]
  resource_chart = "istiod"
  resource_name = "istiod"
  resource_namespace  = "istio-system"
  resource_repository = "https://istio-release.storage.googleapis.com/charts"
  resource_version = "1.28.2"
  # list_of_modules = [module.aks_data]
}

##############################
##############################
module "install_argocd" {
  source = "../modules/helm"
  # count = var.enable_ingress ? 1 : 0
  # depends_on = [data.azurerm_kubernetes_cluster.credentials]
  resource_chart = var.argocd_resource_chart
  resource_name = var.argocd_resource_name
  resource_namespace = var.argocd_resource_namespace
  resource_repository = var.argocd_resource_repository
  resource_version = var.argocd_resource_version
  # list_of_modules = [module.aks_data]
  helm_sets = concat(
    var.argocd_sets,
    [
      {
        name  = "configs.cm.url"
        value = "https://argocd.xlice.com.ng"
      },
      {
        name  = "configs.params.server.insecure"
        value = "true"
      }
    ]
  )
}

module "install_cert_manager" {
  source = "../modules/helm"
  # count = var.enable_ingress ? 1 : 0
  # depends_on = [data.azurerm_kubernetes_cluster.credentials]
  resource_chart = var.cert_manager_resource_chart
  resource_name = var.cert_manager_resource_name
  resource_namespace = var.cert_manager_resource_namespace
  resource_repository = var.cert_manager_resource_repository
  resource_version = var.cert_manager_resource_version
  # list_of_modules = [module.aks_data]
  helm_values = [
    yamlencode({
      podLabels = {
        "azure.workload.identity/use" = "true"
        "azure.workload.identity/client-id" = data.terraform_remote_state.addons.outputs.cert_user_assigned_client_id
      }
    })
  ]

  helm_sets = concat(
    var.argocd_sets,
    [
      {
        name = "serviceAccount.annotations.azure\\.workload\\.identity/client-id"
        value = data.terraform_remote_state.addons.outputs.cert_user_assigned_client_id
      },
      {
        name = "serviceAccount.annotations.azure\\.workload\\.identity/use"
        value = "true"
      },
      {
        name = "serviceAccount.name"
        value = "cert-manager-sa"
      }
    ]
  )
}

# module "install_azure_csi_secret_store" {
#   source = "../modules/helm"

#   count               = var.enable_ingress ? 1 : 0
#   depends_on          = [data.azurerm_kubernetes_cluster.credentials]
#   resource_chart      = var.csi_secret_store_resource_chart
#   resource_name       = var.csi_secret_store_resource_name
#   resource_namespace  = var.csi_secret_store_resource_namespace
#   resource_repository = var.csi_secret_store_resource_repository
#   create_namespace    = var.csi_secret_store_create_namespace
#   resource_version    = "1.7.2"
#   list_of_modules     = [module.aks_data]
#   helm_sets           = concat(var.argocd_sets)
# }

module "emart_ns" {
  source = "../modules/namespace"
  # count = var.enable_ingress ? 1 : 0
  resource_namespace = "emart-app"
}

module "emart_sa" {
  source = "../modules/k8s_sa"
  # count = var.enable_ingress ? 1 : 0
  depends_on = [module.emart_ns]
  client_id = data.terraform_remote_state.addons.outputs.emart_akv_user_assigned_client_id
  service_account_namespace = "emart-app"
  service_account_name = "emart-akv-sa"
}