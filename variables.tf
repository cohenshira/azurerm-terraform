variable "location" {
  type        = string
  description = "(Optional) Region for the created resources"
  default     = "westeurope"
}

variable "tenant_id" {
  type        = string
  description = "(Required) The ID of the azure tenant"
  sensitive   = true
}

variable "audience" {
  type        = string
  description = "(Required)The client id of the Azure VPN application"
  sensitive   = true
}

variable "issuer" {
  type        = string
  description = "(Required)The STS url for the tenant"
  sensitive   = true
}

variable "vm_user" {
  type        = string
  description = "(Required)User to connect the virtual machine"
  sensitive   = true
}

variable "password" {
  type        = string
  description = "(Required)Passowrd authentication"
  sensitive   = true
}
