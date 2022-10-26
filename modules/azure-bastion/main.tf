resource "azurerm_subnet" "bastion" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = var.virtual_network.resource_group_name
  virtual_network_name = var.virtual_network.name
  address_prefixes     = ["10.69.7.0/24"]
}

resource "azurerm_public_ip" "bastion" {
  name                = "PIP-Bastion"
  location            = var.virtual_network.location
  resource_group_name = var.virtual_network.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "example" {
  name                = "examplebastion"
  location            = var.virtual_network.location
  resource_group_name = var.virtual_network.resource_group_name
  sku                 = "Standard"
  tunneling_enabled   = true
  file_copy_enabled   = true

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.bastion.id
    public_ip_address_id = azurerm_public_ip.bastion.id
  }
}