resource "azurerm_public_ip" "vm_public_ip" {
  name                = "${var.hostname}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.ip_allocation
  sku                 = var.pip_sku
}

resource "azurerm_network_interface" "vm_network_interface" {
  name                = "${var.hostname}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "${var.hostname}-ipconf"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.ip_allocation
    public_ip_address_id          = azurerm_public_ip.vm_public_ip.id
  }
}

resource "azurerm_linux_virtual_machine" "linux_vm" {
  count                           = var.is_linux ? 1 : 0
  name                            = var.hostname
  resource_group_name             = var.resource_group_name
  location                        = var.location
  size                            = var.vm_size
  computer_name                   = var.hostname
  disable_password_authentication = var.disable_password_authentication
  admin_username                  = var.username
  admin_password                  = var.password
  network_interface_ids           = [azurerm_network_interface.vm_network_interface.id]

  os_disk {
    caching              = var.caching
    storage_account_type = var.storage_account_type
  }

  source_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.image_sku
    version   = var.image_version
  }
}

resource "azurerm_windows_virtual_machine" "windows_vm" {
  count                 = var.is_linux ? 0 : 1
  name                  = var.hostname
  resource_group_name   = var.resource_group_name
  location              = var.location
  size                  = var.vm_size
  computer_name         = var.hostname
  admin_username        = var.username
  admin_password        = var.password
  network_interface_ids = [azurerm_network_interface.vm_network_interface.id]

  os_disk {
    caching              = var.caching
    storage_account_type = var.storage_account_type
  }

  source_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.image_sku
    version   = var.image_version
  }
}

resource "azurerm_managed_disk" "data_disk" {
  for_each = var.data_disks

  name                 = each.value.name
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = each.value.storage_account_type
  create_option        = each.value.create_option
  disk_size_gb         = each.value.disk_size_gb
}

resource "azurerm_virtual_machine_data_disk_attachment" "data_disk_attachment" {
  for_each = var.data_disks

  managed_disk_id    = azurerm_managed_disk.data_disk[each.key].id
  virtual_machine_id = var.is_linux ? azurerm_linux_virtual_machine.linux_vm.0.id : azurerm_windows_virtual_machine.windows_vm.0.id
  lun                = index(keys(var.data_disks), each.key)
  caching            = coalesce(each.value.cahing, var.caching)
}

module "virtual_machine_diagnostic_setting" {
  source = "../diagnostic-settings"

  diagnostic_setting_name    = "${var.hostname}-diagnostic-settings"
  target_resource_id         = var.is_linux ? azurerm_linux_virtual_machine.linux_vm.0.id : azurerm_windows_virtual_machine.windows_vm.0.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  depends_on = [
    azurerm_linux_virtual_machine.linux_vm,
    azurerm_windows_virtual_machine.windows_vm
  ]
}
