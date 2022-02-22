variable "location" {
  type    = string
  default = "westeurope"
}

variable "tenant_id" {
  type      = string
  sensitive = true
}

variable "audience" {
  type      = string
  sensitive = true
}

variable "issuer" {
  type      = string
  sensitive = true
}

variable "vm_user" {
  type        = string
  description = "User to connect the virtual machine"
  sensitive   = true
}

variable "password" {
  type        = string
  description = "Passowrd authentication"
  sensitive   = true
}
