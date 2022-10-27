# Citrix Demo with Terraform

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.3.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | 2.29.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 3.28.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | 2.29.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.28.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_active_directory"></a> [active\_directory](#module\_active\_directory) | ./modules/active-directory | n/a |
| <a name="module_azure_bastion"></a> [azure\_bastion](#module\_azure\_bastion) | ./modules/azure-bastion | n/a |
| <a name="module_cloud_connectors"></a> [cloud\_connectors](#module\_cloud\_connectors) | ./modules/cloud-connectors | n/a |
| <a name="module_key_vault"></a> [key\_vault](#module\_key\_vault) | ./modules/keyvault | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.cloud_connectors](https://registry.terraform.io/providers/hashicorp/azurerm/3.28.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.network](https://registry.terraform.io/providers/hashicorp/azurerm/3.28.0/docs/resources/resource_group) | resource |
| [azurerm_virtual_network.active_directory](https://registry.terraform.io/providers/hashicorp/azurerm/3.28.0/docs/resources/virtual_network) | resource |
| [azurerm_virtual_network.citrix](https://registry.terraform.io/providers/hashicorp/azurerm/3.28.0/docs/resources/virtual_network) | resource |
| [azurerm_virtual_network_peering.ad_citrix](https://registry.terraform.io/providers/hashicorp/azurerm/3.28.0/docs/resources/virtual_network_peering) | resource |
| [azurerm_virtual_network_peering.citrix_ad](https://registry.terraform.io/providers/hashicorp/azurerm/3.28.0/docs/resources/virtual_network_peering) | resource |
| [azuread_user.admin_account](https://registry.terraform.io/providers/hashicorp/azuread/2.29.0/docs/data-sources/user) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/3.28.0/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_user_upn"></a> [admin\_user\_upn](#input\_admin\_user\_upn) | UserPrincipalName for admin user used in key vault access policy | `string` | n/a | yes |
| <a name="input_citrix_cloud_api_id"></a> [citrix\_cloud\_api\_id](#input\_citrix\_cloud\_api\_id) | Citrix Cloud API ID | `string` | n/a | yes |
| <a name="input_citrix_cloud_api_key"></a> [citrix\_cloud\_api\_key](#input\_citrix\_cloud\_api\_key) | Citrix Cloud API Key | `string` | n/a | yes |
| <a name="input_citrix_cloud_customer_id"></a> [citrix\_cloud\_customer\_id](#input\_citrix\_cloud\_customer\_id) | Citrix Cloud Customer ID | `string` | n/a | yes |
| <a name="input_citrix_cloud_resource_location_id"></a> [citrix\_cloud\_resource\_location\_id](#input\_citrix\_cloud\_resource\_location\_id) | Citrix Cloud Resource Location ID | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Region in Azure for demo resources | `string` | `"westeurope"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->