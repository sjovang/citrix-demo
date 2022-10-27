Generic module to create Windows VMs in Azure with domain join

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.0.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.0.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault_secret.local_administrator_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_network_interface.vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_virtual_machine_extension.domainjoin](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |
| [azurerm_windows_virtual_machine.vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine) | resource |
| [random_password.local_administrator_account](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ad_domain_name"></a> [ad\_domain\_name](#input\_ad\_domain\_name) | AD domain name for cloud connectors | `string` | `"example.local"` | no |
| <a name="input_ad_domainjoin_password"></a> [ad\_domainjoin\_password](#input\_ad\_domainjoin\_password) | AD domain join password | `string` | n/a | yes |
| <a name="input_ad_domainjoin_user"></a> [ad\_domainjoin\_user](#input\_ad\_domainjoin\_user) | AD domain join username | `string` | `"domainjoin@example.local"` | no |
| <a name="input_ad_ou_path"></a> [ad\_ou\_path](#input\_ad\_ou\_path) | OU path in AD for machine objects | `string` | `"OU=Computers,DC=example,DC=local"` | no |
| <a name="input_availability_set_id"></a> [availability\_set\_id](#input\_availability\_set\_id) | ID of availability set for VM | `string` | `null` | no |
| <a name="input_caching"></a> [caching](#input\_caching) | Caching on OS-disk | `string` | `"ReadWrite"` | no |
| <a name="input_key_vault_id"></a> [key\_vault\_id](#input\_key\_vault\_id) | Key vault ID for saving secrets | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of VM | `string` | `"vm"` | no |
| <a name="input_password"></a> [password](#input\_password) | Password for local administrator account. Will be auto-generated if not set | `string` | `""` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | Resource group for cloud connectors | <pre>object({<br>    name     = string<br>    location = string<br>  })</pre> | n/a | yes |
| <a name="input_size"></a> [size](#input\_size) | VM size for cloud connectors | `string` | `"Standard_B2s"` | no |
| <a name="input_source_image_reference"></a> [source\_image\_reference](#input\_source\_image\_reference) | Source Image reference for VM | <pre>object({<br>    publisher = string<br>    offer     = string<br>    sku       = string<br>    version   = string<br>  })</pre> | <pre>{<br>  "offer": "WindowsServer",<br>  "publisher": "MicrosoftWindowsServer",<br>  "sku": "2022-Datacenter",<br>  "version": "latest"<br>}</pre> | no |
| <a name="input_storage_account_type"></a> [storage\_account\_type](#input\_storage\_account\_type) | Managed disk type | `string` | `"Standard_LRS"` | no |
| <a name="input_subnet"></a> [subnet](#input\_subnet) | Subnet for VM | <pre>object({<br>    id = string<br>  })</pre> | <pre>{<br>  "id": null<br>}</pre> | no |
| <a name="input_username"></a> [username](#input\_username) | Username for local administrator account | `string` | `"demogod"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_private_ip_address"></a> [private\_ip\_address](#output\_private\_ip\_address) | n/a |
| <a name="output_vm"></a> [vm](#output\_vm) | n/a |
<!-- END_TF_DOCS -->