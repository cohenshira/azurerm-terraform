variable "location" {
  type        = string
  description = "(Optional)Location where the resources will be created"
  default     = "westeurope"
}

variable "resource_group_name" {
  type        = string
  description = "(Required)Resource Group Name for the created resources"
}

variable "nsg_name" {
  type        = string
  description = "(Required)Name for the Network security group"
}

variable "nsg_rules" {
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
  default = {
    "key" = {
      access                       = null
      destination_address_prefix   = null
      destination_address_prefixes = []
      destination_port_range       = null
      destination_port_ranges      = []
      direction                    = null
      name                         = null
      priority                     = 100
      protocol                     = null
      source_address_prefix        = null
      source_address_prefixes      = []
      source_port_range            = null
      source_port_ranges           = []
    }
  }
  description = "(Required)Rules of the network security group"
}

variable "subnet_ids" {
  type        = list(string)
  description = "(Required)ID of the subnet we want to connect the network security group"
}
