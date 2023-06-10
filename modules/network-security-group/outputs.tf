output "object" {
  description = "Network security group object"
  value       = azurerm_network_security_group.network_security_group
}

output "id" {
  description = "Network security group ID"
  value       = azurerm_network_security_group.network_security_group.id
}

output "name" {
  description = "Network security group name"
  value       = azurerm_network_security_group.network_security_group.name
}
