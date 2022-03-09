output "object" {
  value       = azurerm_private_endpoint.private_endpoint
  description = "Private Endpoint object"
}

output "id" {
  value       = azurerm_private_endpoint.private_endpoint.id
  description = "Private Endpoint ID"
}

output "name" {
  value       = azurerm_private_endpoint.private_endpoint.name
  description = "Private Endpoint name"
}
