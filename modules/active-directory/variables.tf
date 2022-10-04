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

variable "ad_ds_address_prefixes" {
  type        = list(string)
  default     = ["10.42.0.0/24"]
  description = "Address prefix for AD DS subnet"
}