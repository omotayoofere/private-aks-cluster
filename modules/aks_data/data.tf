#Reads an existing SSH public key from the local filesystem for 
#authenticating SSH access to AKS worker nodes.

data "local_file" "ssh_pubkey" {
  filename = "/home/tayo/.ssh/id_rsa_aks.pub"
}

# data "azurerm_user_assigned_identity" "aks_managed_identity" {
#   resource_group_name = "special_resources"
#   name                = "aks-uami"
# }
