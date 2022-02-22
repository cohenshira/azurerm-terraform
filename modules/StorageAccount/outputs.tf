output "object" {
  value = azurerm_storage_account.storage_account
}
output "id" {
  value = azurerm_storage_account.storage_account.id
}
output "name" {
  value = azurerm_storage_account.storage_account.name
}
output "private_endpoint" {
  value = azurerm_private_endpoint.private_endpoint
}
