

## Resources

| Name | Type |
|------|------|
| [azurerm_public_ip.pip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_virtual_network_gateway.gateway](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_gateway) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_active_active"></a> [active\_active](#input\_active\_active) | (Optional)if value equals true, an active-active vpn gateway will be created. Else, an active-standby vpn gateway will be created | `bool` | `false` | no |
| <a name="input_audience"></a> [audience](#input\_audience) | (Required)The client id of the Azure VPN application | `string` | n/a | yes |
| <a name="input_auth_type"></a> [auth\_type](#input\_auth\_type) | (Optional) Authentication types to the gateway | `list(string)` | <pre>[<br>  "AAD"<br>]</pre> | no |
| <a name="input_client_address_space"></a> [client\_address\_space](#input\_client\_address\_space) | (Required)Addres space for the VPN client | `list(string)` | n/a | yes |
| <a name="input_client_protocols"></a> [client\_protocols](#input\_client\_protocols) | (Optional)VPN client protocols | `list(string)` | <pre>[<br>  "OpenVPN"<br>]</pre> | no |
| <a name="input_enable_bgp"></a> [enable\_bgp](#input\_enable\_bgp) | (Optional)Enabling border gateway protocol | `bool` | `false` | no |
| <a name="input_gateway_name"></a> [gateway\_name](#input\_gateway\_name) | (Required)Name for the Virtual Network Gateway | `string` | n/a | yes |
| <a name="input_gateway_sku"></a> [gateway\_sku](#input\_gateway\_sku) | (Optional)Gateway SKU | `string` | `"Standard"` | no |
| <a name="input_gateway_type"></a> [gateway\_type](#input\_gateway\_type) | (Optional)Gateway Type | `string` | `"Vpn"` | no |
| <a name="input_generation"></a> [generation](#input\_generation) | (Optional)Virtual network Gateway generation | `string` | `"Generation1"` | no |
| <a name="input_ip_allocation"></a> [ip\_allocation](#input\_ip\_allocation) | (Optional)IP Allocation type - Static or Dynamic | `string` | `"Dynamic"` | no |
| <a name="input_issuer"></a> [issuer](#input\_issuer) | (Required)The STS url for the tenant | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | (Required)Location for the created resouorces | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required)Resource group name for the created resources | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | (Required)Gateway Subnet ID | `string` | n/a | yes |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | (Required)ID of the azure tenant | `string` | n/a | yes |
| <a name="input_vpn_type"></a> [vpn\_type](#input\_vpn\_type) | (Optional)Vpn Type | `string` | `"RouteBased"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_name"></a> [name](#output\_name) | n/a |
| <a name="output_object"></a> [object](#output\_object) | n/a |

## Example

```hcl
module "vpn-gateway" {
  source               = "./modules/vpn-gateway"
  location             = "westeurope"
  resource_group_name  = "example-resource-group"
  gateway_name         = "example-virtual-network-gateway"
  subnet_id            = "/subscriptions/xxx/resourceGroups/example-resource-group/providers/Microsoft.Network/virtualNetworks/example-virtual-network/subnets/GatewaySubnet"
  client_address_space = "[172.2.0.0/16]"
  auth_type            = ["AAD"]
  tenant_id            = "https://login.microsoftonline.com/xxx"
  audience             = "n7h67gtbybt76h7666rt5676ttt"
  issuer               = "https://sts.windows.net/xxx/"
}
```
