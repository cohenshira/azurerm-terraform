variable "resource_group_name" {
  type        = string
  description = "(Required) Resource group where the resources will be created"
}

variable "location" {
  type        = string
  description = "(Required) Location for the created resources"
}

variable "route_table_name" {
  type        = string
  description = "(Required) Route Table Name"
}

variable "subnets" {
  type        = map
  description = "(Required) map of the subnets names and its ids to associate the route table"
}

variable "routes" {
  description = "(Required) Routes for the route table"
  type        = map(object({
    name           = string
    address_prefix = string
    next_hop_type  = string
    next_hop_ip    = optional(string)
  }))

  default = {
    next_hop_ip = null
  }
}
