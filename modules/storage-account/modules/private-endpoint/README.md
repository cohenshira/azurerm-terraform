

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_private_dns_zone.private_dns_zone](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.network_link](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_endpoint.private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_is_manual_connection"></a> [is\_manual\_connection](#input\_is\_manual\_connection) | (Optional) Manual connection to the remote resource | `bool` | `false` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) Location for the created resources | `string` | n/a | yes |
| <a name="input_network_link_name"></a> [network\_link\_name](#input\_network\_link\_name) | (Required) Virtual link name | `string` | n/a | yes |
| <a name="input_private_dns_zone_name"></a> [private\_dns\_zone\_name](#input\_private\_dns\_zone\_name) | (Required) Name for the dns zone | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) Resource group name for the created resources | `string` | n/a | yes |
| <a name="input_resource_id"></a> [resource\_id](#input\_resource\_id) | (Required) Target Resource ID to associate the private connection | `string` | n/a | yes |
| <a name="input_resource_name"></a> [resource\_name](#input\_resource\_name) | (Required) Target Resource name to associate the private connection | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | (Required) Subnet ID to for the private endpoint | `string` | n/a | yes |
| <a name="input_vnet_id"></a> [vnet\_id](#input\_vnet\_id) | (Required) Virtual network ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | Private Endpoint ID |
| <a name="output_name"></a> [name](#output\_name) | Private Endpoint name |
| <a name="output_object"></a> [object](#output\_object) | Private Endpoint object |

## Usage

```hcl
module "private_endpoint" {
  source = "./modules/private-endpoint"

  resource_name         = "examplesa"
  resource_id           = "/subscriptions/xxx/resourceGroups/example-resource-group/providers/Microsoft.Network/virtualNetworks/example-virtual-network"
  resource_group_name   = "example-resource-group"
  location              = "westeurope"
  subnet_id             = "/subscriptions/xxx/resourceGroups/example-resource-group/providers/Microsoft.Network/virtualNetworks/example-virtual-network/subnets/example-subnet"
  vnet_id               = "/subscriptions/xxx/resourceGroups/example-resource-group/providers/Microsoft.Network/virtualNetworks/example-virtual-network"
  network_link_name     = "example-virtual-link"
  private_dns_zone_name = "storage-account-private-dns-zone"
}
```
