resource "kubernetes_service_account_v1" "this" {
  metadata {
    name = var.service_account_name
    namespace = var.service_account_namespace

    labels = {
      name = var.service_account_name
    }

    annotations = {
      "azure.workload.identity/client-id" = var.client_id
      "azure.workload.identity/use" = "true"
    }
  }
}