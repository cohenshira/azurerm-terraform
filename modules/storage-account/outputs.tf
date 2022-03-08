output "object" {
  value       = azurerm_storage_account.storage_account
  description = "Storage account object"
}

output "id" {
  value       = azurerm_storage_account.storage_account.id
  description = "Storage account ID"
}

output "name" {
  value       = azurerm_storage_account.storage_account.name
  description = "Storage account name"
}

output "private_endpoint" {
  value       = azurerm_private_endpoint.private_endpoint
  description = "Storage account private endpoint"
}
