variable "location" {
  type    = string
  default = "westeurope"
}

variable "tenant_id" {
  type    = string
  default = "https://login.microsoftonline.com/c9ad96a7-2bac-49a7-abf6-8e932f60bf2b"
}

variable "audience" {
  type    = string
  default = "41b23e61-6c1e-4545-b367-cd054e0ed4b4"
}

variable "issuer" {
  type    = string
  default = "https://sts.windows.net/c9ad96a7-2bac-49a7-abf6-8e932f60bf2b/"
}

variable "vm_user" {
  type        = string
  description = "User to connect the virtual machine"
  default     = "shira"
}

variable "password" {
  type        = string
  description = "Passowrd authentication"
  default     = "Aa1234567890"
}
