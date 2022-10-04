resource "azurerm_resource_group" "network" {
  name     = "RG-Citrix-Network"
  location = var.location
}

resource "azurerm_virtual_network" "active_directory" {
  name                = "VNET-Active-Directory"
  location            = azurerm_resource_group.network.location
  resource_group_name = azurerm_resource_group.network.name
  address_space       = ["10.42.0.0/16"]
  dns_servers = [
    "10.42.0.4"
  ]
}

resource "azurerm_virtual_network" "citrix" {
  name                = "VNET-Citrix"
  location            = azurerm_resource_group.network.location
  resource_group_name = azurerm_resource_group.network.name
  address_space       = ["10.69.0.0/21"]
  dns_servers = [
    "10.42.0.4"
  ]
}

resource "azurerm_virtual_network_peering" "ad_citrix" {
  name                      = "AD-Citrix"
  resource_group_name       = azurerm_resource_group.network.name
  virtual_network_name      = azurerm_virtual_network.active_directory.name
  remote_virtual_network_id = azurerm_virtual_network.citrix.id
}

resource "azurerm_virtual_network_peering" "citrix_ad" {
  name                      = "Citrix-AD"
  resource_group_name       = azurerm_resource_group.network.name
  virtual_network_name      = azurerm_virtual_network.citrix.name
  remote_virtual_network_id = azurerm_virtual_network.active_directory.id
}