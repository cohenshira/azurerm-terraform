module "firewall_policy" {
  source = "./modules/firewall-policy"

  location                           = "westeurope"
  resource_group_name                = "example-resource-group"
  firewall_policy_name               = "example-firewall-policy"
  network_rule_collection_groups     = {
    name     = "network_rule_collection_group"
    priority = 105

    network_rule_collections = {
      example-network_rule_collection = {
        name     = "example-network_rule_collection"
        priority = 106
        action   = "Allow"
        rule     = {
          name                  = "allowHttp"
          protocols             = ["TCP"]
          source_addresses      = ["10.0.0.1"]
          destination_addresses = ["192.168.1.1", "192.168.1.2"]
          destination_ports     = ["80"]
        }
      }
    }
  }
  
  firewall_public_ip                 = azurerm_public_ip.pip.ip_address
}
