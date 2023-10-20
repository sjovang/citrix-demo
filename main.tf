terraform {
  backend "azurerm" {}
  required_version = ">=1.3.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.28.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.44.0"
    }
  }
}

provider "azurerm" {
  features {

  }
}

data "azurerm_client_config" "current" {}

data "azuread_user" "admin_account" {
  user_principal_name = var.admin_user_upn
}

module "azure_bastion" {
  source          = "./modules/azure-bastion"
  virtual_network = azurerm_virtual_network.citrix
  resource_group  = azurerm_resource_group.network
}

module "key_vault" {
  source               = "./modules/keyvault"
  admin_user_object_id = data.azuread_user.admin_account.object_id
  tenant_id            = data.azurerm_client_config.current.tenant_id
}

module "active_directory" {
  source                        = "./modules/active-directory"
  virtual_network               = azurerm_virtual_network.active_directory
  active_directory_netbios_name = "ksulab"
  active_directory_domain       = "ksulab.cloud"
  key_vault_id                  = module.key_vault.key_vault_id

  depends_on = [
    module.key_vault
  ]

}

resource "azurerm_resource_group" "cloud_connectors" {
  name     = "RG-Citrix-Cloud-Connectors"
  location = var.location
}

module "cloud_connectors" {
  source                            = "./modules/cloud-connectors"
  resource_group                    = azurerm_resource_group.cloud_connectors
  ad_domain_name                    = "ksulab.cloud"
  ad_ou_path                        = "OU=Citrix-Demo,DC=ksulab,DC=cloud"
  ad_domainjoin_user                = "demogod@ksulab.cloud"
  ad_domainjoin_password            = module.active_directory.domain_account_password
  key_vault_id                      = module.key_vault.key_vault_id
  virtual_network                   = azurerm_virtual_network.citrix
  citrix_cloud_api_id               = var.citrix_cloud_api_id
  citrix_cloud_api_key              = var.citrix_cloud_api_key
  citrix_cloud_customer_id          = var.citrix_cloud_customer_id
  citrix_cloud_resource_location_id = var.citrix_cloud_resource_location_id

  depends_on = [
    module.active_directory,
    module.key_vault
  ]
}