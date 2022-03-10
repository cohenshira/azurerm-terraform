resource "azurerm_firewall_policy" "firewall_policy" {
  name                = var.firewall_policy_name
  resource_group_name = var.resource_group_name
  location            = var.location
}

resource "azurerm_firewall_policy_rule_collection_group" "firewall_network_rule_collection_group" {
  for_each = var.network_rule_collection_groups

  name               = each.value.name
  firewall_policy_id = azurerm_firewall_policy.firewall_policy.id
  priority           = each.value.priority

  dynamic "network_rule_collection" {
    for_each = each.value.network_rule_collections
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

  depends_on = [
    azurerm_firewall_policy.firewall_policy
  ]
}

resource "azurerm_firewall_policy_rule_collection_group" "firewall_application_rule_collection_group" {
  for_each = var.application_rule_collection_groups

  name               = each.value.name
  priority           = each.value.priority
  firewall_policy_id = azurerm_firewall_policy.firewall_policy.id

  dynamic "application_rule_collection" {
    for_each = each.value.application_rule_collections
    content {
      name     = application_rule_collection.value.name
      priority = application_rule_collection.value.priority
      action   = application_rule_collection.value.action

      dynamic "rule" {
        for_each = application_rule_collection.value.rules
        content {
          name              = rule.value.name
          source_addresses  = rule.value.source_addresses[*]
          destination_fqdns = rule.value.target_fqdns[*]

          dynamic "protocols" {
            for_each = rule.value.protocols
            content {
              type = protocols.value.protocol_type
              port = protocols.value.port
            }
          }
        }
      }
    }
  }

  depends_on = [
    azurerm_firewall_policy_rule_collection_group.firewall_network_rule_collection_group
  ]
}

resource "azurerm_firewall_policy_rule_collection_group" "firewall_nat_rule_collection_group" {
  for_each = var.nat_rule_collection_groups

  name               = each.value.name
  priority           = each.value.priority
  firewall_policy_id = azurerm_firewall_policy.firewall_policy.id

  dynamic "nat_rule_collection" {
    for_each = each.value.nat_rule_collections
    content {
      name     = nat_rule_collection.value.name
      priority = nat_rule_collection.value.priority
      action   = nat_rule_collection.value.action

      dynamic "rule" {
        for_each = nat_rule_collection.value.rules
        content {
          name                = rule.value.name
          source_addresses    = rule.value.source_addresses[*]
          destination_address = coalesce(rule.value.destination_address, var.firewall_public_ip)
          destination_ports   = rule.value.destination_ports[*]
          translated_port     = rule.value.translated_port
          translated_address  = rule.value.translated_address
          protocols           = rule.value.protocols[*]
        }
      }
    }
  }

  depends_on = [
    azurerm_firewall_policy_rule_collection_group.firewall_application_rule_collection_group
  ]
}
