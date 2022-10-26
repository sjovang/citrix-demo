terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0.0"
    }
  }
}

resource "azurerm_application_security_group" "cloud_connector" {
  name                = "ASG-Citrix-CC"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
}

resource "azurerm_network_security_group" "cloud_connector" {
  name                = "NSG-Citrix-CC"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name

  security_rule {
    name                       = "in_allow_mgmt"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = 3389
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "in_deny_all"
    priority                   = 4096
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet" "cloud_connector" {
  name                 = "Cloud-Connectors"
  resource_group_name  = var.virtual_network.resource_group_name
  virtual_network_name = var.virtual_network.name
  address_prefixes     = var.cloud_connectors_address_prefixes
}

resource "azurerm_subnet_network_security_group_association" "cloud_connector" {
  subnet_id                 = azurerm_subnet.cloud_connector.id
  network_security_group_id = azurerm_network_security_group.cloud_connector.id
}


// Deploy a pair of cloud connectors
resource "azurerm_availability_set" "cloud_connectors" {
  name                = "ASG-Citrix-Cloud-Connectors"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
}

module "cloud_connector" {
  count                  = 1
  source                 = "../terraform-azurerm-windows-vm"
  availability_set_id    = azurerm_availability_set.cloud_connectors.id
  name                   = "vm-cc-${count.index + 1}"
  resource_group         = var.resource_group
  subnet                 = azurerm_subnet.cloud_connector
  size                   = var.vm_size
  ad_domain_name         = var.ad_domain_name
  ad_ou_path             = var.ad_ou_path
  ad_domainjoin_user     = var.ad_domainjoin_user
  ad_domainjoin_password = var.ad_domainjoin_password
  key_vault_id           = var.key_vault_id
}

resource "azurerm_virtual_machine_extension" "cloud_connector" {
  count                      = 1
  name                       = "citrix-cloud-connector"
  virtual_machine_id         = module.cloud_connector[count.index].vm.id
  publisher                  = "Microsoft.Compute"
  type                       = "CustomScriptExtension"
  type_handler_version       = "1.9"
  auto_upgrade_minor_version = true

  settings = jsonencode({
    commandToExecute : "powershell.exe install_cloud_connector.ps1 -APIID=${var.citrix_cloud_api_id} -APIKey=${var.citrix_cloud_api_key} -CustomerName=${var.citrix_cloud_customer_id} -ResourceLocationID=${var.citrix_cloud_resource_location_id}"
    fileUris : [
      "https://tsgterraformcugtech22.blob.core.windows.net/scripts/install_cloud_connector.ps1"
    ]
  })
}