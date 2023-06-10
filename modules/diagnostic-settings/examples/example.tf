module "example-diagnostic_setting" {
  source                     = "./modules/diagnostic-settings"
  
  diagnostic_setting_name    = "virtual-network-diagnostic-settings"
  target_resource_id         = "/subscriptions/xxx/resourceGroups/example-resource-group/providers/Microsoft.Network/virtualNetworks/example-virtual-network"
  log_analytics_workspace_id = "/subscriptions/xxx/resourceGroups/exmple-resource-group/providers/Microsoft.OperationalInsights/workspaces/example-analytics-workspace"
}
