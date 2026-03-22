resource "helm_release" "custom_resource" {
  name = var.resource_name
  repository = var.resource_repository
  chart = var.resource_chart
  namespace = var.resource_namespace
  create_namespace = var.create_namespace
  version = var.resource_version
  cleanup_on_fail = true

  timeout = 600  # Increase from default 300 seconds
  wait = true

  force_update = true
  
  atomic = true      # Rollback if fails

  values = var.helm_values

  set = concat(
    [ for s in var.helm_sets : 
      {
        name  = s.name
        value = s.value
      }
    ],
    var.helm_sets_extra
  )
}
