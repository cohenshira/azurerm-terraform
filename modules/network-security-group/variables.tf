variable "location" {
  type        = string
  description = "(Optional) Location where the resources will be created"
}

variable "resource_group_name" {
  type        = string
  description = "(Required) Resource Group Name for the created resources"
}

variable "network_security_group_name" {
  type        = string
  description = "(Required) Name for the Network security group"
}

variable "network_security_group_rules" {
  type = map(object({
    name                         = string
    priority                     = number
    direction                    = string
    access                       = string
    protocol                     = string
    source_port_range            = optional(string)
    source_port_ranges           = optional(list(string))
    destination_port_range       = optional(string)
    destination_port_ranges      = optional(list(string))
    source_address_prefix        = optional(string)
    source_address_prefixes      = optional(list(string))
    destination_address_prefix   = optional(string)
    destination_address_prefixes = optional(list(string))
  }))
  description = "(Required) Rules of the network security group, can be single or plural range/s and prefix/es"
}

variable "subnets" {
  type        = map(any)
  description = "(Required) map of subnets names and its ids to associate the network security group"
}

variable "log_analytics_workspace_id" {
  type        = string
  description = "(Required) ID for the log analytics workspace for the network security group diagnostic setting"
}
