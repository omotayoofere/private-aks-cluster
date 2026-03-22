resource "kubernetes_namespace_v1" "example" {
  metadata {
    annotations = {
      name = var.resource_namespace
    }

    labels = {
      mylabel = var.resource_namespace
    }

    name = var.resource_namespace
  }
}