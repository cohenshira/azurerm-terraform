module "virtual_machine" {
  source               = "./modules/vm"

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
      lun                  = "10"
      caching              = "ReadWrite"
    }
  }
}