variable "location" {
  type        = string
  description = "(Optional) Region for the created resources"
}

variable "resource_group_name" {
  type        = string
  description = "(Required) Resource Group Name"
}

variable "vnet_name" {
  type        = string
  description = "(Required) Name for the virtual network"
}

variable "vnet_address_space" {
  type        = list(string)
  description = "(Required) Address Space For Virtual Network"
}

variable "subnets" {
  type = map(object({
    name             = string
    address_prefixes = list(string)
  }))
  description = "(Required) Subnets list to create"
}

variable "log_analytics_workspace_id" {
  type        = string
  description = "(Required) ID for the log analytics workspace for the vnet diagnostic setting"
}

variable "enforce_private_link_endpoint_network_policies" {
  type = bool
  description = "if value is true, private link endpoint will be enabled on this virtual network"
  default = true
}