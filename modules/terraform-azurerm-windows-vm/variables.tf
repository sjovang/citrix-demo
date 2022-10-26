variable "resource_group" {
  type = object({
    name     = string
    location = string
  })
  description = "Resource group for cloud connectors"
}

variable "subnet" {
  type = object({
    id = string
  })
  default = {
    id = null
  }
  description = "Subnet for VM"
}

variable "name" {
  type        = string
  default     = "vm"
  description = "Name of VM"
}

variable "username" {
  type        = string
  default     = "demogod"
  description = "Username for local administrator account"

  validation {
    condition     = lower(var.username) != "administrator"
    error_message = "\"Administrator\" is not allowed for username in Azure"
  }
}

variable "password" {
  type        = string
  default     = ""
  sensitive   = true
  description = "Password for local administrator account. Will be auto-generated if not set"
}

variable "availability_set_id" {
  type        = string
  default     = null
  description = "ID of availability set for VM"
}

variable "size" {
  type        = string
  description = "VM size for cloud connectors"
  default     = "Standard_B2s"
}

variable "caching" {
  type        = string
  default     = "ReadWrite"
  description = "Caching on OS-disk"
}

variable "storage_account_type" {
  type        = string
  default     = "Standard_LRS"
  description = "Managed disk type"
}

variable "source_image_reference" {
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  default = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }
  description = "Source Image reference for VM"
}

variable "ad_domain_name" {
  type        = string
  description = "AD domain name for cloud connectors"
  default     = "example.local"
}

variable "ad_ou_path" {
  type        = string
  description = "OU path in AD for machine objects"
  default     = "OU=Computers,DC=example,DC=local"
}

variable "ad_domainjoin_user" {
  type        = string
  description = "AD domain join username"
  default     = "domainjoin@example.local"
}

variable "ad_domainjoin_password" {
  type        = string
  sensitive   = true
  description = "AD domain join password"
}

variable "key_vault_id" {
  type        = string
  description = "Key vault ID for saving secrets"
}