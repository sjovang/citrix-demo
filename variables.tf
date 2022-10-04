variable "location" {
  type        = string
  default     = "westeurope"
  description = "Region in Azure for demo resources"
}

variable "admin_user_upn" {
  type        = string
  description = "UserPrincipalName for admin user used in key vault access policy"
}