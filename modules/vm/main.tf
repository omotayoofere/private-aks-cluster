# Creates a network interface for a VM, with optional public IP

resource "azurerm_network_interface" "nic" {
  name                = var.vm_nic
  location              = var.rg_region
  resource_group_name   = var.rg_name

  ip_configuration {
    name                          = "${var.vm_nic}-ip-config"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = var.public_ip != null ? var.public_ip : null
  }
}

# Creates a Linux Virtual Machine attached to the previously created NIC
# Provides compute resources inside the virtual network
resource "azurerm_linux_virtual_machine" "main" {
  name = var.vm_name
  location = var.rg_region
  resource_group_name = var.rg_name
  network_interface_ids = [azurerm_network_interface.nic.id] # Attach VM to NIC
  admin_username = "adminuser" # Default admin user
  size = "Standard_DS1_v2" # VM size (CPU/RAM)

  admin_ssh_key {
    username = "adminuser" 
    public_key = file("~/.ssh/id_ed25519.pub")
  }

  source_image_reference {
    publisher = "Canonical"
    offer = "0001-com-ubuntu-server-jammy"
    sku = "22_04-lts"
    version = "latest"
  }
  os_disk {
    name = "${var.vm_name}-os_disk"
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  tags = var.tags
}