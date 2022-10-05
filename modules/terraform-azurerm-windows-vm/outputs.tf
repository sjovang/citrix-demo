output "private_ip_address" {
  value = azurerm_network_interface.vm.private_ip_address
}

output "vm" {
  value = azurerm_windows_virtual_machine.vm
}