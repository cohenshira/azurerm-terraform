variable "resource_group_name" {
  type        = string
  description = "Resource group where the resources will be created"
}

variable "location" {
  type        = string
  description = "Location for the created resources"
}

variable "route_table_name" {
  type        = string
  description = "Route Table Name"
}


variable "subnet_ids" {
  type        = list(string)
  description = "The ID of the associated subnets"
}

variable "routes" {
  type = map(object({
    name           = string
    address_prefix = string
    next_hop_type  = string
    next_hop_ip    = string
  }))
  default = {
      address_prefix = null
      name = null
      next_hop_ip = null
      next_hop_type = null
  }
  description = "Routes for the route table"
}
