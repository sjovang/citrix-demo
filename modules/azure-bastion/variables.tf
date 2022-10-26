variable "virtual_network" {
  type = object({
    id                  = string
    name                = string
    location            = string
    resource_group_name = string
  })
  description = "Virtual network for Azure Bastion"
}

variable "resource_group" {
  type = object({
    name     = string
    location = string
  })
  description = "Resource group for Azure Bastion"
}