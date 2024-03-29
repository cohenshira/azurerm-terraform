

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 2.97.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_storage_account.storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/2.97.0/docs/resources/storage_account) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_replication_type"></a> [account\_replication\_type](#input\_account\_replication\_type) | (Required) Type of replication for the storage account | `string` | n/a | yes |
| <a name="input_account_tier"></a> [account\_tier](#input\_account\_tier) | (Required) Tier to use for the storage account. Standard/Premuim | `string` | n/a | yes |
| <a name="input_is_manual_connection"></a> [is\_manual\_connection](#input\_is\_manual\_connection) | (Optional) Manual connection to the remote resource | `bool` | `false` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) Location for the created resources | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_id"></a> [log\_analytics\_workspace\_id](#input\_log\_analytics\_workspace\_id) | (Required) ID for the log analytics workspace for the storage account diagnostic setting | `string` | n/a | yes |
| <a name="input_network_link_name"></a> [network\_link\_name](#input\_network\_link\_name) | (Required) Virtual link name | `string` | n/a | yes |
| <a name="input_private_dns_zone_name"></a> [private\_dns\_zone\_name](#input\_private\_dns\_zone\_name) | (Required) Name for the dns zone | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) Resource group name for the created resources | `string` | n/a | yes |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | (Required) Storage account name | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | (Required) Subnet ID to for the private endpoint | `string` | n/a | yes |
| <a name="input_vnet_id"></a> [vnet\_id](#input\_vnet\_id) | (Required) Virtual network ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | Storage account ID |
| <a name="output_name"></a> [name](#output\_name) | Storage account name |
| <a name="output_object"></a> [object](#output\_object) | Storage account object |
| <a name="output_private_endpoint"></a> [private\_endpoint](#output\_private\_endpoint) | Storage account private endpoint |

## Usage

```hcl
module "storage_account" {
  source                   = "./modules/storage-account"

  storage_account_name     = "examplesa"
  resource_group_name      = "example-resource-group"
  location                 = "westeurope"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  is_manual_connection     = "false"
  subnet_id                = "/subscriptions/xxx/resourceGroups/example-resource-group/providers/Microsoft.Network/virtualNetworks/example-virtual-network/subnets/example-subnet"
  vnet_id                  = "/subscriptions/xxx/resourceGroups/example-resource-group/providers/Microsoft.Network/virtualNetworks/example-virtual-network"
  network_link_name        = "example-virtual-link"
}
```
