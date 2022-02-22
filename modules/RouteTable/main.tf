resource "azurerm_route_table" "route_table" {
  name                = var.route_table_name
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_route" "_route" {
  for_each               = var.routes
  resource_group_name    = var.resource_group_name
  route_table_name       = azurerm_route_table.route_table.name
  name                   = each.value.route_name
  address_prefix         = each.value.address_prefix
  next_hop_type          = each.value.next_hop_type
  next_hop_in_ip_address = var.next_hop_ip
}

resource "azurerm_subnet_route_table_association" "subnet_association" {
  count          = length(var.subnet_ids)
  subnet_id      = var.subnet_ids[count.index]
  route_table_id = azurerm_route_table.route_table.id
}
