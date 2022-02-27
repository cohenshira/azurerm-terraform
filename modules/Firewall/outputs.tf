output "firewall_private_ip" {
  description = "Firewall private IP"
  value       = azurerm_firewall.firewall.ip_configuration.0.private_ip_address
}
output "object" {
  description = "Firewall object"
  value       = azurerm_firewall.firewall
}
output "id" {
  description = "Firewall ID"
  value       = azurerm_firewall.firewall.id
}
output "name" {
  description = "Firewall name"
  value       = azurerm_firewall.firewall.name
}
