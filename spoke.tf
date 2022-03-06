locals {
  spoke_resource_group_name = "shira-spoke-rg-tf"
}

resource "azurerm_resource_group" "spoke_resource_group" {
  name     = local.spoke_resource_group_name
  location = local.location
}


locals {
  spoke_vnet_name          = "shira-spoke-vnet-tf"
  spoke_vnet_address_space = ["10.1.0.0/16"]
  spoke_subnets = {
    default_subnet = {
      name             = "ShiraSpokeSubnet"
      address_prefixes = ["10.1.1.0/24"]
    }
  }
}

module "spoke_vnet" {
  source = "./modules/virtual-network"

  vnet_name                  = local.spoke_vnet_name
  location                   = azurerm_resource_group.spoke_resource_group.location
  resource_group_name        = azurerm_resource_group.spoke_resource_group.name
  vnet_address_space         = local.spoke_vnet_address_space
  subnets                    = local.spoke_subnets
  log_analytics_workspace_id = azurerm_log_analytics_workspace.log_analytics_workspace.id

  depends_on = [
    azurerm_resource_group.spoke_resource_group
  ]
}


locals {
  spoke_network_security_group_name = "shira-spoke-network-security-group-tf"
}

module "spoke_network_security_group" {
  source = "./modules/network-security-group"

  location                     = azurerm_resource_group.spoke_resource_group.location
  resource_group_name          = azurerm_resource_group.spoke_resource_group.name
  network_security_group_name  = local.spoke_network_security_group_name
  network_security_group_rules = jsondecode(file("./network_security_groups/network_security_group_rules.json"))
  subnet_ids                   = module.spoke_vnet.subnet_ids_list
  log_analytics_workspace_id   = azurerm_log_analytics_workspace.log_analytics_workspace.id

  depends_on = [
    module.spoke_vnet.subnets, module.hub_firewall.object
  ]
}


locals {
  spoke_route_table_name = "shira-spoke-route-table-tf"
  spoke_route_variables = {
    to_hub_address_prefix     = local.hub_vnet_address_space[0],
    to_gateway_address_prefix = local.hub_client_address_space[0],
    next_hop_ip               = module.hub_firewall.firewall_private_ip
  }
}

module "to_hub_route_table" {
  source = "./modules/route-table"

  route_table_name    = local.spoke_route_table_name
  location            = azurerm_resource_group.spoke_resource_group.location
  resource_group_name = azurerm_resource_group.spoke_resource_group.name
  routes              = jsondecode(templatefile("./routes/spoke_routes.json", local.spoke_route_variables))
  subnet_ids          = [lookup(module.spoke_vnet.created_subnets, local.spoke_subnets.default_subnet.name)]

  depends_on = [
    module.hub_vnet, module.spoke_vnet.created_subnets, module.hub_firewall
  ]
}


locals {
  storage_account_name     = "shiraspokesatf"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  is_manual_connection     = false
  virtual_link_name        = "shira-private-endpoint-virual-link"
}

module "storage_account" {
  source = "./modules/storage-account"

  storage_account_name       = local.storage_account_name
  resource_group_name        = azurerm_resource_group.spoke_resource_group.name
  location                   = azurerm_resource_group.spoke_resource_group.location
  account_tier               = local.account_tier
  account_replication_type   = local.account_replication_type
  is_manual_connection       = local.is_manual_connection
  subnet_id                  = module.spoke_vnet.subnet_ids_list[0]
  vnet_id                    = module.spoke_vnet.id
  network_link_name          = local.virtual_link_name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.log_analytics_workspace.id

  depends_on = [
    module.spoke_vnet
  ]
}


locals {
  is_linux       = true
  spoke_hostname = "shira-spoke-vm-tf"
  spoke_vm_size  = "Standard_B1s"
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

  data_disks = {
    data_disk_1 = {
      name                 = "shira-spoke-vm-data-disk"
      storage_account_type = "Standard_LRS"
      create_option        = "Empty"
      disk_size_gb         = "10"
      lun                  = "10"
      caching              = "ReadWrite"
    }
  }
}

module "spoke_virtual_machine" {
  source = "./modules/vm"

  hostname                   = local.spoke_hostname
  location                   = azurerm_resource_group.spoke_resource_group.location
  resource_group_name        = azurerm_resource_group.spoke_resource_group.name
  is_linux                   = local.is_linux
  subnet_id                  = lookup(module.spoke_vnet.created_subnets, local.spoke_subnets.default_subnet.name)
  vm_size                    = local.spoke_vm_size
  username                   = var.vm_user
  password                   = var.password
  caching                    = local.spoke_os_disk.caching
  storage_account_type       = local.spoke_os_disk.storage_account_type
  publisher                  = local.spoke_source_image_reference.publisher
  offer                      = local.spoke_source_image_reference.offer
  image_sku                  = local.spoke_source_image_reference.sku
  image_version              = local.spoke_source_image_reference.version
  data_disks                 = local.data_disks
  log_analytics_workspace_id = azurerm_log_analytics_workspace.log_analytics_workspace.id


  depends_on = [
    module.spoke_vnet.object
  ]
}


locals {
  spoke_peer_name           = "SpokeToHub"
  spoke_use_remote_gateways = true
  spoke_gateway_transit     = false
  hub_peer_name             = "HubToSpoke"
  hub_use_remote_gateways   = false
  hub_gateway_transit       = true
}

module "hub_spoke_peering" {
  source = "./modules/two-way-peering"

  peer_name_1           = local.hub_peer_name
  peer_name_2           = local.spoke_peer_name
  vnet_name_1           = module.hub_vnet.name
  vnet_name_2           = module.spoke_vnet.name
  resource_group_name_1 = azurerm_resource_group.hub_resource_group.name
  resource_group_name_2 = azurerm_resource_group.spoke_resource_group.name
  vnet_id_1             = module.hub_vnet.id
  vnet_id_2             = module.spoke_vnet.id
  remote_gateways_1     = local.hub_use_remote_gateways
  gateway_transit_1     = local.hub_gateway_transit
  remote_gateways_2     = local.spoke_use_remote_gateways
  gateway_transit_2     = local.spoke_gateway_transit

  depends_on = [
    module.hub_vnet.object, module.spoke_vnet.object
  ]
}
