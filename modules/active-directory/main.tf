resource "azurerm_resource_group" "active_directory" {
  name     = "RG-Active-Directory"
  location = var.location
}

resource "azurerm_application_security_group" "ad_ds" {
  name                = "ASG-AD-DS"
  location            = azurerm_resource_group.active_directory.location
  resource_group_name = azurerm_resource_group.active_directory.name
}

resource "azurerm_network_security_group" "ad_ds" {
  name                = "NSG-AD-DS"
  location            = azurerm_resource_group.active_directory.location
  resource_group_name = azurerm_resource_group.active_directory.name

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

resource "azurerm_subnet" "ad_ds" {
  name                 = "AD-DS"
  resource_group_name  = var.virtual_network.resource_group_name
  virtual_network_name = var.virtual_network.name
  address_prefixes     = var.ad_ds_address_prefixes
}

resource "azurerm_subnet_network_security_group_association" "ad_ds" {
  subnet_id                 = azurerm_subnet.ad_ds.id
  network_security_group_id = azurerm_network_security_group.ad_ds.id
}