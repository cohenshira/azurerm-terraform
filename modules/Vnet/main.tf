resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.vnet_address_space
}

resource "azurerm_subnet" "subnet" {
  for_each                                       = var.subnets
  name                                           = each.value.name
  resource_group_name                            = azurerm_virtual_network.vnet.resource_group_name
  virtual_network_name                           = azurerm_virtual_network.vnet.name
  address_prefixes                               = each.value.address_prefixes
  enforce_private_link_endpoint_network_policies = true
}

resource "azurerm_virtual_network_peering" "vnetpeering" {
  name                      = var.peer_name
  resource_group_name       = var.resource_group_name
  virtual_network_name      = azurerm_virtual_network.vnet.name
  remote_virtual_network_id = var.remote_virtual_network_id
  use_remote_gateways       = var.remote_gateways
  allow_forwarded_traffic   = var.forward_traffic
  allow_gateway_transit     = var.gateway_transit
}
