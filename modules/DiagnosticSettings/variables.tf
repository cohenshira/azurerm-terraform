variable "diagnostic_setting_name" {
  type        = string
  description = "Name for the diagnostic setting"
}

variable "target_resource_id" {
  type        = string
  description = "Resource ID of the resource the diagnostic setting will be applied to"
}

variable "log_analytics_workspace_id" {
  type        = string
  description = "Log Analytics workspace ID where the diagnostics will be saved"
}

variable "is_enabled" {
  type        = bool
  description = "Enabling the retention policy"
  default     = false
}
