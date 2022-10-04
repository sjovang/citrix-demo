resource "azurerm_resource_group" "active_directory" {
    name = "RG-Active-Directory"
    location = var.location
}