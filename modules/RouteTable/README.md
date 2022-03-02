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
| [azurerm_route_table.route_table](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route_table) | resource |
| [azurerm_subnet_route_table_association.subnet_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_route_table_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | (Optional)Location for the created resources | `string` | `"westeurope"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required)Resource group where the resources will be created | `string` | n/a | yes |
| <a name="input_route_table_name"></a> [route\_table\_name](#input\_route\_table\_name) | (Required)Route Table Name | `string` | n/a | yes |
| <a name="input_routes"></a> [routes](#input\_routes) | (Required)Routes for the route table | <pre>map(object({<br>    name           = string<br>    address_prefix = string<br>    next_hop_type  = string<br>    next_hop_ip    = optional(string)<br>  }))</pre> | <pre>{<br>  "next_hop_ip": null<br>}</pre> | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | (Required)The ID of the associated subnets | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | Route Table ID |
| <a name="output_name"></a> [name](#output\_name) | Route Table name |
| <a name="output_object"></a> [object](#output\_object) | Route Table Object |
<!-- END_TF_DOCS -->