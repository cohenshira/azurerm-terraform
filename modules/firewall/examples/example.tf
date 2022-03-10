module "firewall" {
  source = "./modules/firewall"

  location                       = "westeurope"
  resource_group_name            = "example-resource-group"
  firewall_name                  = "example-firewall-name"
  firewall_policy_name           = "example-firewall-policy"
  subnet_id                      = "/subscriptions/xxx/resourceGroups/example-resource-group/providers/Microsoft.Network/virtualNetworks/example-virtual-network/subnets/AzureFirewallSubnet"
  app_rule_collection_groups     = {
    name     = "application_rule_collection_group"
    priority = 102

    application_rule_collections = {
      example-application-rule-collection = {
        name     = "example-application-rule-collection"
        priority = 103
        action   = "Allow"

        rules = {
          allow-http = {
            name             = "AllowHttp"
            source_addresses = "10.0.0.0/16"
            target_fqdns     = "*.micrrosoft.com"
            protocols        = {
              http = {
                protocol_type = "Http"
                port          = 80
              }
            }
          }
        }
      }
    }
  }
  network_rule_collection_groups = {
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
  nat_rule_collection_groups     = {
    name     = "nat-rule-collection-group"
    priority = 300

    nat_rule_collections = {
      example-nat-nat_rule_collection = {
        name     = "example-nat-rule-collection"
        priority = 301
        action   = "Dnat"

        rules = {
          nat_rule = {
            name               = "nat-rule"
            protocols          = ["TCP"]
            source_addresses   = ["*"]
            destination_ports  = ["80"]
            translated_port    = "8080"
            translated_address = "10.0.0.5"
          }
        }

      }
    }
  }
}
