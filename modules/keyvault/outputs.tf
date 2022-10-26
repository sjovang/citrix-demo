output "key_vault_id" {
  value       = azurerm_key_vault.citrix_secrets.id
  description = "ID of key vault"
}