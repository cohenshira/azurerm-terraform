variable "resource_group_name" {
  type        = string
  description = "(Required)Resource group where the resources will be created"
}

variable "location" {
  type        = string
  description = "(Optional)Location for the created resources"
  default     = "westeurope"
}

variable "route_table_name" {
  type        = string
  description = "(Required)Route Table Name"
}


variable "subnet_ids" {
  type        = list(string)
  description = "(Required)The ID of the associated subnets"
}

variable "routes" {
  type = map(object({
    name           = string
    address_prefix = string
    next_hop_type  = string
    next_hop_ip    = optional(string)
  }))
  default = {
    next_hop_ip = null
  }
  description = "(Required)Routes for the route table"
}
