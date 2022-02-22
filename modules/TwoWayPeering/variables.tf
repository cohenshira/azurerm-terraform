variable "resource_group_name_1" {
  type        = string
  description = "Resource Group for the first peering resource "
}

variable "resource_group_name_2" {
  type        = string
  description = "Resource Group for the second peering resource "
}

variable "peer_name_1" {
  type        = string
  description = "Name for the first peer"
}

variable "vnet_name_1" {
  type        = string
  description = "First Virtual Network name"
}

variable "vnet_id_1" {
  type        = string
  description = "First Virtual Network ID"
}

variable "remote_gateways_1" {
  type        = bool
  description = "Controls if remote gateways can be used on the local virtual network"
}

variable "forward_traffic_1" {
  type        = bool
  description = "Controls if forwarded traffic from VMs in the remote virtual network is allowed"
  default     = true
}

variable "gateway_transit_1" {
  type        = bool
  description = "Control gateway links"
}


variable "peer_name_2" {
  type        = string
  description = "Name for the second peer"
}

variable "vnet_name_2" {
  type        = string
  description = "Second Virtual Network name"
}

variable "vnet_id_2" {
  type        = string
  description = "Second Virtual Network ID"
}

variable "remote_gateways_2" {
  type        = bool
  description = "Controls if remote gateways can be used on the local virtual network"
}

variable "forward_traffic_2" {
  type        = bool
  description = "Controls if forwarded traffic from VMs in the remote virtual network is allowed"
  default     = true
}

variable "gateway_transit_2" {
  type        = bool
  description = "Control gateway links"
}
