output "object" {
  value = azurerm_virtual_network.vnet
}
output "id" {
  value = azurerm_virtual_network.vnet.id
}
output "name" {
  value = azurerm_virtual_network.vnet.name
}

output "vnet_address_prefix" {
  value = azurerm_virtual_network.vnet.address_space[0]
}

output "subnet" {
  value = azurerm_subnet.subnet
}

output "created_subnets" {
  value = {
    for subnet in azurerm_subnet.subnet : subnet.name => subnet.id
  }
}

output "subnet_ids_list" {
  value = [for subnet in azurerm_subnet.subnet : subnet.id]
}



