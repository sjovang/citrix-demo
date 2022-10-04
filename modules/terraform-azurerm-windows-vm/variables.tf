variable "resource_group" {
  type = object({
    name     = string
    location = string
  })
  description = "Resource group for cloud connectors"
}

variable "vm_size" {
  type        = string
  description = "VM size for cloud connectors"
  default     = "Standard_B2s"
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