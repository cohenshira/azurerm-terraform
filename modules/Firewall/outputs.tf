output "firewall_private_ip" {
  value = azurerm_firewall.hubfirewall.ip_configuration.0.private_ip_address
}

output "object" {
  value = azurerm_firewall.hubfirewall
}

output "id" {
  value = azurerm_firewall.hubfirewall.id
}

output "name" {
  value = azurerm_firewall.hubfirewall.name
}
