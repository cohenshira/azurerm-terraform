module "two-way-peering" {
  source = "./modules/two-way-peering"

  resource_group_name_1 = "example-rg-1"
  resource_group_name_2 = "example-rg-2"
  peer_name_1           = "from_1_to_2"
  peer_name_2           = "from_2_to_1"
  vnet_name_1           = "example-vnet-1"
  vnet_name_2           = "example-vnet-2"
  vnet_id_1             = "/subscriptions/xxx/resourceGroups/example-rg-1/providers/Microsoft.Network/virtualNetworks/example-vnet-1"
  vnet_id_2             = "/subscriptions/xxx/resourceGroups/example-rg-2/providers/Microsoft.Network/virtualNetworks/example-vnet-2"
  remote_gateways_1     = false
  gateway_transit_1     = true
  remote_gateways_2     = true
  gateway_transit_2     = false
}
