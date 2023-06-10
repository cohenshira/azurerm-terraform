resource "azurerm_storage_account" "storage_account" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
}

module "private_endpoint" {
  source = "./modules/private-endpoint"

  resource_group_name   = var.resource_group_name
  location              = var.location
  resource_id           = azurerm_storage_account.storage_account.id
  resource_name         = azurerm_storage_account.storage_account.name
  subnet_id             = var.subnet_id
  private_dns_zone_name = var.private_dns_zone_name
  vnet_id               = var.vnet_id
  network_link_name     = var.network_link_name

  depends_on = [
    azurerm_storage_account.storage_account
  ]
}

module "storage_account_diagnostic_setting" {
  source = "../diagnostic-settings"

  diagnostic_setting_name    = "${var.storage_account_name}-diagnostic-settings"
  target_resource_id         = azurerm_storage_account.storage_account.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  depends_on = [
    azurerm_storage_account.storage_account
  ]
}
