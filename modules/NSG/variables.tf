variable "location" {
  type = string
}

variable "resource_group_name" {
  type        = string
  description = "Resource Group Name"
}

variable "nsg_name" {
  type        = string
  description = "Name for the Network security group"
}

variable "nsg_rules" {
  type = map(object({
    name                         = string
    priority                     = number
    direction                    = string
    access                       = string
    protocol                     = string
    source_port_range            = string
    source_port_ranges           = list(string)
    destination_port_range       = string
    destination_port_ranges      = list(string)
    source_address_prefix        = string
    source_address_prefixes      = list(string)
    destination_address_prefix   = string
    destination_address_prefixes = list(string)
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
  description = "Rules of the network security group"
}

variable "subnet_ids" {
  type        = list(string)
  description = "ID of the subnet we want to connect the network security group"
}
