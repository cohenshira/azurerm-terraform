resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_network_security_rule" "netrules" {
  for_each                     = var.nsg_rules
  name                         = each.key
  direction                    = each.value.direction
  access                       = each.value.access
  priority                     = each.value.priority
  protocol                     = each.value.protocol
  source_port_ranges           = each.value.source_port_ranges
  destination_port_ranges      = each.value.destination_port_ranges
  source_address_prefixes      = each.value.source_address_prefixes
  destination_address_prefixes = each.value.destination_address_prefixes
  resource_group_name          = var.resource_group_name
  network_security_group_name  = azurerm_network_security_group.nsg.name
}


resource "azurerm_subnet_network_security_group_association" "nsgassociation" {
  count                     = length(var.subnet_ids)
  subnet_id                 = var.subnet_ids[count.index]
  network_security_group_id = azurerm_network_security_group.nsg.id
}
