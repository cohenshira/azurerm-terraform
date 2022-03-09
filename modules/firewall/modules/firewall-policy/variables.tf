variable "location" {
  type        = string
  description = "(Required) The Location of the created resources"
}

variable "resource_group_name" {
  type        = string
  description = "(Required) Resource group name for the created resources"
}

variable "firewall_policy_name" {
  type        = string
  description = "(Required) Name for the firewall policy"
}

variable "application_rule_collection_groups" {
  description = "(Required) Application rule collection groups and rules"
  type        = map(object({
    name                         = string,
    priority                     = number,
    application_rule_collections = map(object({
      name     = string,
      priority = number,
      action   = string,
      rules    = map(object({
        name             = string,
        protocols        = map(object({
          protocol_type = string,
          port          = number,
        }))
        source_addresses = list(string)
        target_fqdns     = list(string)
      }))
    }))
  }))

  default = {}
}

variable "network_rule_collection_groups" {
  description = "(Required) Network rule collection groups and rules"
  type        = map(object({
    name                     = string,
    priority                 = number,
    network_rule_collections = map(object({
      name     = string,
      priority = number,
      action   = string,
      rules    = map(object({
        name                  = string
        protocols             = list(string)
        source_addresses      = list(string)
        destination_addresses = list(string)
        destination_ports     = list(string)
      }))
    }))
  }))

  default = {}
}

variable "nat_rule_collection_groups" {
  description = "(Required) NAT rule collectio groups and rules"
  type        = map(object({
    name                 = string,
    priority             = number,
    nat_rule_collections = map(object({
      name     = string,
      priority = number,
      action   = string,
      rules    = map(object({
        name                = string,
        source_addresses    = list(string),
        destination_address = optional(string),
        destination_ports   = list(string),
        translated_port     = string,
        translated_address  = optional(string),
        protocols           = list(string)
      }))
    }))
  }))

  default = {}
}

variable "firewall_private_ip" {
  type = string
  description = "Firewall private IP address"
}

variable "firewall_public_ip" {
  type = string
  description = "Firewall public IP address"
}