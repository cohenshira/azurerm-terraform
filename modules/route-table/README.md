

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 2.97.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_route_table.route_table](https://registry.terraform.io/providers/hashicorp/azurerm/2.97.0/docs/resources/route_table) | resource |
| [azurerm_subnet_route_table_association.subnet_association](https://registry.terraform.io/providers/hashicorp/azurerm/2.97.0/docs/resources/subnet_route_table_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | (Required) Location for the created resources | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) Resource group where the resources will be created | `string` | n/a | yes |
| <a name="input_route_table_name"></a> [route\_table\_name](#input\_route\_table\_name) | (Required) Route Table Name | `string` | n/a | yes |
| <a name="input_routes"></a> [routes](#input\_routes) | (Required) Routes for the route table | <pre>map(object({<br>    name           = string<br>    address_prefix = string<br>    next_hop_type  = string<br>    next_hop_ip    = optional(string)<br>  }))</pre> | `{}` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | (Required) map of the subnets names and its ids to associate the route table | `map` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | Route Table ID |
| <a name="output_name"></a> [name](#output\_name) | Route Table name |
| <a name="output_object"></a> [object](#output\_object) | Route Table Object |

## Usage

```hcl
module "route-table" {
  source = "./modules/route-table"

  route_table_name    = "example-route-table"
  location            = "westeurope"
  resource_group_name = "example-resource-group"

  routes = {
    to_internet = {
      name           = "ToInternet",
      address_prefix = "0.0.0.0/0"
    }
  }
  subnets = {
    example_subnet = "/subscriptions/xxx/resourceGroups/example-resource-group/providers/Microsoft.Network/virtualNetworks/example-virtual-network/subnets/example-subnet"
  }
}
```
