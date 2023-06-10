locals {
  location                     = "westeurope"
  log_analytics_workspace_name = "shira-log-analytics-workspace"
  retention_days               = 30
  log_analytics_workspace_sku  = "PerGB2018"
}

resource "azurerm_log_analytics_workspace" "central_workspace" {
  name                = local.log_analytics_workspace_name
  location            = local.location
  resource_group_name = azurerm_resource_group.hub.name
  sku                 = local.log_analytics_workspace_sku
  retention_in_days   = local.retention_days
}

locals {
  spoke_peer_name           = "SpokeToHub"
  spoke_use_remote_gateways = true
  spoke_gateway_transit     = false
  hub_peer_name             = "HubToSpoke"
  hub_use_remote_gateways   = false
  hub_gateway_transit       = true
}

module "hub_spoke_peering" {
  source = "./modules/two-way-peering"

  peer_name_1           = local.hub_peer_name
  vnet_name_1           = module.hub_vnet.name
  vnet_id_1             = module.hub_vnet.id
  resource_group_name_1 = azurerm_resource_group.hub.name
  remote_gateways_1     = local.hub_use_remote_gateways
  gateway_transit_1     = local.hub_gateway_transit

  peer_name_2           = local.spoke_peer_name
  vnet_name_2           = module.spoke_vnet.name
  vnet_id_2             = module.spoke_vnet.id
  resource_group_name_2 = azurerm_resource_group.spoke.name
  remote_gateways_2     = local.spoke_use_remote_gateways
  gateway_transit_2     = local.spoke_gateway_transit

  depends_on = [
    module.hub_vnet,
    module.spoke_vnet
  ]
}
