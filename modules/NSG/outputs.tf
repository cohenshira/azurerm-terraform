output "nsg_object" {
  value = azurerm_network_security_group.nsg
}

output "nsg_id" {
  value = azurerm_network_security_group.nsg.id
}
