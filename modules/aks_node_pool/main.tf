resource "azurerm_kubernetes_cluster_node_pool" "aks_nodes" {
  name = var.node_pool_name
  vm_size    = "Standard_D2_v2" #spec of each VM
  kubernetes_cluster_id = var.aks_id
  zones = ["1", "3"]
  node_public_ip_enabled = false
  vnet_subnet_id = var.vnet_subnet_id
  node_taints = [
    "resource_intensive=true:NoSchedule"
  ]
  orchestrator_version = "1.34.0"
  os_disk_size_gb = "60"
  os_disk_type = "Managed"
  os_sku = "Ubuntu"
  node_labels = {
    "purpose" = "test"
    "type" = "custom_node_pool"
    "spec" = "neutral"
    "app" = "api"
    "app" = "webapi"
  }
  auto_scaling_enabled = true
  max_count = 4
  min_count = 2
  max_pods = 12


  upgrade_settings { #How upgrade is managed
    drain_timeout_in_minutes = 10 #amount of time to wait for all pods in node to get evicted before node terminates
    node_soak_duration_in_minutes = 5
    max_surge = "2" #amount of extra nodes that needs to be created to ensure the PDB rule is met
    undrainable_node_behavior = "Cordon" #keeps the node CordonED while it's waiting for upgrade
  }

  tags = var.common_tags  
}

