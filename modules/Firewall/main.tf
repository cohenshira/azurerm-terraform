resource "azurerm_public_ip" "pip" {
  name                = "${var.fw_name}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.ip_allocation
  sku                 = var.sku
}

resource "azurerm_firewall_policy" "fwpolicy" {
  name                = var.fw_policy_name
  resource_group_name = var.resource_group_name
  location            = var.location

}

resource "azurerm_firewall" "hubfirewall" {
  name                = var.fw_name
  location            = var.location
  resource_group_name = var.resource_group_name
  firewall_policy_id = azurerm_firewall_policy.fwpolicy.id

  ip_configuration {
    name                 = "${var.fw_name}-ipconf"
    subnet_id            = var.subnet_id
    public_ip_address_id = azurerm_public_ip.pip.id
  }
  depends_on = [
    azurerm_firewall_policy.fwpolicy
  ]
}

resource "azurerm_firewall_policy_rule_collection_group" "fwrulecollection" {
  name               = var.fw_rule_collection_group_name
  firewall_policy_id = azurerm_firewall_policy.fwpolicy.id
  priority           = var.priority


  dynamic "application_rule_collection" {
    for_each = var.app_rule_collections
    content {
      name     = application_rule_collection.value.name
      priority = application_rule_collection.value.priority
      action   = application_rule_collection.value.action
      dynamic "rule" {
        for_each = application_rule_collection.value.rules
        content {
          name = rule.value.name
          dynamic "protocols" {
            for_each = rule.value.protocols
            content {
              type = protocols.value.protocolType
              port = protocols.value.port
            }
          }
          source_addresses      = rule.value.sourceAddresses[*]
          destination_fqdns     = rule.value.targetFqdns[*]
          destination_fqdn_tags = rule.value.fqdnTags[*]
          source_ip_groups      = rule.value.sourceIpGroups[*]
        }
      }
    }
  }

  dynamic "network_rule_collection" {
    for_each = var.network_rule_collections
    content {
      name     = network_rule_collection.value.name
      priority = network_rule_collection.value.priority
      action   = network_rule_collection.value.action
      dynamic "rule" {
        for_each = network_rule_collection.value.rules
        content {
          name                  = rule.value.name
          protocols             = rule.value.protocols[*]
          source_addresses      = rule.value.source_addresses[*]
          destination_addresses = rule.value.destination_addresses[*]
          destination_ports     = rule.value.destination_ports[*]
        }
      }
    }
  }
}


