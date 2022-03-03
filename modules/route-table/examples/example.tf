module "route-table" {
  source              = "./modules/route-table"
  route_table_name    = "example-route-table"
  location            = "westeurope"
  resource_group_name = "example-resource-group"
  routes = {
    to_internet = {
      name           = "ToInternet",
      address_prefix = ""
    }
  }
  subnet_ids = ["/subscriptions/xxx/resourceGroups/example-resource-group/providers/Microsoft.Network/virtualNetworks/example-virtual-network/subnets/example-subnet"]
}
