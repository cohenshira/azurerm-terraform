variable "gateway_name" {
  type        = string
  description = "(Required) Name for the Virtual Network Gateway"
}

variable "location" {
  type        = string
  description = "(Required) Location for the created resouorces"
}

variable "resource_group_name" {
  type        = string
  description = "(Required) Resource group name for the created resources"
}

variable "ip_allocation" {
  type        = string
  description = "(Optional) IP Allocation type - Static or Dynamic"
  default     = "Dynamic"
}

variable "gateway_type" {
  type        = string
  description = "(Optional) Gateway Type"
  default     = "Vpn"
}

variable "vpn_type" {
  type        = string
  description = "(Optional) Vpn Type"
  default     = "RouteBased"
}

variable "active_active" {
  type    = bool
  description = "(Optional) if value equals true, an active-active vpn gateway will be created. Else, an active-standby vpn gateway will be created"
  default = false
}

variable "enable_bgp" {
  type    = bool
  description = "(Optional) Enabling border gateway protocol"
  default = false
}

variable "generation" {
  type        = string
  description = "(Optional) Virtual network Gateway generation"
  default     = "Generation1"
}

variable "gateway_sku" {
  type        = string
  description = "(Optional) Gateway SKU"
  default     = "Standard"
}

variable "subnet_id" {
  type        = string
  description = "(Required) Gateway Subnet ID"
}

variable "client_address_space" {
  type        = list(string)
  description = "(Required) Addres space for the VPN client"
}

variable "auth_type" {
  type        = list(string)
  description = "(Optional) Authentication types to the gateway"
}

variable "client_protocols" {
  type        = list(string)
  description = "(Optional) VPN client protocols"
  default     = ["OpenVPN"]
}

variable "tenant_id" {
  type        = string
  description = "(Required) ID of the azure tenant"
}

variable "audience" {
  type        = string
  description = "(Required) The client id of the Azure VPN application"
}

variable "issuer" {
  type        = string
  description = "(Required) The STS url for the tenant"
}