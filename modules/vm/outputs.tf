output "vm_id" {
    value = azurerm_linux_virtual_machine.main.id
}

output "vm_private_ip" {
    value = azurerm_linux_virtual_machine.main.private_ip_address
}