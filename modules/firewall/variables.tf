variable "location" {
  type        = string
  description = "(Optional)The Location of the created resources"
  default     = "westeurope"
}

variable "resource_group_name" {
  type        = string
  description = "(Required)Resource group name for the created resources"
}

variable "firewall_name" {
  type        = string
  description = "(Required)Name for the firewall"
}

variable "subnet_id" {
  type        = string
  description = "(Required)ID for the subnet of the firewall ip"
}

variable "pip_sku" {
  type        = string
  description = "(Optional) SKU for the azure firewall public IP"
  default     = "Standard"
}

variable "ip_allocation" {
  type        = string
  description = "(Optional)IP Allocation - Static or Dynamic"
  default     = "Static"
}


variable "firewall_policy_name" {
  type        = string
  description = "(Required)Name for the firewall policy"
}

variable "application_rule_collection_groups" {
  description = "(Required) Application rule collection groups and rules"
  type = map(object({
    name     = string,
    priority = number,
    application_rule_collections = map(object({
      name     = string,
      priority = number,
      action   = string,
      rules = map(object({
        name = string,
        protocols = map(object({
          protocol_type = string,
          port          = number,
        }))
        source_addresses = list(string)
        target_fqdns     = list(string)
      }))
    }))
  }))
  default = {
    "key" = {
      application_rule_collections = {
        "key" = {
          action   = null
          name     = null
          priority = null
          rules = {
            "key" = {
              name = null
              protocols = {
                "key" = {
                  port          = null
                  protocol_type = null
                }
              }
              source_addresses = null
              target_fqdns     = null
            }
          }
        }
      }
      name     = null
      priority = null
    }
  }
}

variable "network_rule_collection_groups" {
  description = "(Required) Network rule collection groups and rules"
  type = map(object({
    name     = string,
    priority = number,
    network_rule_collections = map(object({
      name     = string,
      priority = number,
      action   = string,
      rules = map(object({
        name                  = string
        protocols             = list(string)
        source_addresses      = list(string)
        destination_addresses = list(string)
        destination_ports     = list(string)
      }))
    }))
  }))
  default = {
    "key" = {
      name     = null
      priority = null
      network_rule_collections = {
        "key" = {
          action   = null
          name     = null
          priority = null
          rules = {
            "key" = {
              destination_addresses = null
              destination_ports     = null
              name                  = null
              protocols             = null
              source_addresses      = null
            }
          }
        }
      }
    }
  }
}

variable "nat_rule_collection_groups" {
  description = "(Required) NAT rule collectio groups and rules"
  type = map(object({
    name     = string,
    priority = number,
    nat_rule_collections = map(object({
      name     = string,
      priority = number,
      action   = string,
      rules = map(object({
        name                = string,
        source_addresses    = list(string),
        destination_address = string,
        destination_ports   = list(string),
        translated_port     = string,
        translated_address  = string,
        protocols           = list(string)
      }))
    }))
  }))
  default = {
    "key" = {
      name     = null
      priority = null
      nat_rule_collections = {
        "key" = {
          action   = null
          name     = null
          priority = null
          rules = {
            "key" = {
              destination_address = null
              destination_ports   = null
              name                = null
              protocols           = null
              source_addresses    = null
              translated_address  = null
              translated_port     = null
            }
          }
        }
      }
    }
  }
}

variable "log_analytics_workspace_id" {
  type        = string
  description = "(Required) ID for the log analytics workspace for the firewall diagnostic setting"
}
