resource "azurerm_virtual_network_peering" "from_1_to_2" {
  name                      = var.peer_name_1
  resource_group_name       = var.resource_group_name_1
  virtual_network_name      = var.vnet_name_1
  remote_virtual_network_id = var.vnet_id_2
  use_remote_gateways       = var.remote_gateways_1
  allow_forwarded_traffic   = var.forward_traffic_1
  allow_gateway_transit     = var.gateway_transit_1
}

resource "azurerm_virtual_network_peering" "from_2_to_1" {
  name                      = var.peer_name_2
  resource_group_name       = var.resource_group_name_2
  virtual_network_name      = var.vnet_name_2
  remote_virtual_network_id = var.vnet_id_1
  use_remote_gateways       = var.remote_gateways_2
  allow_forwarded_traffic   = var.forward_traffic_2
  allow_gateway_transit     = var.gateway_transit_2
}