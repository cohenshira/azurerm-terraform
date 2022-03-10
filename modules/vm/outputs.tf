output "object" {
  description = "Virtual machine object"
  value       = var.is_linux ? azurerm_linux_virtual_machine.linux_vm.0 : azurerm_windows_virtual_machine.windows_vm.0
}

output "id" {
  description = "Virtual machine ID"
  value       = var.is_linux ? azurerm_linux_virtual_machine.linux_vm.0.id : azurerm_windows_virtual_machine.windows_vm.0.id
}

output "name" {
  description = "Virtual machine name"
  value       = var.is_linux ? azurerm_linux_virtual_machine.linux_vm.0.name : azurerm_windows_virtual_machine.windows_vm.0.name
}

output "private_ip" {
  description = "Virtual Machine private IP address"
  value       = var.is_linux ? azurerm_linux_virtual_machine.linux_vm.0.private_ip_address : azurerm_windows_virtual_machine.windows_vm.0.private_ip_address
}
