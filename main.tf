terraform {
  required_version = ">=1.3.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.25.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.29.0"
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

module "active_directory" {
  source                        = "./modules/active-directory"
  virtual_network               = azurerm_virtual_network.active_directory
  active_directory_netbios_name = "ksulab"
  active_directory_domain       = "ksulab.cloud"
  key_vault_id                  = azurerm_key_vault.citrix_secrets.id
}

resource "azurerm_resource_group" "cloud_connectors" {
    name = "RG-Citrix-Cloud-Connectors"
    location = var.location
}

module "cloud_connectors" {
  source = "./modules/cloud-connetors"
}