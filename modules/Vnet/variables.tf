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

