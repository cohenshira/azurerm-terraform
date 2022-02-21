locals {
  hub_rg_name            = "shira-hub-rg-tf"
  hub_vnet_name          = "shira-hub-vnet-tf"
  hub_vnet_address_space = ["10.0.0.0/16"]
  hub_subnets = {
    gateway_subnet = {
      name             = "GatewaySubnet"
      address_prefixes = ["10.0.0.0/24"]
    },
    firewall_subnet = {
      name             = "AzureFirewallSubnet"
      address_prefixes = ["10.0.1.0/24"]
    },
    default_subnet = {
      name             = "shira-hub-subnet-tf"
      address_prefixes = ["10.0.2.0/24"]
    }
  }
  fw_name                       = "shira-hub-fw-tf"
  fw_policy_name                = "shira-hub-firewall-policy-tf"
  fw_rule_collection_group_name = "shira-fw-collenction-group-tf"
  priority                      = 100
  app_rule_collections          = {}
  network_rule_collections = {
    collection1 = {
      name     = "network_rule_collection1"
      priority = 102
      action   = "Allow"
      rules = {
        allowssh = {
          name                  = "allowssh"
          protocols             = ["TCP", "UDP"]
          source_addresses      = ["*"]
          destination_addresses = ["*"]
          destination_ports     = ["22"]
        }
      }
    }
  }
  hub_gw_name              = "shira-hub-gw-tf"
  hub_client_address_space = ["172.20.0.0/24"]
  auth_type                = ["AAD"]
  linux_vm_count           = 1
  windows_vm_count         = 0
  hub_hostname             = "shira-hub-vm-tf"
  hub_vm_size              = "Standard_B1s"
  hub_os_disk = {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  hub_source_image_reference = {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "82gen2"
    version   = "latest"
  }
  hub_route_table_name         = "shira-hub-route-table-tf"
  hub_route_name               = "ToSpoke"
  default_hub_route_table_name = "shira-default-hub-route-table-tf"
  default_hub_route_name       = "ToHub"
  hub_peer_name                = "HubToSpoke"
  hub_routes = {
    tospoke = {
      route_name     = "ToSpoke"
      address_prefix = local.spoke_vnet_address_space[0]
      next_hop_type  = "VirtualAppliance"
    }
  }

}





resource "azurerm_resource_group" "rg" {
  name     = local.hub_rg_name
  location = var.location
}

module "hub-vnet" {
  source = "./modules/Vnet"

  location                  = azurerm_resource_group.rg.location
  resource_group_name       = azurerm_resource_group.rg.name
  vnet_name                 = local.hub_vnet_name
  vnet_address_space        = local.hub_vnet_address_space
  subnets                   = local.hub_subnets
  peer_name                 = local.hub_peer_name
  remote_virtual_network_id = module.spoke-vnet.vnet_id
  remote_gateways           = false
  gateway_transit           = true
  depends_on = [
    azurerm_resource_group.rg
  ]
}

module "hub-firewall" {
  source                        = "./modules/Firewall"
  location                      = azurerm_resource_group.rg.location
  resource_group_name           = azurerm_resource_group.rg.name
  fw_name                       = local.fw_name
  fw_policy_name                = local.fw_policy_name
  fw_rule_collection_group_name = local.fw_rule_collection_group_name
  subnet_id                     = lookup(module.hub-vnet.created_subnets, "AzureFirewallSubnet")
  priority                      = local.priority
  app_rule_collections          = local.app_rule_collections
  network_rule_collections      = local.network_rule_collections
  depends_on = [
    module.hub-vnet.vnet, module.hub-vnet.subnet
  ]
}

module "hub-vnet-gateway" {
  source               = "./modules/VpnGateway"
  location             = azurerm_resource_group.rg.location
  resource_group_name  = azurerm_resource_group.rg.name
  gw_name              = local.hub_gw_name
  subnet_id            = lookup(module.hub-vnet.created_subnets, "GatewaySubnet")
  client_address_space = local.hub_client_address_space
  auth_type            = local.auth_type
  tenant_id            = var.tenant_id
  audience             = var.audience
  issuer               = var.issuer

  depends_on = [
    module.hub-vnet
  ]
}

module "tospoke-route-table" {
  source              = "./modules/RouteTable"
  route_table_name    = local.hub_route_table_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  routes              = local.hub_routes
  next_hop_ip         = module.hub-firewall.fw_private_ip
  subnet_ids = [lookup(module.hub-vnet.created_subnets, "GatewaySubnet")]
  depends_on = [
    module.spoke-vnet, module.hub-vnet, module.hub-firewall.firewall
  ]
}



module "hub-virtual-machine" {
  source              = "./modules/VM"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  linux_count         = local.linux_vm_count
  windows_count       = local.windows_vm_count
  subnet_id           = lookup(module.hub-vnet.created_subnets, local.hub_subnets.default_subnet.name)
  hostname            = local.hub_hostname
  vm_size             = local.hub_vm_size
  username            = var.vm_user
  password            = var.password
  caching             = local.hub_os_disk.caching
  sa_type             = local.hub_os_disk.storage_account_type
  publisher           = local.hub_source_image_reference.publisher
  offer               = local.hub_source_image_reference.offer
  image_sku           = local.hub_source_image_reference.sku
  image_version       = local.hub_source_image_reference.version

  depends_on = [
    module.hub-vnet.vnet
  ]
}
