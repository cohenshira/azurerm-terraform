resource "azurerm_storage_account" "spokesa" {
  name                     = var.sa_name
  resource_group_name      = var.rg_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type

}

resource "azurerm_private_dns_zone" "privatednszone" {
  name                = var.private_dns_zone_name
  resource_group_name = var.rg_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "network_link" {
  name                  = "vnet-link"
  resource_group_name   = var.rg_name
  private_dns_zone_name = azurerm_private_dns_zone.privatednszone.name
  virtual_network_id    = var.vnet_id
}

resource "azurerm_private_endpoint" "privateep" {
  name                = "${var.sa_name}-private-endpoint"
  location            = var.location
  resource_group_name = var.rg_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "${var.sa_name}-private-service-connection"
    private_connection_resource_id = azurerm_storage_account.spokesa.id
    is_manual_connection           = var.is_manual_connection
    subresource_names              = ["blob"]
  }
}


