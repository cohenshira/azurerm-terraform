

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 2.97.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_linux_virtual_machine.linux_vm](https://registry.terraform.io/providers/hashicorp/azurerm/2.97.0/docs/resources/linux_virtual_machine) | resource |
| [azurerm_managed_disk.data_disk](https://registry.terraform.io/providers/hashicorp/azurerm/2.97.0/docs/resources/managed_disk) | resource |
| [azurerm_network_interface.vm_network_interface](https://registry.terraform.io/providers/hashicorp/azurerm/2.97.0/docs/resources/network_interface) | resource |
| [azurerm_public_ip.vm_public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/2.97.0/docs/resources/public_ip) | resource |
| [azurerm_virtual_machine_data_disk_attachment.data_disk_attachment](https://registry.terraform.io/providers/hashicorp/azurerm/2.97.0/docs/resources/virtual_machine_data_disk_attachment) | resource |
| [azurerm_windows_virtual_machine.windows_vm](https://registry.terraform.io/providers/hashicorp/azurerm/2.97.0/docs/resources/windows_virtual_machine) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_caching"></a> [caching](#input\_caching) | (Optional) Caching type for the internal OS disk. Can be ReadWrite, ReadOnly or None | `string` | `"Readwrite"` | no |
| <a name="input_data_disks"></a> [data\_disks](#input\_data\_disks) | (Optional) map of data disk to add to the virtual machine | <pre>map(object({<br>    name                 = string<br>    storage_account_type = string<br>    create_option        = string<br>    disk_size_gb         = string<br>    caching              = optional(string)<br>  }))</pre> | `{}` | no |
| <a name="input_disable_password_authentication"></a> [disable\_password\_authentication](#input\_disable\_password\_authentication) | (Optional) Disabling Password authentication - true or false | `bool` | `false` | no |
| <a name="input_hostname"></a> [hostname](#input\_hostname) | (Required) Name For The Virtual Machine | `string` | n/a | yes |
| <a name="input_image_sku"></a> [image\_sku](#input\_image\_sku) | (Required) Image SKU for the the image source | `string` | n/a | yes |
| <a name="input_image_version"></a> [image\_version](#input\_image\_version) | (Optional) Image version | `string` | `"latest"` | no |
| <a name="input_ip_allocation"></a> [ip\_allocation](#input\_ip\_allocation) | (Optional) IP Allocation - Static or Dynamic | `string` | `"Dynamic"` | no |
| <a name="input_is_linux"></a> [is\_linux](#input\_is\_linux) | (Required) If value eauals true, a linux machine will be created.Else, a windows machine will be created | `bool` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | (Required) Location for the created resources | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_id"></a> [log\_analytics\_workspace\_id](#input\_log\_analytics\_workspace\_id) | (Required) ID for the log analytics workspace for the virtual machine diagnostic setting | `string` | n/a | yes |
| <a name="input_offer"></a> [offer](#input\_offer) | (Required) Offer of the image | `string` | n/a | yes |
| <a name="input_password"></a> [password](#input\_password) | (Required) user password for connecting the virtual machine | `string` | n/a | yes |
| <a name="input_pip_sku"></a> [pip\_sku](#input\_pip\_sku) | (Optional) SKU for the public IP | `string` | `"Basic"` | no |
| <a name="input_publisher"></a> [publisher](#input\_publisher) | (Required) Publisher of the image | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) Resource group name for the created resources | `string` | n/a | yes |
| <a name="input_storage_account_type"></a> [storage\_account\_type](#input\_storage\_account\_type) | (Optional) Type of sku redundancy for the OS disk | `string` | `"Standard_LRS"` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | (Required) ID of the subnet used in the network interface creation | `string` | n/a | yes |
| <a name="input_username"></a> [username](#input\_username) | (Required) Username for connecting the virtual machine | `string` | n/a | yes |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | (Required) size for the VM in sku | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | Virtual machine ID |
| <a name="output_name"></a> [name](#output\_name) | Virtual machine name |
| <a name="output_object"></a> [object](#output\_object) | Virtual machine object |
| <a name="output_private_ip"></a> [private\_ip](#output\_private\_ip) | Virtual Machine private IP address |

## Usage

```hcl
module "virtual_machine" {
  source = "./modules/vm"

  location             = "westeurope"
  resource_group_name  = "example-resource-group"
  is_linux             = true
  subnet_id            = "/subscriptions/xxx/resourceGroups/example-resource-group/providers/Microsoft.Network/virtualNetworks/example-virtual-network/subnets/example-subnet"
  hostname             = "example-virtual-machine"
  vm_size              = "Standard_B1s"
  username             = "adminuser"
  password             = "password"
  caching              = "ReadWrite"
  storage_account_type = "Standard_LRS"
  publisher            = "RedHat"
  offer                = "RHEL"
  image_sku            = "82gen2"
  image_version        = "latest"

  data_disks = {
    data_disk_1 = {
      name                 = "example-vm-data-disk"
      storage_account_type = "Standard_LRS"
      create_option        = "Empty"
      disk_size_gb         = "10"
      caching              = "ReadWrite"
    }
  }
}
```
