resource "azurerm_resource_group" "keyvault" {
  name     = "RG-Citrix-Keyvault"
  location = var.location
}

resource "azurerm_key_vault" "citrix_secrets" {
  name                = "KV-Citrix-Secrets"
  location            = azurerm_resource_group.keyvault.location
  resource_group_name = azurerm_resource_group.keyvault.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"
}

resource "azurerm_key_vault_access_policy" "admin" {
  key_vault_id = azurerm_key_vault.citrix_secrets.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azuread_user.admin_account.object_id

  // TODO: check if this fixes the destroy behaviour where the access policy is deleted before some secrets and cause a crash
  depends_on = [
    azurerm_key_vault.citrix_secrets
  ]

  certificate_permissions = [
    "Create",
    "Delete",
    "DeleteIssuers",
    "Get",
    "GetIssuers",
    "Import",
    "List",
    "ListIssuers",
    "ManageContacts",
    "ManageIssuers",
    "Recover",
    "Restore",
    "SetIssuers",
    "Update"
  ]

  key_permissions = [
    "Create",
    "Decrypt",
    "Delete",
    "Encrypt",
    "Get",
    "Import",
    "List",
    "Recover",
    "Restore",
    "Sign",
    "UnwrapKey",
    "Update",
    "Verify",
    "WrapKey"
  ]

  secret_permissions = [
    "Delete",
    "Get",
    "List",
    "Recover",
    "Restore",
    "Set"
  ]
}