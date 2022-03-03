resource "azurerm_firewall_policy" "firewall_policy" {
  name                = var.firewall_policy_name
  resource_group_name = var.resource_group_name
  location            = var.location
}

resource "azurerm_firewall_policy_rule_collection_group" "firewall_network_rule_collection_group" {
  name               = "${var.firewall_rule_collection_group_name}-network"
  firewall_policy_id = azurerm_firewall_policy.firewall_policy.id
  priority           = var.network_priority

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

resource "azurerm_firewall_policy_rule_collection_group" "firewall_application_rule_collection_group" {
  name               = "${var.firewall_rule_collection_group_name}-application"
  firewall_policy_id = azurerm_firewall_policy.firewall_policy.id
  priority           = var.application_priority

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
              type = protocols.value.protocol_type
              port = protocols.value.port
            }
          }
          source_addresses      = rule.value.source_addresses[*]
          destination_fqdns     = rule.value.target_fqdns[*]
        }
      }
    }
  }
}

resource "azurerm_firewall_policy_rule_collection_group" "firewall_nat_rule_collection_group" {
  name               = "${var.firewall_rule_collection_group_name}-nat"
  firewall_policy_id = azurerm_firewall_policy.firewall_policy.id
  priority           = var.nat_priority

  dynamic "nat_rule_collection" {
    for_each = var.nat_rule_collections
    content {
      name     = nat_rule_collection.value.name
      priority = nat_rule_collection.value.priority
      action   = nat_rule_collection.value.action
      dynamic "rule" {
        for_each = nat_rule_collection.value.rules
        content {
          name                = rule.value.name
          source_addresses    = rule.value.source_addresses[*]
          destination_address = rule.value.destination_address
          destination_ports   = rule.value.destination_ports[*]
          translated_port     = rule.value.translated_port
          translated_address  = rule.value.translated_address
          protocols           = rule.value.protocols[*]
        }
      }
    }
  }
}