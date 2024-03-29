

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 2.97.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_subnet.subnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.97.0/docs/resources/subnet) | resource |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.97.0/docs/resources/virtual_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enforce_private_link_endpoint_network_policies"></a> [enforce\_private\_link\_endpoint\_network\_policies](#input\_enforce\_private\_link\_endpoint\_network\_policies) | if value is true, private link endpoint will be enabled on this virtual network | `bool` | `true` | no |
| <a name="input_location"></a> [location](#input\_location) | (Optional) Region for the created resources | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_id"></a> [log\_analytics\_workspace\_id](#input\_log\_analytics\_workspace\_id) | (Required) ID for the log analytics workspace for the vnet diagnostic setting | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) Resource Group Name | `string` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | (Required) Subnets list to create | <pre>map(object({<br>    name             = string<br>    address_prefixes = list(string)<br>  }))</pre> | n/a | yes |
| <a name="input_vnet_address_space"></a> [vnet\_address\_space](#input\_vnet\_address\_space) | (Required) Address Space For Virtual Network | `list(string)` | n/a | yes |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | (Required) Name for the virtual network | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_created_subnets"></a> [created\_subnets](#output\_created\_subnets) | Map of each subnet name and subnet ID |
| <a name="output_id"></a> [id](#output\_id) | Virtual Network ID |
| <a name="output_name"></a> [name](#output\_name) | Virtual Network name |
| <a name="output_object"></a> [object](#output\_object) | Virtual Network object |
| <a name="output_subnet"></a> [subnet](#output\_subnet) | Subnet object |
| <a name="output_subnet_ids_list"></a> [subnet\_ids\_list](#output\_subnet\_ids\_list) | List of the subnet ids |
| <a name="output_vnet_address_prefix"></a> [vnet\_address\_prefix](#output\_vnet\_address\_prefix) | Virtual Network address space |

## Usage

```hcl
module "virtual_network" {
  source = "./modules/virtual-network"

  location            = "westeurope"
  resource_group_name = "example-resource-group"
  vnet_name           = "example-vnet"
  vnet_address_space  = "10.0.0.0/16"

  subnets = {
    example_subnet = {
      name             = "example-subnet"
      address_prefixes = ["10.0.0.0/24"]
    }
  }
}
```
