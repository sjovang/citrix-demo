terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0.0"
    }
  }
}



resource "azurerm_subnet" "cloud_connectors" {

}


// Deploy a pair of cloud connectors
resource "azurerm_availability_set" "cloud_connectors" {
  name                = "ASG-Citrix-Cloud-Connectors"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
}

module "cloud_connector" {
  count                       = 2
  source                      = "./modules/terraform-azurerm-windows-vm"
  azurerm_availability_set_id = azurerm_availability_set.cloud_connectors.id
  name                        = "vm-cc-${count.index + 1}"
  resource_group              = var.resource_group
  subnet                      = azurerm_subnet.cloud_connectors
  vm_size                     = var.vm_size
  ad_domain_name              = var.ad_domain_name
  ad_ou_path                  = var.ad_ou_path
  ad_domainjoin_user          = var.ad_domainjoin_user
  ad_domainjoin_password      = var.ad_domainjoin_password
  key_vault_id                = var.key_vault_id
}