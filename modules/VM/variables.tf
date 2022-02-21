variable "location" {
  type    = string
  default = "westeurope"
}

variable "resource_group_name" {
  type = string
}

variable "pip_sku" {
  type    = string
  default = "Basic"
}

variable "ip_allocation" {
  type        = string
  description = "IP Allocation - Static or Dynamic"
  default     = "Dynamic"
}

variable "subnet_id" {
  type        = string
  description = "ID of the subnet used in the network interface creation"
}

variable "hostname" {
  type        = string
  description = "Name For The Virtual Machine"
  default     = "newvm"
}

variable "vm_size" {
  type        = string
  description = "Size for the VM"
}

variable "pass_auth" {
  type        = bool
  description = "Disabling Password authentication - true or false"
  default     = false
}

variable "username" {
  type        = string
  description = "Username"
}

variable "password" {
  type        = string
  description = "user password"
}

variable "publisher" {
  type        = string
  description = "Publisher of the image"
}

variable "offer" {
  type        = string
  description = "Offer of the image"
}

variable "image_sku" {
  type        = string
  description = "SKU"
}

variable "image_version" {
  type        = string
  description = "Image version"
  default     = "latest"
}

variable "caching" {
  type        = string
  description = "Caching for the internal OS disk"
}

variable "sa_type" {
  type        = string
  description = "Storage Account Type"
}

variable "linux_count" {
  type        = number
  description = "If count=0, linux VM would not create"
}

variable "windows_count" {
  type        = number
  description = "If count=0, windows VM would not create"
}
