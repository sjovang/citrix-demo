terraform {
  required_version = ">=1.3.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.25.0"
    }
  }
}

provider "azurerm" {
  features {

  }
}

data "azurerm_client_config" "current" {}

module "active_directory" {
  source          = "./modules/active-directory"
  virtual_network = azurerm_virtual_network.active_directory
}