variable "admin_user_object_id" {
  type        = string
  description = "The object ID of the user to grant access to the key vault"
}

variable "location" {
  type        = string
  default     = "westeurope"
  description = "Region in Azure for Active Directory"
}

variable "tenant_id" {
  type        = string
  description = "Tenant ID for Azure Active Directory"
}