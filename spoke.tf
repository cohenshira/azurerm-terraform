
locals {
  spoke_rg_name            = "shira-spoke-rg-tf"
  location                 = "westeurope"
  spoke_vnet_name          = "shira-spoke-vnet-tf"
  spoke_vnet_address_space = ["10.1.0.0/16"]
  spoke_subnets = {
    default_subnet = {
      name             = "shira-spoke-subnet-tf"
      address_prefixes = ["10.1.1.0/24"]
    }
  }
  spoke_nsg_name = "shira-spoke-nsg-tf"
  spoke_nsg_rules = {
    ssh_out = {
      name                       = "ssh-out"
      priority                   = 1001
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },

    ssh_in = {
      name                       = "ssh-in"
      priority                   = 1001
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }
  sa_name                  = "shiraspokesatf"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  is_manual_connection     = false
  spoke_route_table_name   = "shira-spoke-route-table-tf"
  spoke_peer_name          = "SpokeToHub"
  spoke_hostname           = "shira-spoke-vm-tf"
  spoke_vm_size            = "Standard_B1s"
  spoke_os_disk = {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  spoke_source_image_reference = {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "82gen2"
    version   = "latest"
  }
  spoke_routes = {
    everything = {
      route_name     = "ToEverything"
      address_prefix = "0.0.0.0/0"
      next_hop_type  = "VirtualAppliance"
    },
    tohub = {
      route_name     = "ToHub"
      address_prefix = local.hub_vnet_address_space[0]
      next_hop_type  = "VirtualAppliance"
    },
    togateway = {
      route_name     = "ToGateway"
      address_prefix = local.hub_client_address_space[0]
      next_hop_type  = "VirtualAppliance"
    }
  }


}


resource "azurerm_resource_group" "spokerg" {
  name     = local.spoke_rg_name
  location = local.location
}

module "spoke-vnet" {
  source                    = "./modules/Vnet"
  location                  = azurerm_resource_group.spokerg.location
  resource_group_name       = azurerm_resource_group.spokerg.name
  vnet_name                 = local.spoke_vnet_name
  vnet_address_space        = local.spoke_vnet_address_space
  subnets                   = local.spoke_subnets
  peer_name                 = local.spoke_peer_name
  remote_virtual_network_id = module.hub-vnet.vnet_id
  remote_gateways           = true
  gateway_transit           = false

  depends_on = [
    azurerm_resource_group.spokerg
  ]

}

module "spoke-nsg" {
  source              = "./modules/NSG"
  location            = azurerm_resource_group.spokerg.location
  resource_group_name = azurerm_resource_group.spokerg.name
  nsg_name            = local.spoke_nsg_name
  nsg_rules           = local.spoke_nsg_rules
  subnet_ids          = module.spoke-vnet.subnet_ids_list

  depends_on = [
    module.spoke-vnet.subnets, module.hub-firewall.firewall
  ]
}

module "tohub-route-table" {
  source              = "./modules/RouteTable"
  route_table_name    = local.spoke_route_table_name
  location            = azurerm_resource_group.spokerg.location
  resource_group_name = azurerm_resource_group.spokerg.name
  routes              = local.spoke_routes
  next_hop_ip         = module.hub-firewall.fw_private_ip
  subnet_ids          = [lookup(module.spoke-vnet.created_subnets, local.spoke_subnets.default_subnet.name)]
  depends_on = [
    module.spoke-vnet.vnet, module.hub-firewall.firewall
  ]
}

module "storage-account" {
  source                   = "./modules/StorageAccount"
  sa_name                  = local.sa_name
  rg_name                  = azurerm_resource_group.spokerg.name
  location                 = azurerm_resource_group.spokerg.location
  account_tier             = local.account_tier
  account_replication_type = local.account_replication_type
  is_manual_connection     = local.is_manual_connection
  subnet_id                = module.spoke-vnet.subnet_ids_list[0]
  vnet_id                  = module.spoke-vnet.vnet_id

}

module "spoke-virtual-machine" {
  source              = "./modules/VM"
  location            = azurerm_resource_group.spokerg.location
  resource_group_name = azurerm_resource_group.spokerg.name
  linux_count         = local.linux_vm_count
  windows_count       = local.windows_vm_count
  subnet_id           = lookup(module.spoke-vnet.created_subnets, local.spoke_subnets.default_subnet.name)
  hostname            = local.spoke_hostname
  vm_size             = local.spoke_vm_size
  username            = var.vm_user
  password            = var.password
  caching             = local.spoke_os_disk.caching
  sa_type             = local.spoke_os_disk.storage_account_type
  publisher           = local.spoke_source_image_reference.publisher
  offer               = local.spoke_source_image_reference.offer
  image_sku           = local.spoke_source_image_reference.sku
  image_version       = local.spoke_source_image_reference.version

  depends_on = [
    module.spoke-vnet.vnet
  ]
}
