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

module "virtual_network_diagnostic_setting" {
  source                     = "../diagnostic-settings"
  diagnostic_setting_name    = "${var.vnet_name}-diagnostic-settings"
  target_resource_id         = azurerm_virtual_network.vnet.id
  log_analytics_workspace_id = var.log_analytics_workspace_id
}
