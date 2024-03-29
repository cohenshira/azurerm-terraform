

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 2.97.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_firewall.firewall](https://registry.terraform.io/providers/hashicorp/azurerm/2.97.0/docs/resources/firewall) | resource |
| [azurerm_public_ip.pip](https://registry.terraform.io/providers/hashicorp/azurerm/2.97.0/docs/resources/public_ip) | resource |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_firewall_diagnostic_setting"></a> [firewall\_diagnostic\_setting](#module\_firewall\_diagnostic\_setting) | ../diagnostic-settings | n/a |
| <a name="module_firewall_policy"></a> [firewall\_policy](#module\_firewall\_policy) | ./modules/firewall-policy | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_rule_collection_groups"></a> [application\_rule\_collection\_groups](#input\_application\_rule\_collection\_groups) | (Required) Application rule collection groups and rules | <pre>map(object({<br>    name                         = string,<br>    priority                     = number,<br>    application_rule_collections = map(object({<br>      name     = string,<br>      priority = number,<br>      action   = string,<br>      rules    = map(object({<br>        name             = string,<br>        protocols        = map(object({<br>          protocol_type = string,<br>          port          = number,<br>        }))<br>        source_addresses = list(string)<br>        target_fqdns     = list(string)<br>      }))<br>    }))<br>  }))</pre> | `{}` | no |
| <a name="input_firewall_name"></a> [firewall\_name](#input\_firewall\_name) | (Required) Name for the firewall | `string` | n/a | yes |
| <a name="input_firewall_policy_name"></a> [firewall\_policy\_name](#input\_firewall\_policy\_name) | (Required) Name for the firewall policy | `string` | n/a | yes |
| <a name="input_ip_allocation"></a> [ip\_allocation](#input\_ip\_allocation) | (Optional) IP Allocation - Static or Dynamic | `string` | `"Static"` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) The Location of the created resources | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_id"></a> [log\_analytics\_workspace\_id](#input\_log\_analytics\_workspace\_id) | (Required) ID for the log analytics workspace for the firewall diagnostic setting | `string` | n/a | yes |
| <a name="input_nat_rule_collection_groups"></a> [nat\_rule\_collection\_groups](#input\_nat\_rule\_collection\_groups) | (Required) NAT rule collectio groups and rules | <pre>map(object({<br>    name                 = string,<br>    priority             = number,<br>    nat_rule_collections = map(object({<br>      name     = string,<br>      priority = number,<br>      action   = string,<br>      rules    = map(object({<br>        name                = string,<br>        source_addresses    = list(string),<br>        destination_address = optional(string),<br>        destination_ports   = list(string),<br>        translated_port     = string,<br>        translated_address  = string,<br>        protocols           = list(string)<br>      }))<br>    }))<br>  }))</pre> | `{}` | no |
| <a name="input_network_rule_collection_groups"></a> [network\_rule\_collection\_groups](#input\_network\_rule\_collection\_groups) | (Required) Network rule collection groups and rules | <pre>map(object({<br>    name                     = string,<br>    priority                 = number,<br>    network_rule_collections = map(object({<br>      name     = string,<br>      priority = number,<br>      action   = string,<br>      rules    = map(object({<br>        name                  = string<br>        protocols             = list(string)<br>        source_addresses      = list(string)<br>        destination_addresses = list(string)<br>        destination_ports     = list(string)<br>      }))<br>    }))<br>  }))</pre> | `{}` | no |
| <a name="input_pip_sku"></a> [pip\_sku](#input\_pip\_sku) | (Optional) SKU for the azure firewall public IP | `string` | `"Standard"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) Resource group name for the created resources | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | (Required) ID of the subnet for the firewall | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_firewall_policy"></a> [firewall\_policy](#output\_firewall\_policy) | Firewall policy |
| <a name="output_firewall_private_ip"></a> [firewall\_private\_ip](#output\_firewall\_private\_ip) | Firewall private IP |
| <a name="output_firewall_public_ip"></a> [firewall\_public\_ip](#output\_firewall\_public\_ip) | Firewall public IP |
| <a name="output_id"></a> [id](#output\_id) | Firewall ID |
| <a name="output_name"></a> [name](#output\_name) | Firewall name |
| <a name="output_object"></a> [object](#output\_object) | Firewall object |

## Usage

```hcl
module "firewall" {
  source = "./modules/firewall"

  location                       = "westeurope"
  resource_group_name            = "example-resource-group"
  firewall_name                  = "example-firewall-name"
  firewall_policy_name           = "example-firewall-policy"
  subnet_id                      = "/subscriptions/xxx/resourceGroups/example-resource-group/providers/Microsoft.Network/virtualNetworks/example-virtual-network/subnets/AzureFirewallSubnet"
  app_rule_collection_groups     = {
    name     = "application_rule_collection_group"
    priority = 102

    application_rule_collections = {
      example-application-rule-collection = {
        name     = "example-application-rule-collection"
        priority = 103
        action   = "Allow"

        rules = {
          allow-http = {
            name             = "AllowHttp"
            source_addresses = "10.0.0.0/16"
            target_fqdns     = "*.micrrosoft.com"
            protocols        = {
              http = {
                protocol_type = "Http"
                port          = 80
              }
            }
          }
        }
      }
    }
  }
  network_rule_collection_groups = {
    name     = "network_rule_collection_group"
    priority = 105

    network_rule_collections = {
      example-network_rule_collection = {
        name     = "example-network_rule_collection"
        priority = 106
        action   = "Allow"
        rule     = {
          name                  = "allowHttp"
          protocols             = ["TCP", "UDP"]
          source_addresses      = ["10.0.0.1"]
          destination_addresses = ["192.168.1.1", "192.168.1.2"]
          destination_ports     = ["80"]
        }
      }
    }
  }
  nat_rule_collection_groups     = {
    name     = "nat-rule-collection-group"
    priority = 300

    nat_rule_collections = {
      example-nat-nat_rule_collection = {
        name     = "example-nat-rule-collection"
        priority = 301
        action   = "Dnat"

        rules = {
          nat_rule = {
            name               = "nat-rule"
            protocols          = ["TCP"]
            source_addresses   = ["*"]
            destination_ports  = ["80"]
            translated_port    = "8080"
            translated_address = "10.0.0.5"
          }
        }

      }
    }
  }
}
```
