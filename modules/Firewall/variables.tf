variable "location" {
  type        = string
  description = "The Location of the created resources"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "firewall_name" {
  type        = string
  description = "Name for the firewall"
}

variable "subnet_id" {
  type        = string
  description = "ID for the subnet of the firewall ip"
}

variable "sku" {
  type    = string
  default = "Standard"
}

variable "ip_allocation" {
  type        = string
  description = "IP Allocation - Static or Dynamic"
  default     = "Static"
}


variable "firewall_policy_name" {
  type        = string
  description = "Name for the firewall policy"
}

variable "firewall_rule_collection_group_name" {
  type        = string
  description = "Name for the firewall collection group"
}

variable "network_priority" {
  type        = number
  description = "Priority number for the network collection group"
}

variable "application_priority" {
  type        = number
  description = "Priority number for the application collection group"
}

variable "nat_priority" {
  type        = number
  description = "Priority number for the NAT collection group"
}

variable "app_rule_collections" {
  type = map(object({
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
  default = {
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
  description = "Application rule collections and rules"
}

variable "network_rule_collections" {
  type = map(object({
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
  default = {
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
  description = "Network rule collections and rules"
}

variable "nat_rule_collections" {
  type = map(object({
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
  default = {
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
  description = "NAT rule collection and rules"
}
