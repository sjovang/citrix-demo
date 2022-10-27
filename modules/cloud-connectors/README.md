<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.0.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloud_connector"></a> [cloud\_connector](#module\_cloud\_connector) | ../terraform-azurerm-windows-vm | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_application_security_group.cloud_connector](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_security_group) | resource |
| [azurerm_availability_set.cloud_connectors](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/availability_set) | resource |
| [azurerm_network_security_group.cloud_connector](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_subnet.cloud_connector](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet_network_security_group_association.cloud_connector](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_virtual_machine_extension.cloud_connector](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ad_domain_name"></a> [ad\_domain\_name](#input\_ad\_domain\_name) | AD domain name for cloud connectors | `string` | `"example.local"` | no |
| <a name="input_ad_domainjoin_password"></a> [ad\_domainjoin\_password](#input\_ad\_domainjoin\_password) | AD domain join password | `string` | n/a | yes |
| <a name="input_ad_domainjoin_user"></a> [ad\_domainjoin\_user](#input\_ad\_domainjoin\_user) | AD domain join username | `string` | `"domainjoin@example.local"` | no |
| <a name="input_ad_ou_path"></a> [ad\_ou\_path](#input\_ad\_ou\_path) | OU path in AD for machine objects | `string` | `"OU=Computers,DC=example,DC=local"` | no |
| <a name="input_citrix_cloud_api_id"></a> [citrix\_cloud\_api\_id](#input\_citrix\_cloud\_api\_id) | Citrix Cloud API ID | `string` | n/a | yes |
| <a name="input_citrix_cloud_api_key"></a> [citrix\_cloud\_api\_key](#input\_citrix\_cloud\_api\_key) | Citrix Cloud API Key | `string` | n/a | yes |
| <a name="input_citrix_cloud_customer_id"></a> [citrix\_cloud\_customer\_id](#input\_citrix\_cloud\_customer\_id) | Citrix Cloud Customer ID | `string` | n/a | yes |
| <a name="input_citrix_cloud_resource_location_id"></a> [citrix\_cloud\_resource\_location\_id](#input\_citrix\_cloud\_resource\_location\_id) | Citrix Cloud Resource Location ID | `string` | n/a | yes |
| <a name="input_cloud_connectors_address_prefixes"></a> [cloud\_connectors\_address\_prefixes](#input\_cloud\_connectors\_address\_prefixes) | Address prefixes for cloud connectors subnet | `list(string)` | <pre>[<br>  "10.69.0.0/24"<br>]</pre> | no |
| <a name="input_key_vault_id"></a> [key\_vault\_id](#input\_key\_vault\_id) | Key vault ID for saving secrets | `string` | n/a | yes |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | Resource group for cloud connectors | <pre>object({<br>    name     = string<br>    location = string<br>  })</pre> | n/a | yes |
| <a name="input_virtual_network"></a> [virtual\_network](#input\_virtual\_network) | n/a | <pre>object({<br>    name                = string<br>    resource_group_name = string<br>  })</pre> | n/a | yes |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | VM size for cloud connectors | `string` | `"Standard_B2s"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->