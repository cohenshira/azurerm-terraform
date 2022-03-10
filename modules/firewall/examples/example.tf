module "firewall" {
  source = "./modules/firewall"

  location                            = "westeurope"
  resource_group_name                 = "example-resource-group"
  firewall_name                       = "example-firewall-name"
  firewall_policy_name                = "example-firewall-policy"
  subnet_id                           = "/subscriptions/xxx/resourceGroups/example-resource-group/providers/Microsoft.Network/virtualNetworks/example-virtual-network/subnets/AzureFirewallSubnet"
  app_rule_collection_groups          = {}
  network_rule_collection_groups      = {
    name     = "network_rule_collection_group"
    priority = 105

    network_rule_collections = {
      example-network_rule_collection = {
        name     = "example-network_rule_collection"
        priority = 106
        action   = "Allow"
        rule     = {
          name                  = "allowHttp"
          protocols             = ["TCP", "UDP"]
          source_addresses      = ["10.0.0.1"]
          destination_addresses = ["192.168.1.1", "192.168.1.2"]
          destination_ports     = ["80"]
        }
      }
    }
  }
  nat_rule_collection_groups          = {}
}
