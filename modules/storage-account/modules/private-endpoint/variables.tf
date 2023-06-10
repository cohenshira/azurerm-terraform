variable "resource_group_name" {
  type        = string
  description = "(Required) Resource group name for the created resources"
}

variable "location" {
  type        = string
  description = "(Required) Location for the created resources"
}

variable "resource_name" {
  type        = string
  description = "(Required) Target Resource name to associate the private connection"
}

variable "resource_id" {
  type        = string
  description = "(Required) Target Resource ID to associate the private connection"
}

variable "subnet_id" {
  type        = string
  description = "(Required) Subnet ID to for the private endpoint"
}

variable "is_manual_connection" {
  type        = bool
  description = "(Optional) Manual connection to the remote resource"
  default     = false
}

variable "private_dns_zone_name" {
  type        = string
  description = "(Required) Name for the dns zone"
}

variable "vnet_id" {
  type        = string
  description = "(Required) Virtual network ID"
}

variable "network_link_name" {
  type        = string
  description = "(Required) Virtual link name"
}
