

## Resources

| Name | Type |
|------|------|
| [azurerm_firewall.firewall](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/firewall) | resource |
| [azurerm_public_ip.pip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_firewall_policy"></a> [firewall\_policy](#module\_firewall\_policy) | ./modules/FirewallPolicy | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_rule_collections"></a> [app\_rule\_collections](#input\_app\_rule\_collections) | (Required)Application rule collections and rules | <pre>map(object({<br>    name     = string,<br>    priority = number,<br>    action   = string,<br>    rules = map(object({<br>      name = string,<br>      protocols = map(object({<br>        protocol_type = string,<br>        port          = number,<br>      }))<br>      source_addresses = list(string)<br>      target_fqdns     = list(string)<br>    }))<br>  }))</pre> | <pre>{<br>  "key": {<br>    "action": null,<br>    "name": null,<br>    "priority": null,<br>    "rules": {<br>      "key": {<br>        "name": null,<br>        "protocols": {<br>          "key": {<br>            "port": null,<br>            "protocol_type": null<br>          }<br>        },<br>        "source_addresses": null,<br>        "target_fqdns": null<br>      }<br>    }<br>  }<br>}</pre> | no |
| <a name="input_application_priority"></a> [application\_priority](#input\_application\_priority) | (Required)Priority number for the application collection group | `number` | n/a | yes |
| <a name="input_firewall_name"></a> [firewall\_name](#input\_firewall\_name) | (Required)Name for the firewall | `string` | n/a | yes |
| <a name="input_firewall_policy_name"></a> [firewall\_policy\_name](#input\_firewall\_policy\_name) | (Required)Name for the firewall policy | `string` | n/a | yes |
| <a name="input_firewall_rule_collection_group_name"></a> [firewall\_rule\_collection\_group\_name](#input\_firewall\_rule\_collection\_group\_name) | (Required)Name for the firewall collection group | `string` | n/a | yes |
| <a name="input_ip_allocation"></a> [ip\_allocation](#input\_ip\_allocation) | (Optional)IP Allocation - Static or Dynamic | `string` | `"Static"` | no |
| <a name="input_location"></a> [location](#input\_location) | (Optional)The Location of the created resources | `string` | `"westeurope"` | no |
| <a name="input_nat_priority"></a> [nat\_priority](#input\_nat\_priority) | (Required)Priority number for the NAT collection group | `number` | n/a | yes |
| <a name="input_nat_rule_collections"></a> [nat\_rule\_collections](#input\_nat\_rule\_collections) | (Required)NAT rule collection and rules | <pre>map(object({<br>    name     = string,<br>    priority = number,<br>    action   = string,<br>    rules = map(object({<br>      name                = string,<br>      source_addresses    = list(string),<br>      destination_address = string,<br>      destination_ports   = list(string),<br>      translated_port     = string,<br>      translated_address  = string,<br>      protocols           = list(string)<br>    }))<br>  }))</pre> | <pre>{<br>  "key": {<br>    "action": null,<br>    "name": null,<br>    "priority": null,<br>    "rules": {<br>      "key": {<br>        "destination_address": null,<br>        "destination_ports": null,<br>        "name": null,<br>        "protocols": null,<br>        "source_addresses": null,<br>        "translated_address": null,<br>        "translated_port": null<br>      }<br>    }<br>  }<br>}</pre> | no |
| <a name="input_network_priority"></a> [network\_priority](#input\_network\_priority) | (Required)Priority number for the network collection group | `number` | n/a | yes |
| <a name="input_network_rule_collections"></a> [network\_rule\_collections](#input\_network\_rule\_collections) | (Required)Network rule collections and rules | <pre>map(object({<br>    name     = string,<br>    priority = number,<br>    action   = string,<br>    rules = map(object({<br>      name                  = string<br>      protocols             = list(string)<br>      source_addresses      = list(string)<br>      destination_addresses = list(string)<br>      destination_ports     = list(string)<br>    }))<br>  }))</pre> | <pre>{<br>  "key": {<br>    "action": null,<br>    "name": null,<br>    "priority": null,<br>    "rules": {<br>      "key": {<br>        "destination_addresses": null,<br>        "destination_ports": null,<br>        "name": null,<br>        "protocols": null,<br>        "source_addresses": null<br>      }<br>    }<br>  }<br>}</pre> | no |
| <a name="input_pip_sku"></a> [pip\_sku](#input\_pip\_sku) | (Optional) SKU for the azure firewall public IP | `string` | `"Standard"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required)Resource group name for the created resources | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | (Required)ID for the subnet of the firewall ip | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_firewall_policy"></a> [firewall\_policy](#output\_firewall\_policy) | Firewall policy |
| <a name="output_firewall_private_ip"></a> [firewall\_private\_ip](#output\_firewall\_private\_ip) | Firewall private IP |
| <a name="output_id"></a> [id](#output\_id) | Firewall ID |
| <a name="output_name"></a> [name](#output\_name) | Firewall name |
| <a name="output_object"></a> [object](#output\_object) | Firewall object |

## Example

```hcl
module "firewall" {
  source                              = "./modules/firewall"
  location                            = "westeurope"
  resource_group_name                 = "example-resource-group"
  firewall_name                       = "example-firewall-name"
  firewall_policy_name                = "example-firewall-policy"
  firewall_rule_collection_group_name = "example-rule-collection-group"
  subnet_id                           = "/subscriptions/xxx/resourceGroups/example-resource-group/providers/Microsoft.Network/virtualNetworks/example-virtual-network/subnets/AzureFirewallSubnet"
  network_priority                    = 101
  application_priority                = 102
  nat_priority                        = 103
  app_rule_collections                = {}
  network_rule_collections = {
    name     = "network_rule_collection1"
    priority = 105
    action   = "Deny"
    rule = {
      name                  = "network_rule_collection1_rule1"
      protocols             = ["TCP", "UDP"]
      source_addresses      = ["10.0.0.1"]
      destination_addresses = ["192.168.1.1", "192.168.1.2"]
      destination_ports     = ["80", "1000-2000"]
    }
  }
  nat_rule_collections = {}
}
```
