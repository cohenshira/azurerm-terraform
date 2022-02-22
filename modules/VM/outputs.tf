output "windows_vm" {
  description = "Windows virtual machine object"
  value       = azurerm_windows_virtual_machine.windows_vm
}
output "windows_vm_id" {
  description = "Windows virtual machine ID"
  value       = azurerm_windows_virtual_machine.windows_vm.id
}
output "windows_vm_name" {
  description = "Windows virtual machine name"
  value       = azurerm_windows_virtual_machine.windows_vm.name
}
output "linux_vm" {
  description = "Linux virtual machine object"
  value       = azurerm_windows_virtual_machine.linux_vm
}
output "linux_vm_id" {
  description = "Linux virtual machine ID"
  value       = azurerm_windows_virtual_machine.linux_vm.id
}
output "linux_vm_name" {
  description = "Linux virtual machine name"
  value       = azurerm_windows_virtual_machine.linux_vm.name
}
