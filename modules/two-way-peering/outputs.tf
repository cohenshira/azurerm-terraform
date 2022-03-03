output "peer_1" {
  description = "First peering object"
  value       = azurerm_virtual_network_peering.from_1_to_2
}
output "peer_1_id" {
  description = "First peering ID"
  value       = azurerm_virtual_network_peering.from_1_to_2.id
}
output "peer_1_name" {
  description = "First peering name"
  value       = azurerm_virtual_network_peering.from_1_to_2.name
}
output "peer_2" {
  description = "Second peering object"
  value       = azurerm_virtual_network_peering.from_2_to_1
}
output "peer_2_id" {
  description = "Second peering ID"
  value       = azurerm_virtual_network_peering.from_2_to_1.id
}
output "peer_2_name" {
  description = "Second peering name"
  value       = azurerm_virtual_network_peering.from_2_to_1.name
}
