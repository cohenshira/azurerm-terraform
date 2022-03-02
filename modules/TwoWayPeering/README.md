<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_virtual_network_peering.from_1_to_2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |
| [azurerm_virtual_network_peering.from_2_to_1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_forward_traffic_1"></a> [forward\_traffic\_1](#input\_forward\_traffic\_1) | (Optional) Controls if forwarded traffic from VMs in the remote virtual network is allowed | `bool` | `true` | no |
| <a name="input_forward_traffic_2"></a> [forward\_traffic\_2](#input\_forward\_traffic\_2) | (Optional) Controls if forwarded traffic from VMs in the remote virtual network is allowed | `bool` | `true` | no |
| <a name="input_gateway_transit_1"></a> [gateway\_transit\_1](#input\_gateway\_transit\_1) | (Required)Control gateway links | `bool` | n/a | yes |
| <a name="input_gateway_transit_2"></a> [gateway\_transit\_2](#input\_gateway\_transit\_2) | (Required)Control gateway links | `bool` | n/a | yes |
| <a name="input_peer_name_1"></a> [peer\_name\_1](#input\_peer\_name\_1) | (Required)Name for the first peer | `string` | n/a | yes |
| <a name="input_peer_name_2"></a> [peer\_name\_2](#input\_peer\_name\_2) | (Required)Name for the second peer | `string` | n/a | yes |
| <a name="input_remote_gateways_1"></a> [remote\_gateways\_1](#input\_remote\_gateways\_1) | (Required)Controls if remote gateways can be used on the local virtual network | `bool` | n/a | yes |
| <a name="input_remote_gateways_2"></a> [remote\_gateways\_2](#input\_remote\_gateways\_2) | (Required)Controls if remote gateways can be used on the local virtual network | `bool` | n/a | yes |
| <a name="input_resource_group_name_1"></a> [resource\_group\_name\_1](#input\_resource\_group\_name\_1) | (Required)Resource Group for the first peering resource | `string` | n/a | yes |
| <a name="input_resource_group_name_2"></a> [resource\_group\_name\_2](#input\_resource\_group\_name\_2) | (Required)Resource Group for the second peering resource | `string` | n/a | yes |
| <a name="input_vnet_id_1"></a> [vnet\_id\_1](#input\_vnet\_id\_1) | (Required)First Virtual Network ID | `string` | n/a | yes |
| <a name="input_vnet_id_2"></a> [vnet\_id\_2](#input\_vnet\_id\_2) | (Required)Second Virtual Network ID | `string` | n/a | yes |
| <a name="input_vnet_name_1"></a> [vnet\_name\_1](#input\_vnet\_name\_1) | (Required)First Virtual Network name | `string` | n/a | yes |
| <a name="input_vnet_name_2"></a> [vnet\_name\_2](#input\_vnet\_name\_2) | (Required)Second Virtual Network name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_peer_1"></a> [peer\_1](#output\_peer\_1) | First peering object |
| <a name="output_peer_1_id"></a> [peer\_1\_id](#output\_peer\_1\_id) | First peering ID |
| <a name="output_peer_1_name"></a> [peer\_1\_name](#output\_peer\_1\_name) | First peering name |
| <a name="output_peer_2"></a> [peer\_2](#output\_peer\_2) | Second peering object |
| <a name="output_peer_2_id"></a> [peer\_2\_id](#output\_peer\_2\_id) | Second peering ID |
| <a name="output_peer_2_name"></a> [peer\_2\_name](#output\_peer\_2\_name) | Second peering name |
<!-- END_TF_DOCS -->