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

resource "random_password" "local_administrator_password" {
  length  = 32
  special = false
}

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
    name              = "in_allow_ad_tcp"
    priority          = 100
    direction         = "Inbound"
    access            = "Allow"
    protocol          = "Tcp"
    source_port_range = "*"
    destination_port_ranges = [
      "53",
      "88",
      "135",
      "139",
      "389",
      "445",
      "464",
      "636",
      "3268-3269",
      "40152-65535",
    ]
    source_address_prefix = "VirtualNetwork"
    destination_application_security_group_ids = [
      azurerm_application_security_group.ad_ds.id
    ]
  }

  security_rule {
    name              = "in_allow_ad_udp"
    priority          = 110
    direction         = "Inbound"
    access            = "Allow"
    protocol          = "Udp"
    source_port_range = "*"
    destination_port_ranges = [
      "53",
      "88",
      "123",
      "389",
      "464",
    ]
    source_address_prefix = "VirtualNetwork"
    destination_application_security_group_ids = [
      azurerm_application_security_group.ad_ds.id
    ]
  }

  security_rule {
    name              = "in_allow_rdp_mgmt"
    priority          = 1000
    direction         = "Inbound"
    access            = "Allow"
    protocol          = "*"
    source_port_range = "*"
    destination_port_ranges = [
      "3389",
    ]
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

// Create domain controller VM
resource "azurerm_network_interface" "dc" {
  name                = "NIC-DC1"
  resource_group_name = azurerm_resource_group.active_directory.name
  location            = azurerm_resource_group.active_directory.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.ad_ds.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface_application_security_group_association" "dc_asg" {
  network_interface_id          = azurerm_network_interface.dc.id
  application_security_group_id = azurerm_application_security_group.ad_ds.id
}

resource "azurerm_windows_virtual_machine" "dc" {
  name                = "VM-DC1"
  resource_group_name = azurerm_resource_group.active_directory.name
  location            = azurerm_resource_group.active_directory.location
  size                = "Standard_B2ms"
  admin_username      = var.admin_username
  admin_password      = random_password.local_administrator_password.result

  network_interface_ids = [
    azurerm_network_interface.dc.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }
}

locals {
  import_command       = "Import-Module ADDSDeployment"
  password_command     = "$password = ConvertTo-SecureString ${random_password.local_administrator_password.result} -AsPlainText -Force"
  install_ad_command   = "Install-WindowsFeature -Name AD-Domain-Services,DNS -IncludeManagementTools"
  configure_ad_command = "Install-ADDSForest -CreateDnsDelegation:$false -DomainName ${var.active_directory_domain} -DomainNetbiosName ${var.active_directory_netbios_name} -InstallDns:$true -SafeModeAdministratorPassword $password -Force:$true"
  powershell_command   = "${local.import_command}; ${local.password_command}; ${local.install_ad_command}; ${local.configure_ad_command}; shutdown -r -t 60; exit 0"
}

resource "azurerm_virtual_machine_extension" "create_active_directory_forest" {
  name                       = "active-directory-forest"
  virtual_machine_id         = azurerm_windows_virtual_machine.dc.id
  publisher                  = "Microsoft.Compute"
  type                       = "CustomScriptExtension"
  type_handler_version       = "1.10"
  auto_upgrade_minor_version = true

  settings = <<SETTINGS
  {
      "commandToExecute": "powershell.exe -Command \"${local.powershell_command}\""
  }
  SETTINGS
}

resource "azurerm_key_vault_secret" "local_administrator_account" {
  name         = "VM-DC1-${var.admin_username}"
  key_vault_id = var.key_vault_id
  value        = random_password.local_administrator_password.result
}

/*
  This is a bad idea, but sufficient for a demo. Provisioners should always be used as a last resort.
  We need to create an OU to domain join our VMs as the ADDomainJoinExtension cannot use OU=Computers

  In a real environment you should use ad_ou from hashicorp/ad, but that would require terraform to run with connectivity to the domain controller
*/
resource "null_resource" "create_ou" {
  depends_on = [
    azurerm_virtual_machine_extension.create_active_directory_forest
  ]

  provisioner "local-exec" {
    command = "az vm run-command invoke --command-id RunPowerShellScript -g ${azurerm_resource_group.active_directory.name} --name ${azurerm_windows_virtual_machine.dc.name} --scripts 'Import-Module ADDSDeployment; New-ADOrganizationalUnit -Name Citrix-Demo -Path \"DC=${var.active_directory_netbios_name},DC=${split(".", var.active_directory_domain)[1]}\"'"
  }
}