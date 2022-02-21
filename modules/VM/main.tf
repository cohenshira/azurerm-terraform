resource "azurerm_public_ip" "vmpublicip" {
  name                = "${var.hostname}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.ip_allocation
  sku                 = var.pip_sku
}

resource "azurerm_network_interface" "vmnic" {
  name                = "${var.hostname}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "${var.hostname}-ipconf"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.ip_allocation
    public_ip_address_id          = azurerm_public_ip.vmpublicip.id
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  count                           = var.linux_count
  name                            = var.hostname
  resource_group_name             = var.resource_group_name
  location                        = var.location
  size                            = var.vm_size
  computer_name                   = var.hostname
  disable_password_authentication = var.pass_auth
  admin_username                  = var.username
  admin_password                  = var.password
  network_interface_ids           = ["${azurerm_network_interface.vmnic.id}"]



  os_disk {
    caching              = var.caching
    storage_account_type = var.sa_type
  }

  source_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.image_sku
    version   = var.image_version
  }
}


resource "azurerm_windows_virtual_machine" "winvm" {
  count                 = var.windows_count
  name                  = var.hostname
  resource_group_name   = var.resource_group_name
  location              = var.location
  size                  = var.vm_size
  computer_name         = var.hostname
  admin_username        = var.username
  admin_password        = var.password
  network_interface_ids = ["${azurerm_network_interface.vmnic.id}"]

  os_disk {
    caching              = var.caching
    storage_account_type = var.sa_type
  }

  source_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.image_sku
    version   = var.image_version
  }

}
