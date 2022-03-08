output "object" {
  description = "Virtual Network object"
  value       = azurerm_virtual_network.vnet
}

output "id" {
  description = "Virtual Network ID"
  value       = azurerm_virtual_network.vnet.id
}

output "name" {
  description = "Virtual Network name"
  value       = azurerm_virtual_network.vnet.name
}

output "vnet_address_prefix" {
  description = "Virtual Network address space"
  value       = azurerm_virtual_network.vnet.address_space[0]
}

output "subnet" {
  description = "Subnet object"
  value       = azurerm_subnet.subnet
}

output "created_subnets" {
  description = "Map of each subnet name and subnet ID"
  value = {
    for subnet in azurerm_subnet.subnet : subnet.name => subnet.id
  }
}

output "subnet_ids_list" {
  description = "List of the subnet ids"
  value       = [for subnet in azurerm_subnet.subnet : subnet.id]
}



