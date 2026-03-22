# Private AKS Infrastructure (Modular Terraform)

A comprehensive Terraform-based Infrastructure as Code (IaC) project for provisioning and managing Azure Kubernetes Service (AKS) in a modular, environment-aware, and reusable way.

The design follows a stacked approach, where infrastructure is broken into independent layers with clear responsibilities and dependencies. Each layer can be deployed, updated, and managed separately while still integrating seamlessly with others

---

## 📌 Overview

This repository contains Terraform configurations and reusable modules for deploying a full Azure Kubernetes Service (AKS), and supporting services. It supports multiple environments (e.g., `dev`, `prod`) using `.tfvars` files and environment-specific state files.

Key goals of this project:

* Production-ready AKS deployment
* Modular, reusable Terraform design
* Environment separation (dev/prod)
* Secure identity and access management
* Kubernetes-native integrations (Service Accounts, Namespaces) using Helm


The infrastructure is organized into logical layers, each responsible for a specific part of the platform:

#### 1. Resource Group Layer (rg/)
  * Bootstraps core resource groups used across the stack

#### 2. Networking Layer (networking/)
This layer serves as the foundation for all compute resources by provisioning:

  * Virtual Network (VNET) creation
  * Subnet provisioning
  * Subnet delegations (e.g., for AKS and private endpoints)

#### 3. Connectivity Layer (vpn-gateway/)
  * VPN Gateway configuration
  * Enables hybrid or cross-network connectivity

#### 4. Compute Layer (aks/)
  * Azure Kubernetes Service (AKS) cluster deployment
  * Integrates with pre-created subnets from the networking layer

#### 5. Platform Add-ons (addons/)

Cluster-level integrations such as:

  * Akure Key vaults
  * Azure Containe registry

#### 6. Kubernetes Extensions (k8s-CRDs/)

  * Installation of required Kubernetes Custom Resource Definitions (CRDs)
  * Supports platform-level components that depend on CRDs

---

## 🧱 Project Structure

```
.
├── providers.tf              # Global provider configuration (AzureRM, Kubernetes, Helm)
├── data.tf                   # Shared data sources
├── READme.md                 # Project documentation

├── modules/                  # Reusable Terraform modules
│   ├── rg/                   # Resource Group module
│   ├── vnet/                 # Virtual Network provisioning
│   ├── subnet/               # Subnet creation and delegation
│   ├── secGroup/             # Network Security Groups
│   ├── nat/                  # NAT Gateway configuration
│   ├── publicIp/             # Public IP resources
│   ├── vm/                   # Virtual Machine provisioning
│   ├── ssh/                  # SSH key generation/management
│   ├── acr/                  # Azure Container Registry
│   ├── aks_data/             # AKS data sources
│   ├── aks_node_pool/        # AKS node pool configuration
│   ├── akv/                  # Azure Key Vault
│   ├── akv_access_policy/    # Key Vault access policies
│   ├── appGateway/           # Application Gateway
│   ├── federated_id/         # Federated identity setup
│   ├── helm/                 # Helm deployments
│   ├── k8s_sa/               # Kubernetes service accounts
│   ├── namespace/            # Kubernetes namespaces
│   ├── private-endpoint/     # Private endpoint configuration
│   ├── roles/                # RBAC role assignments
│   ├── user_assigned_id/     # Managed identities
│   ├── virtual_network_gateway/ # VPN Gateway module
│   └── vnet/                 # Virtual Network module

├── rg/                       # Resource Group layer (bootstrap)
│   ├── main.tf               # RG creation
│   ├── variables.tf          # Input variables
│   ├── outputs.tf            # Outputs
│   ├── locals.tf             # Local values
│   ├── backend.tf            # Remote state config
│   └── terraform.tfvars      # Layer-specific variables

├── base/                     # Shared foundational resources
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── locals.tf
│   ├── data.tf
│   └── backend.tf

├── networking/               # Networking layer (core foundation)
│   ├── main.tf               # VNET, subnets, delegations
│   ├── variables.tf
│   ├── outputs.tf            # Exposes subnet IDs, VNET info
│   ├── locals.tf
│   ├── data.tf
│   └── backend.tf

├── vpn-gateway/              # Connectivity layer
│   ├── main.tf               # VPN Gateway setup
│   ├── variables.tf
│   ├── outputs.tf
│   ├── locals.tf
│   ├── data.tf
│   └── backend.tf

├── aks/                      # Compute layer (AKS cluster)
│   ├── main.tf               # AKS cluster deployment
│   ├── variables.tf
│   ├── outputs.tf            # kubeconfig, cluster details
│   ├── locals.tf
│   ├── data.tf               # Consumes networking outputs
│   ├── providers.tf          # Kubernetes/Helm providers
│   └── backend.tf

├── addons/                   # Cluster add-ons layer
│   ├── main.tf               # Ingress, monitoring, etc.
│   ├── variables.tf
│   ├── outputs.tf
│   ├── locals.tf
│   ├── data.tf               # Consumes AKS outputs
│   └── backend.tf

├── k8s-CRDs/                 # Kubernetes CRDs layer
│   ├── main.tf               # CRD installations
│   ├── variables.tf
│   ├── outputs.tf
│   ├── locals.tf
│   ├── data.tf               # Uses AKS cluster access
│   ├── providers.tf          # Kubernetes provider config
│   └── backend.tf
```
---

## ⚙️ Prerequisites

Before using this project, ensure the following tools, access, and permissions are correctly configured on your Linux environment.

* Terraform >= 1.5 is used to provision and manage all infrastructure resources. Follow LINK to install terraform in Linux environment.
* Azure CLI (`az`) is required for authentication and for Terraform to interact with Azure.
  * Install Azure CLI (Linux):
  * Login to Azure with an active subscription ID:
    ```bash
    az login
    az account set --subscription <SUBSCRIPTION_ID>
    ```
  * Verify:
    ```bash
    az account show
    ```
* kubectl is used to interact with Kubernetes clusters (AKS in this project)
  * Install kubectl (Linux):
    ```
    sudo apt-get update
    sudo apt-get install -y kubectl
    ```
  * Verify installation:
    `kubectl version --client`
* Helm is used in this project to deploy Kubernetes components such as:
  * cert-manager
  * argoCD
  * Istio
* Proper Azure permissions (Owner/Contributor or scoped RBAC) for Terraform to create and manage resources.

  * Subscription level (simplest): Owner or Contributor
  * Scoped (more secure approach): 
    * Contributor on target Resource Group
    * User Access Administrator (if assigning roles)
    * Key Vault Administrator (if managing secrets)

.

## 🔗 Layer Dependencies

Each layer is designed to be loosely coupled and communicates with other layers using Terraform remote state outputs.

Example dependencies:

  * aks depends on networking (subnet IDs)
  * addons depends on aks (cluster access)
  * k8s-CRDs depends on aks (Kubernetes API)

## ⚙️ Deployment Strategy

Infrastructure is deployed layer by layer in the following order:

1. rg
2. networking
3. vpn-gateway
4. aks
5. addons
6. k8s-CRDs

### Why this order is required

Some modules depends on resources created in the first apply. Running the second command before the first will result in failed provisioning due to missing dependencies.

Each layer:

  * Maintains its own Terraform state
  * Can be deployed independently 
  * Uses outputs from previous layers where required

---
## 🧩 Modules Overview

| Module            | Purpose                           |
| ----------------- | --------------------------------- |
| rg                | Creates Azure Resource Groups     |
| vnet              | Provisions Virtual Networks       |
| subnet            | Creates subnets within VNets      |
| secGroup          | Network Security Groups and rules |
| nat               | NAT Gateway for outbound traffic  |
| publicIp          | Azure Public IP resources         |
| vm                | Linux/Windows Virtual Machines    |
| ssh               | SSH key generation/storage        |
| acr               | Azure Container Registry          |
| aks_data          | Reads existing AKS cluster info   |
| akv               | Azure Key Vault                   |
| akv_access_policy | Key Vault access control          |
| roles             | Azure RBAC role assignments       |
| user_assigned_id  | Managed identities                |
| vpn-gateway       | VPN Gateway                       |
| helm              | Deploy Helm charts to AKS         |
| namespace         | Kubernetes namespaces             |
| k8s_sa            | Kubernetes Service Accounts       |

---

## 🔐 Security Considerations

* Sensitive variables should be passed using Environment variables and Akure key vault
* Federated Managed identities are used for resource communication

---

## 📦 State Management

Currently, this project uses local state separation via:

```
terraform.tfstate.d
```

> ⚠️ For production use, it is strongly recommended to migrate to a remote backend such as:

* Azure Storage Account (Terraform backend `azurerm`)
* Terraform Cloud

---

## 🧪 Testing Changes Safely

Always run:

```bash
terraform plan -var-file="terraform.tfvars"
```

Before applying changes to production.

Consider using:

* CI/CD pipelines (e.g., Azure DevOps, GitHub Actions)
* Policy as Code (OPA, Sentinel)
* `terraform fmt` and `terraform validate`

---


