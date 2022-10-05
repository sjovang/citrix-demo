terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.0.0"
    }
  }
}

resource "random_password" "local_administrator_account" {
  length  = 32
  special = false
}

resource "azurerm_network_interface" "vm" {
  name                = var.name
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "vm" {
  name                = var.name
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
  size                = var.size
  admin_username      = var.username
  admin_password      = var.password == "" ? random_password.local_administrator_account.result : var.password
  availability_set_id = var.availability_set_id

  network_interface_ids = [
    azurerm_network_interface.vm.id
  ]

  os_disk {
    caching              = var.caching
    storage_account_type = var.storage_account_type
  }

  source_image_reference {
    publisher = var.source_image_reference.publisher
    offer     = var.source_image_reference.offer
    sku       = var.source_image_reference.sku
    version   = var.source_image_reference.version
  }
}

resource "azurerm_virtual_machine_extension" "domainjoin" {
  name                       = "${var.name}-domainjoin"
  virtual_machine_id         = azurerm_windows_virtual_machine.vm.id
  publisher                  = "Microsoft.Compute"
  type                       = "JsonADDomainExtension"
  type_handler_version       = "1.3"
  auto_upgrade_minor_version = true

  settings = jsonencode(
    {
      Name    = var.ad_domain_name
      OUPath  = var.ad_ou_path
      User    = var.ad_domainjoin_user
      Restart = "true"
      Options = "3"
    }
  )

  protected_settings = jsonencode(
    {
      Password = var.ad_domainjoin_password
    }
  )

  lifecycle {
    ignore_changes = [
      protected_settings,
      settings,
    ]
  }
}

resource "azurerm_key_vault_secret" "local_administrator_account" {
  name         = var.name
  key_vault_id = var.key_vault_id
  value        = var.password == "" ? random_password.local_administrator_account.result : var.password
}