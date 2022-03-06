terraform {
  experiments = [module_variable_optional_attrs]
}

resource "azurerm_network_security_group" "network_security_group" {
  name                = var.network_security_group_name
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_network_security_rule" "netrules" {
  for_each                     = var.network_security_group_rules
  name                         = each.key
  direction                    = each.value.direction
  access                       = each.value.access
  priority                     = each.value.priority
  protocol                     = each.value.protocol
  source_port_range            = each.value.source_port_range
  destination_port_range       = each.value.destination_port_range
  source_address_prefix        = each.value.source_address_prefix
  destination_address_prefix   = each.value.destination_address_prefix
  source_port_ranges           = each.value.source_port_ranges
  destination_port_ranges      = each.value.destination_port_ranges
  source_address_prefixes      = each.value.source_address_prefixes
  destination_address_prefixes = each.value.destination_address_prefixes
  resource_group_name          = var.resource_group_name
  network_security_group_name  = azurerm_network_security_group.network_security_group.name
}


resource "azurerm_subnet_network_security_group_association" "association" {
  count                     = length(var.subnet_ids)
  subnet_id                 = var.subnet_ids[count.index]
  network_security_group_id = azurerm_network_security_group.network_security_group.id
}

module "network_sceurity_group_diagnostic_setting" {
  source                     = "../diagnostic-settings"
  diagnostic_setting_name    = "${var.network_security_group_name}-diagnostic-settings"
  target_resource_id         = azurerm_network_security_group.network_security_group.id
  log_analytics_workspace_id = var.log_analytics_workspace_id
}
