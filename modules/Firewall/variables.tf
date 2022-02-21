variable "location" {
  type        = string
  description = "The Location of the created resources"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "fw_name" {
  type        = string
  description = "Name for the firewall"
}

variable "subnet_id" {
  type        = string
  description = "ID for the subnet of the firewall ip"
}

variable "sku" {
  type    = string
  default = "Standard"
}

variable "ip_allocation" {
  type        = string
  description = "IP Allocation - Static or Dynamic"
  default     = "Static"
}


variable "fw_policy_name" {
  type        = string
  description = "Name for the firewall policy"
}

variable "fw_rule_collection_group_name" {
  type        = string
  description = "Name for the firewall collection group"
}

variable "priority" {
  type        = number
  description = "Priority number for the collection group"
}

variable "app_rule_collections" {
  type        = map
  description = "Application rule collections and rules"
}

variable "network_rule_collections" {
  description = "Network rule collections and rules"
}
