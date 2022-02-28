locals {
  log_analytics_workspace_name = "shira-log-analytics-workspace"
  retention_days               = 30
  log_analytics_workspace_sku  = "PerGB2018"
}

resource "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  name                = local.log_analytics_workspace_name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = local.log_analytics_workspace_sku
  retention_in_days   = local.retention_days
}


module "hub_vnet_diagnostic_setting" {
  source                     = "./modules/DiagnosticSettings"
  diagnostic_setting_name    = "${local.hub_vnet_name}-diagnostic-settings"
  target_resource_id         = module.hub_vnet.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.log_analytics_workspace.id
}

module "hub_firewall_diagnostic_setting" {
  source                     = "./modules/DiagnosticSettings"
  diagnostic_setting_name    = "${local.firewall_name}-diagnostic-settings"
  target_resource_id         = module.hub_firewall.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.log_analytics_workspace.id
}

module "hub_vm_diagnostic_setting" {
  source                     = "./modules/DiagnosticSettings"
  diagnostic_setting_name    = "${local.hub_hostname}-diagnostic-settings"
  target_resource_id         = module.hub_virtual_machine.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.log_analytics_workspace.id
}

module "spoke_vnet_diagnostic_setting" {
  source                     = "./modules/DiagnosticSettings"
  diagnostic_setting_name    = "${local.spoke_vnet_name}-diagnostic-settings"
  target_resource_id         = module.spoke_vnet.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.log_analytics_workspace.id
}

module "spoke_nsg_diagnostic_setting" {
  source                     = "./modules/DiagnosticSettings"
  diagnostic_setting_name    = "${local.spoke_nsg_name}-diagnostic-settings"
  target_resource_id         = module.spoke_nsg.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.log_analytics_workspace.id
}

module "spoke_vm_diagnostic_setting" {
  source                     = "./modules/DiagnosticSettings"
  diagnostic_setting_name    = "${local.spoke_hostname}-diagnostic-settings"
  target_resource_id         = module.spoke_virtual_machine.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.log_analytics_workspace.id
}

