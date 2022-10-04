variable "location" {
  type        = string
  default     = "westeurope"
  description = "Region in Azure for Active Directory"
}

variable "virtual_network" {
  type = object({
    id                  = string
    name                = string
    location            = string
    resource_group_name = string
  })
  description = "Virtual network for Active Directory"
}

variable "key_vault_id" {
  type        = string
  description = "ID of keyvault to store secrets"
}

variable "ad_ds_address_prefixes" {
  type        = list(string)
  default     = ["10.42.0.0/24"]
  description = "Address prefix for AD DS subnet"
}

variable "admin_username" {
  type        = string
  default     = "demogod"
  description = "Admin username"
}

variable "active_directory_netbios_name" {
  type        = string
  default     = "example"
  description = "NetBIOS name for Active Directory"
}

variable "active_directory_domain" {
  type        = string
  default     = "example.local"
  description = "Domain name for Active Directory"
}