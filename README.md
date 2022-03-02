# Final
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=2.96.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 2.97.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_hub_firewall"></a> [hub\_firewall](#module\_hub\_firewall) | ./modules/Firewall | n/a |
| <a name="module_hub_firewall_diagnostic_setting"></a> [hub\_firewall\_diagnostic\_setting](#module\_hub\_firewall\_diagnostic\_setting) | ./modules/DiagnosticSettings | n/a |
| <a name="module_hub_spoke_peering"></a> [hub\_spoke\_peering](#module\_hub\_spoke\_peering) | ./modules/TwoWayPeering | n/a |
| <a name="module_hub_virtual_machine"></a> [hub\_virtual\_machine](#module\_hub\_virtual\_machine) | ./modules/VM | n/a |
| <a name="module_hub_vm_diagnostic_setting"></a> [hub\_vm\_diagnostic\_setting](#module\_hub\_vm\_diagnostic\_setting) | ./modules/DiagnosticSettings | n/a |
| <a name="module_hub_vnet"></a> [hub\_vnet](#module\_hub\_vnet) | ./modules/Vnet | n/a |
| <a name="module_hub_vnet_diagnostic_setting"></a> [hub\_vnet\_diagnostic\_setting](#module\_hub\_vnet\_diagnostic\_setting) | ./modules/DiagnosticSettings | n/a |
| <a name="module_hub_vnet_gateway"></a> [hub\_vnet\_gateway](#module\_hub\_vnet\_gateway) | ./modules/VpnGateway | n/a |
| <a name="module_spoke_nsg"></a> [spoke\_nsg](#module\_spoke\_nsg) | ./modules/NSG | n/a |
| <a name="module_spoke_nsg_diagnostic_setting"></a> [spoke\_nsg\_diagnostic\_setting](#module\_spoke\_nsg\_diagnostic\_setting) | ./modules/DiagnosticSettings | n/a |
| <a name="module_spoke_virtual_machine"></a> [spoke\_virtual\_machine](#module\_spoke\_virtual\_machine) | ./modules/VM | n/a |
| <a name="module_spoke_vm_diagnostic_setting"></a> [spoke\_vm\_diagnostic\_setting](#module\_spoke\_vm\_diagnostic\_setting) | ./modules/DiagnosticSettings | n/a |
| <a name="module_spoke_vnet"></a> [spoke\_vnet](#module\_spoke\_vnet) | ./modules/Vnet | n/a |
| <a name="module_spoke_vnet_diagnostic_setting"></a> [spoke\_vnet\_diagnostic\_setting](#module\_spoke\_vnet\_diagnostic\_setting) | ./modules/DiagnosticSettings | n/a |
| <a name="module_storage_account"></a> [storage\_account](#module\_storage\_account) | ./modules/StorageAccount | n/a |
| <a name="module_to_hub_route_table"></a> [to\_hub\_route\_table](#module\_to\_hub\_route\_table) | ./modules/RouteTable | n/a |
| <a name="module_to_spoke_route_table"></a> [to\_spoke\_route\_table](#module\_to\_spoke\_route\_table) | ./modules/RouteTable | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_log_analytics_workspace.log_analytics_workspace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.spoke_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_audience"></a> [audience](#input\_audience) | (Required)The client id of the Azure VPN application | `string` | n/a | yes |
| <a name="input_issuer"></a> [issuer](#input\_issuer) | (Required)The STS url for the tenant | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | (Optional) Region for the created resources | `string` | `"westeurope"` | no |
| <a name="input_password"></a> [password](#input\_password) | (Required)Passowrd authentication | `string` | n/a | yes |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | (Required) The ID of the azure tenant | `string` | n/a | yes |
| <a name="input_vm_user"></a> [vm\_user](#input\_vm\_user) | (Required)User to connect the virtual machine | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->