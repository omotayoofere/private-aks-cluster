# Creates a Virtual Network Gateway for VPN connectivity (point-to-site and/or site-to-site)
# Provides Azure VPN access to on-premises networks or individual clients

resource "azurerm_virtual_network_gateway" "vnet-gateway" {
  name = var.vnet_gateway_name
  location = var.location
  resource_group_name = var.resource_group_name

  type = "Vpn" # Gateway type for VPN (not ExpressRoute)
  vpn_type = "RouteBased" # Supports dynamic routing (BGP optional)

  active_active = false # Single-instance VPN gateway
  bgp_enabled = false # BGP disabled
  sku = "VpnGw1AZ" # Gateway SKU

  ip_configuration {
    name = "vnetGatewayConfig"
    public_ip_address_id = var.vpn_gateway_pip_id
    private_ip_address_allocation = "Dynamic"
    subnet_id = var.vpn_gateway_subnet_id # Must be GatewaySubnet
  }

  # VPN client configuration for point-to-site access using Azure AD authentication
  vpn_client_configuration {
    address_space = var.vpn_client_address_space

    vpn_auth_types = [ "AAD" ] # Azure AD authentication
    vpn_client_protocols = [ "OpenVPN" ]

    aad_audience = "f09c46be-632f-4757-b3ad-9e119c35a03a" # Registered App client ID
    aad_issuer = "https://sts.windows.net/${var.tenant_id}/"
    aad_tenant = "https://login.microsoftonline.com/${var.tenant_id}"
  }

  timeouts {
    create = "45m"
    update = "30m"
    delete = "45m"
  }  
}