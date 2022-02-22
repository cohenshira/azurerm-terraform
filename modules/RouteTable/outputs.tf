output "object" {
  description = "Route Table Object"
  value       = azurerm_route_table.route_table
}
output "name" {
  description = "Route Table name"
  value       = azurerm_route_table.route_table.name
}
output "id" {
  description = "Route Table ID"
  value       = azurerm_route_table.route_table.id
}

output "route" {
  description = "Route object"
  value       = azurerm_route.route
}
