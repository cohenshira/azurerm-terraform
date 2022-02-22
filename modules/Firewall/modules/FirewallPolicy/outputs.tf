output "object" {
  description = "Firewall policy object"
  value       = azurerm_firewall_policy.firewall_policy
}
output "id" {
  description = "Firewall policy ID"
  value = azurerm_firewall_policy.firewall_policy.id
}
output "name" {
  description = "Firewall policy name"
  value = azurerm_firewall_policy.firewall_policy.name
}
