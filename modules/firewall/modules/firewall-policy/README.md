

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 2.97.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_firewall_policy.firewall_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.97.0/docs/resources/firewall_policy) | resource |
| [azurerm_firewall_policy_rule_collection_group.firewall_application_rule_collection_group](https://registry.terraform.io/providers/hashicorp/azurerm/2.97.0/docs/resources/firewall_policy_rule_collection_group) | resource |
| [azurerm_firewall_policy_rule_collection_group.firewall_nat_rule_collection_group](https://registry.terraform.io/providers/hashicorp/azurerm/2.97.0/docs/resources/firewall_policy_rule_collection_group) | resource |
| [azurerm_firewall_policy_rule_collection_group.firewall_network_rule_collection_group](https://registry.terraform.io/providers/hashicorp/azurerm/2.97.0/docs/resources/firewall_policy_rule_collection_group) | resource |

## Modules

No modules.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_rule_collection_groups"></a> [application\_rule\_collection\_groups](#input\_application\_rule\_collection\_groups) | (Required) Application rule collection groups and rules | <pre>map(object({<br>    name                         = string,<br>    priority                     = number,<br>    application_rule_collections = map(object({<br>      name     = string,<br>      priority = number,<br>      action   = string,<br>      rules    = map(object({<br>        name             = string,<br>        protocols        = map(object({<br>          protocol_type = string,<br>          port          = number,<br>        }))<br>        source_addresses = list(string)<br>        target_fqdns     = list(string)<br>      }))<br>    }))<br>  }))</pre> | `{}` | no |
| <a name="input_firewall_policy_name"></a> [firewall\_policy\_name](#input\_firewall\_policy\_name) | (Required) Name for the firewall policy | `string` | n/a | yes |
| <a name="input_firewall_public_ip"></a> [firewall\_public\_ip](#input\_firewall\_public\_ip) | Firewall public IP address | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | (Required) The Location of the created resources | `string` | n/a | yes |
| <a name="input_nat_rule_collection_groups"></a> [nat\_rule\_collection\_groups](#input\_nat\_rule\_collection\_groups) | (Required) NAT rule collectio groups and rules | <pre>map(object({<br>    name                 = string,<br>    priority             = number,<br>    nat_rule_collections = map(object({<br>      name     = string,<br>      priority = number,<br>      action   = string,<br>      rules    = map(object({<br>        name                = string,<br>        source_addresses    = list(string),<br>        destination_address = optional(string),<br>        destination_ports   = list(string),<br>        translated_port     = string,<br>        translated_address  = string,<br>        protocols           = list(string)<br>      }))<br>    }))<br>  }))</pre> | `{}` | no |
| <a name="input_network_rule_collection_groups"></a> [network\_rule\_collection\_groups](#input\_network\_rule\_collection\_groups) | (Required) Network rule collection groups and rules | <pre>map(object({<br>    name                     = string,<br>    priority                 = number,<br>    network_rule_collections = map(object({<br>      name     = string,<br>      priority = number,<br>      action   = string,<br>      rules    = map(object({<br>        name                  = string<br>        protocols             = list(string)<br>        source_addresses      = list(string)<br>        destination_addresses = list(string)<br>        destination_ports     = list(string)<br>      }))<br>    }))<br>  }))</pre> | `{}` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) Resource group name for the created resources | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | Firewall policy ID |
| <a name="output_name"></a> [name](#output\_name) | Firewall policy name |
| <a name="output_object"></a> [object](#output\_object) | Firewall policy object |

## Usage

```hcl
module "firewall_policy" {
  source = "./modules/firewall-policy"

  location                   = "westeurope"
  resource_group_name        = "example-resource-group"
  firewall_policy_name       = "example-firewall-policy"
  app_rule_collection_groups = {
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

  nat_rule_collection_groups = {
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
          protocols             = ["TCP"]
          source_addresses      = ["10.0.0.1"]
          destination_addresses = ["192.168.1.1", "192.168.1.2"]
          destination_ports     = ["80"]
        }
      }
    }
  }

  firewall_public_ip = azurerm_public_ip.pip.ip_address
}
```
