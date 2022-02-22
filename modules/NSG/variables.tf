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
    source_port_ranges           = list(string)
    destination_port_ranges      = list(string)
    source_address_prefixes      = list(string)
    destination_address_prefixes = list(string)
  }))
  description = "Rules of the network security group"
}

variable "subnet_ids" {
  type        = list(string)
  description = "ID of the subnet we want to connect the network security group"
}
