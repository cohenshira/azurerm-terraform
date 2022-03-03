output "object" {
  description = "Diagnostic setting"
  value       = azurerm_monitor_diagnostic_setting.diagnostic_setting
}
output "name" {
  description = "Diagnostic setting name"
  value       = azurerm_monitor_diagnostic_setting.diagnostic_setting.name
}
output "id" {
  description = "Diagnostic setting ID"
  value       = azurerm_monitor_diagnostic_setting.diagnostic_setting.id
}
