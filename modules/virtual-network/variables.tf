variable "location" {
  type    = string
  description = "(Optional)Region for the created resources"
  default = "westeurope"
}

variable "resource_group_name" {
  type        = string
  description = "(Required)Resource Group Name"
}

variable "vnet_name" {
  type        = string
  description = "(Required)Name for the virtual network"
}

variable "vnet_address_space" {
  type        = list(string)
  description = "(Required)Address Space For Virtual Network"
}

variable "subnets" {
  type        = map(any)
  description = "(Required)Subnets list to create"
}

variable "log_analytics_workspace_id" {
  type        = string
  description = "(Required) ID for the log analytics workspace for the vnet diagnostic setting"
}