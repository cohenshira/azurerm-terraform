module "firewall" {
  source                              = "./modules/firewall"
  location                            = "westeurope"
  resource_group_name                 = "example-resource-group"
  firewall_name                       = "example-firewall-name"
  firewall_policy_name                = "example-firewall-policy"
  firewall_rule_collection_group_name = "example-rule-collection-group"
  subnet_id                           = "/subscriptions/xxx/resourceGroups/example-resource-group/providers/Microsoft.Network/virtualNetworks/example-virtual-network/subnets/AzureFirewallSubnet"
  network_priority                    = 101
  application_priority                = 102
  nat_priority                        = 103
  app_rule_collections                = {}
  network_rule_collections = {
    name     = "network_rule_collection1"
    priority = 105
    action   = "Deny"
    rule = {
      name                  = "network_rule_collection1_rule1"
      protocols             = ["TCP", "UDP"]
      source_addresses      = ["10.0.0.1"]
      destination_addresses = ["192.168.1.1", "192.168.1.2"]
      destination_ports     = ["80", "1000-2000"]
    }
  }
  nat_rule_collections = {}
}
