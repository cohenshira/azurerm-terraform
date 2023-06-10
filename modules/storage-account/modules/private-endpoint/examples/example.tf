module "private_endpoint" {
  source = "./modules/private-endpoint"

  resource_name         = "examplesa"
  resource_id           = "/subscriptions/xxx/resourceGroups/example-resource-group/providers/Microsoft.Network/virtualNetworks/example-virtual-network"
  resource_group_name   = "example-resource-group"
  location              = "westeurope"
  subnet_id             = "/subscriptions/xxx/resourceGroups/example-resource-group/providers/Microsoft.Network/virtualNetworks/example-virtual-network/subnets/example-subnet"
  vnet_id               = "/subscriptions/xxx/resourceGroups/example-resource-group/providers/Microsoft.Network/virtualNetworks/example-virtual-network"
  network_link_name     = "example-virtual-link"
  private_dns_zone_name = "storage-account-private-dns-zone"
}
