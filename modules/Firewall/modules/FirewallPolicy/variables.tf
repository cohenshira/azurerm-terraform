variable "location" {
  type        = string
  description = "The Location of the created resources"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "firewall_policy_name" {
  type        = string
  description = "Name for the firewall policy"
}

variable "firewall_rule_collection_group_name" {
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
    type = map(object({
        name = string,
        priority = number,
        action = string,
        rules = map(object)
    }))
  description = "Network rule collections and rules"
}
