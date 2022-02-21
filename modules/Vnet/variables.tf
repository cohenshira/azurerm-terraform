variable "location" {
  type    = string
  default = "westeurope"
}

variable "resource_group_name" {
  type        = string
  description = "Resource Group Name"
}

variable "vnet_name" {
  type        = string
  description = "Name for the virtual network"
}

variable "vnet_address_space" {
  type        = list(string)
  description = "Address Space For Virtual Network"
}

variable "subnets" {
  type        = map(any)
  description = "Subnets list to create"
}

variable "peer_name" {
  type        = string
  description = "Name for the vnet peering"
}

variable "remote_virtual_network_id" {
  type        = string
  description = "ID of the remote vnet we want to peer to"
}

variable "gateway_transit" {
  type        = bool
  description = "Control gateway links"
}

variable "forward_traffic" {
  type        = bool
  description = "Controls if forwarded traffic from VMs in the remote virtual network is allowed"
  default     = true
}

variable "remote_gateways" {
  type        = bool
  description = "Controls if remote gateways can be used on the local virtual network."
}
