variable "location" {
  type        = string
  description = "(Optional)Location for the created resources"
  default     = "westeurope"
}

variable "resource_group_name" {
  description = "(Required)Resource group name for the created resources"
  type        = string
}

variable "pip_sku" {
  type        = string
  description = "(Optional) SKU for the public IP"
  default     = "Basic"
}

variable "ip_allocation" {
  type        = string
  description = "(Optional) IP Allocation - Static or Dynamic"
  default     = "Dynamic"
}

variable "subnet_id" {
  type        = string
  description = "(Required)ID of the subnet used in the network interface creation"
}

variable "hostname" {
  type        = string
  description = "(Required)Name For The Virtual Machine"
}

variable "vm_size" {
  type        = string
  description = "(Required)size for the VM"
}

variable "pass_auth" {
  type        = bool
  description = "(Optional) Disabling Password authentication - true or false"
  default     = false
}

variable "username" {
  type        = string
  description = "(Required) Username for connecting the virtual machine"
}

variable "password" {
  type        = string
  description = "(Required)user password"
}

variable "publisher" {
  type        = string
  description = "(Required)Publisher of the image"
}

variable "offer" {
  type        = string
  description = "(Required)Offer of the image"
}

variable "image_sku" {
  type        = string
  description = "(Required) Image SKU for the the image source"
}

variable "image_version" {
  type        = string
  description = "(Optional) Image version"
  default     = "latest"
}

variable "caching" {
  type        = string
  description = "(Required)Caching for the internal OS disk"
}

variable "storage_account_type" {
  type        = string
  description = "(Required)Type of sku redundancy for the OS disk"
}

variable "is_linux" {
  type        = bool
  description = "(Required)If value eauals true, a linux machine will be created.Else, a windows machine will be created"
}
