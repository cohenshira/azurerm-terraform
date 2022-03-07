output "object" {
  value       = azurerm_virtual_network_gateway.gateway
  description = "Virtual network gateway object"
}

output "name" {
  value       = azurerm_virtual_network_gateway.gateway.name
  description = "Virtual network gateway name"
}

output "id" {
  value       = azurerm_virtual_network_gateway.gateway.id
  description = "Virtual network gateway ID"
}