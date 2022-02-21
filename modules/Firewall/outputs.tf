output "fw_private_ip" {
  value = azurerm_firewall.hubfirewall.ip_configuration.0.private_ip_address
}

output "firewall" {
  value = azurerm_firewall.hubfirewall
}
