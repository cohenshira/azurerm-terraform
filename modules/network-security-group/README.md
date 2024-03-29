

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 2.97.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_network_security_group.network_security_group](https://registry.terraform.io/providers/hashicorp/azurerm/2.97.0/docs/resources/network_security_group) | resource |
| [azurerm_network_security_rule.network_rules](https://registry.terraform.io/providers/hashicorp/azurerm/2.97.0/docs/resources/network_security_rule) | resource |
| [azurerm_subnet_network_security_group_association.subnet_association](https://registry.terraform.io/providers/hashicorp/azurerm/2.97.0/docs/resources/subnet_network_security_group_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | (Required) Location where the resources will be created | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_id"></a> [log\_analytics\_workspace\_id](#input\_log\_analytics\_workspace\_id) | (Required) ID for the log analytics workspace for the network security group diagnostic setting | `string` | n/a | yes |
| <a name="input_network_security_group_name"></a> [network\_security\_group\_name](#input\_network\_security\_group\_name) | (Required) Name for the Network security group | `string` | n/a | yes |
| <a name="input_network_security_group_rules"></a> [network\_security\_group\_rules](#input\_network\_security\_group\_rules) | (Required) Rules of the network security group, can be single or plural range/s and prefix/es | <pre>map(object({<br>    name                         = string<br>    priority                     = number<br>    direction                    = string<br>    access                       = string<br>    protocol                     = string<br>    source_port_range            = optional(string)<br>    source_port_ranges           = optional(list(string))<br>    destination_port_range       = optional(string)<br>    destination_port_ranges      = optional(list(string))<br>    source_address_prefix        = optional(string)<br>    source_address_prefixes      = optional(list(string))<br>    destination_address_prefix   = optional(string)<br>    destination_address_prefixes = optional(list(string))<br>  }))</pre> | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) Resource Group Name for the created resources | `string` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | (Required) map of subnets names and its ids to associate the network security group | `map(any)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | Network security group ID |
| <a name="output_name"></a> [name](#output\_name) | Network security group name |
| <a name="output_object"></a> [object](#output\_object) | Network security group object |

## Usage

```hcl
module "network-security-group" {
  source = "./modules/network-security-group"

  location                    = "westeurope"
  resource_group_name         = "example-resource-group"
  network_security_group_name = "example-network-security-group"
  network_security_group_rules = {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  subnets = {
    example_subnet = "/subscriptions/xxx/resourceGroups/example-resource-group/providers/Microsoft.Network/virtualNetworks/example-virtual-network/subnets/example-subnet"
  }
}
```
