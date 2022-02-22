variable "storage_account_name" {
  type        = string
  description = "Storage account name"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name for the created resources"
}

variable "location" {
  type        = string
  description = "Location for the created resources"
}

variable "account_tier" {
  type        = string
  description = "Tier to use for the storage account. Standard/Premuim"
}

variable "account_replication_type" {
  type        = string
  description = "Type of replication for the storage account"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID to for the private endpoint"
}

variable "is_manual_connection" {
  type        = bool
  description = "Manual connection to the remote resource"
}

variable "private_dns_zone_name" {
  type        = string
  description = "Name for the dns zone"
  default     = "privatelink.blob.core.windows.net"
}

variable "vnet_id" {
  type        = string
  description = "Virtual network ID"
}

variable "network_link_name" {
  type        = string
  description = "Virtual link name"
}

variable "subresource_names" {
  type        = list(string)
  description = "A list of subresource names which the Private Endpoint is able to connect to"
  default     = ["blob"]
}
