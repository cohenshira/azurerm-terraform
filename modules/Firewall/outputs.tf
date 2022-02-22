output "firewall_private_ip" {
  description = "Firewall private IP"
  value       = azurerm_firewall.hubfirewall.ip_configuration.0.private_ip_address
}
output "object" {
  description = "Firewall object"
  value       = azurerm_firewall.hubfirewall
}
output "id" {
  description = "Firewall ID"
  value = azurerm_firewall.hubfirewall.id
}
output "name" {
  description = "Firewall name"
  value = azurerm_firewall.hubfirewall.name
}
