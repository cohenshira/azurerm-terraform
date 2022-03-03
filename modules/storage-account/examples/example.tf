module "storage_account" {
  source                   = "./modules/storage-account"
  storage_account_name     = "examplesa"
  resource_group_name      = "example-resource-group"
  location                 = "westeurope"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  is_manual_connection     = "false"
  subnet_id                = "/subscriptions/xxx/resourceGroups/example-resource-group/providers/Microsoft.Network/virtualNetworks/example-virtual-network/subnets/example-subnet"
  vnet_id                  = "/subscriptions/xxx/resourceGroups/example-resource-group/providers/Microsoft.Network/virtualNetworks/example-virtual-network"
  network_link_name        = "example-virtual-link"

}
