variable "storage_account_name" {
  type        = string
  description = "(Required)Storage account name"
}

variable "resource_group_name" {
  type        = string
  description = "(Required)Resource group name for the created resources"
}

variable "location" {
  type        = string
  description = "(Optional) Location for the created resources"
  default     = "westeurope"
}

variable "account_tier" {
  type        = string
  description = "(Required)Tier to use for the storage account. Standard/Premuim"
}

variable "account_replication_type" {
  type        = string
  description = "(Required)Type of replication for the storage account"
}

variable "subnet_id" {
  type        = string
  description = "(Required)Subnet ID to for the private endpoint"
}

variable "is_manual_connection" {
  type        = bool
  description = "(Required)Manual connection to the remote resource"
}

variable "private_dns_zone_name" {
  type        = string
  description = "(Optional) Name for the dns zone"
  default     = "privatelink.blob.core.windows.net"
}

variable "vnet_id" {
  type        = string
  description = "(Required)Virtual network ID"
}

variable "network_link_name" {
  type        = string
  description = "(Required)Virtual link name"
}

variable "subresource_names" {
  type        = list(string)
  description = "(Optional) A list of subresources names which the Private Endpoint is able to connect to"
  default     = ["blob"]
}

variable "log_analytics_workspace_id" {
  type        = string
  description = "(Required) ID for the log analytics workspace for the storage account diagnostic setting"
}