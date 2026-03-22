#Defines an Azure Kubernetes Service (AKS) cluster, including its name, 
#Node pool settings (size, SKU, auto_scaling, node access)
#Managed Identity configuration
#Network settings (Outbound configuration, NAT settings)


resource "azurerm_kubernetes_cluster" "k8s" {
  name = var.aks_name #cluster name
  location = var.rg_region #cluster locatiom                            
  resource_group_name = var.rg_name #cluster resource group
  dns_prefix = "test"
  azure_policy_enabled = true #Determines if Azure cloud policy on AKS is enabled
  
  kubernetes_version = "1.34.0" #control plane version
  sku_tier = "Premium" #SKU tier
  oidc_issuer_enabled = true #Lets AKS issue trusted identity tokens
  workload_identity_enabled = true #Lets pods use Azure Managed Identity
  private_cluster_enabled = true #Determines if control pane components can be accessed via public internet

  key_vault_secrets_provider { #This enables the Azure Secret store CSI driver in the cluster
    secret_rotation_enabled = "true" #true if the secret store csi driver is enabled in AKS
    secret_rotation_interval = "1m" 
  }

  api_server_access_profile {
    virtual_network_integration_enabled = "true" #Integrates the api server with a VNET
    subnet_id = var.api_server_subnet_id #subnet ID of the subnet to house the api server
  }

  # role_based_access_control_enabled = true #Limits access to the cluster to designated roles
  # azure_active_directory_role_based_access_control {
  #   tenant_id = var.tenant_id
  #   admin_group_object_ids = var.group_ids #IDs of the group of users that can access the cluster
  #   azure_rbac_enabled = true
  # }

  #Controls how the resource is maintained
  # lifecycle {
  #   create_before_destroy = true
  # }

  #Determines the identity of the cluster - UserAssigned or SystemAssigned
  identity {
    type = "UserAssigned"
    identity_ids = var.aks_identity_ids #ID of the Managed identity created for the cluster
    # type = "SystemAssigned"
  }

  #pool of servers to act as worker nodes
  default_node_pool {
    name = "agentpool" #name of the pool
    vm_size = "Standard_D2_v2" #spec of each VM
    zones = ["2", "3"]
    # node_count = var.node_count #number of nodes in the case where auto scaling of pool is not desired
    os_disk_size_gb = 60 #Size of OS disk
    os_disk_type = "Managed" #type of disk
    os_sku = "Ubuntu" #SKU of disk
    temporary_name_for_rotation = "poolrot"
    orchestrator_version = "1.34.0" #version of kubelet
    auto_scaling_enabled = true #autoscale configuration 
    min_count = 2 #min number of VMs 
    max_count = 4 #max number of VMs
    node_labels = { #node labels
      "purpose" = "test"
      "type" = "default_node_pool"
      "spec" = "compute-intensive"
      "app" = "client"
    }

    upgrade_settings { #How upgrade is managed
      drain_timeout_in_minutes = 10 #amount of time to wait for all pods in node to get evicted before node terminates
      node_soak_duration_in_minutes = 5
      max_surge = "2" #amount of extra nodes that needs to be created to ensure the PDB rule is met
      undrainable_node_behavior = "Cordon" #keeps the node CordonED while it's waiting for upgrade
    }    
    vnet_subnet_id = var.aks_nodes_subnet_id #ID of the subnet to host the worker nodes
  }

  linux_profile { #Identity and credentials to access any of the worker node
    admin_username = var.username # Username

    ssh_key { #public key for server while private key is available in host machine 
      key_data = trimspace(data.local_file.ssh_pubkey.content)
    }
  }

  network_profile {
    load_balancer_sku = "standard"
    network_plugin = "azure" #Means you’re using Azure CNI for pod networking.
    network_policy = "azure" #Enables Network Policies using Azure NPM.
    network_plugin_mode = "overlay" #Nodes get VNet IPs, Pods get IPs from an internal overlay CIDR
    dns_service_ip = "10.2.0.10" #IP for kube-dns service
    service_cidr = "10.2.0.0/16" #Network range used by kubernetes service

    outbound_type = "userAssignedNATGateway" #Determines how outbound from worker node happens. if fully private cluster, it's usually UserAssigned

    nat_gateway_profile {
      idle_timeout_in_minutes = 60
      managed_outbound_ip_count = 1
    }    
  }

  tags = var.common_tags
}