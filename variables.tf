variable "location" {
  type        = string
  default     = "westeurope"
  description = "Region in Azure for demo resources"
}

variable "admin_user_upn" {
  type        = string
  description = "UserPrincipalName for admin user used in key vault access policy"
}

# Citrix Cloud
variable "citrix_cloud_api_id" {
  type        = string
  description = "Citrix Cloud API ID"
}

variable "citrix_cloud_api_key" {
  type        = string
  description = "Citrix Cloud API Key"
}

variable "citrix_cloud_customer_id" {
  type        = string
  description = "Citrix Cloud Customer ID"
}

variable "citrix_cloud_resource_location_id" {
  type        = string
  description = "Citrix Cloud Resource Location ID"
}