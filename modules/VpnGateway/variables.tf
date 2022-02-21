variable "gw_name" {
  type        = string
  description = "Name for the Virtual Network Gateway"
}

variable "location" {
  type        = string
  description = "Location for the created resouorces"
}

variable "resource_group_name" {
  type        = string
  description = "Resource Group"
}

variable "ip_allocation" {
  type        = string
  description = "IP Allocation - Static or Dynamic"
  default     = "Dynamic"
}

variable "gw_type" {
  type        = string
  description = "Gateway Type"
  default     = "Vpn"
}

variable "vpn_type" {
  type        = string
  description = "Vpn Type"
  default     = "RouteBased"
}

variable "active_active" {
  type    = bool
  default = false
}

variable "enable_bgp" {
  type    = bool
  default = false
}

variable "generation" {
  type        = string
  description = "Virtual network Gateway generation"
  default     = "Generation1"
}

variable "gw_sku" {
  type        = string
  description = "Gateway SKU"
  default     = "Standard"
}

variable "subnet_id" {
  type        = string
  description = "Gateway Subnet ID"
}

variable "client_address_space" {
  type        = list(string)
  description = "Addres space for the VPN client"
}

variable "auth_type" {
  type        = list(string)
  description = "Authentication types"
  default     = ["AAD"]
}

variable "client_protocols" {
  type        = list(string)
  description = "VPN client protocols"
  default     = ["OpenVPN"]
}

variable "tenant_id" {
  type        = string
  description = "Tenant ID"
}

variable "audience" {
  type        = string
  description = "The client id of the Azure VPN application"
}

variable "issuer" {
  type        = string
  description = "The STS url for the tenant"
}


