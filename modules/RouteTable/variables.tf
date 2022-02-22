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

variable "next_hop_ip" {
  type        = string
  description = "The IP that the route will forward packets to "
  default     = null
}

variable "subnet_ids" {
  type        = list(string)
  description = "The ID of the associated subnets"
}

variable "routes" {
  type        = map(any)
  description = "Routes for the route table"
}
