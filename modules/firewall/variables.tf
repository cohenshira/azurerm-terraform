variable "location" {
  type        = string
  description = "(Required) The Location of the created resources"
}

variable "resource_group_name" {
  type        = string
  description = "(Required) Resource group name for the created resources"
}

variable "firewall_name" {
  type        = string
  description = "(Required) Name for the firewall"
}

variable "subnet_id" {
  type        = string
  description = "(Required) ID of the subnet for the firewall"
}

variable "pip_sku" {
  type        = string
  description = "(Optional) SKU for the azure firewall public IP"
  default     = "Standard"
}

variable "ip_allocation" {
  type        = string
  description = "(Optional) IP Allocation - Static or Dynamic"
  default     = "Static"
}

variable "firewall_policy_name" {
  type        = string
  description = "(Required) Name for the firewall policy"
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

  default = {}
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

  default = {}
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

  default = {}
}

variable "log_analytics_workspace_id" {
  type        = string
  description = "(Required) ID for the log analytics workspace for the firewall diagnostic setting"
}
