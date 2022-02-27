locals {
  hub_resource_group_name = "shira-hub-rg-tf"
  hub_vnet_name           = "shira-hub-vnet-tf"
  hub_vnet_address_space  = ["10.0.0.0/16"]
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
  firewall_name                       = "shira-hub-firewall-tf"
  firewall_policy_name                = "shira-hub-firewall-policy-tf"
  firewall_rule_collection_group_name = "shira-firewall-collenction-group-tf"
  network_priority                    = 100
  application_priority                = 102
  nat_priority                        = 103
  app_rule_collections                = {}
  nat_rule_collections                = {}
  hub_gateway_name                    = "shira-hub-gw-tf"
  hub_client_address_space            = ["172.20.0.0/24"]
  auth_type                           = ["AAD"]
  hub_hostname                        = "shira-hub-vm-tf"
  hub_vm_size                         = "Standard_B1s"
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
  hub_use_remote_gateways      = false
  hub_gateway_transit          = true
}


resource "azurerm_resource_group" "rg" {
  name     = local.hub_resource_group_name
  location = var.location
}


module "hub_vnet" {
  source = "./modules/Vnet"

  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  vnet_name           = local.hub_vnet_name
  vnet_address_space  = local.hub_vnet_address_space
  subnets             = local.hub_subnets
  depends_on = [
    azurerm_resource_group.rg
  ]
}

module "hub_firewall" {
  source                              = "./modules/Firewall"
  location                            = azurerm_resource_group.rg.location
  resource_group_name                 = azurerm_resource_group.rg.name
  firewall_name                       = local.firewall_name
  firewall_policy_name                = local.firewall_policy_name
  firewall_rule_collection_group_name = local.firewall_rule_collection_group_name
  subnet_id                           = lookup(module.hub_vnet.created_subnets, "AzureFirewallSubnet")
  network_priority                    = local.network_priority
  application_priority                = local.application_priority
  nat_priority                        = local.nat_priority
  app_rule_collections                = local.app_rule_collections
  network_rule_collections            = jsondecode(file("./jsons/network_rule_collection.json"))
  nat_rule_collections                = local.nat_rule_collections
  depends_on = [
    module.hub_vnet.vnet, module.hub_vnet.subnet
  ]
}

module "hub_vnet_gateway" {
  source               = "./modules/VpnGateway"
  location             = azurerm_resource_group.rg.location
  resource_group_name  = azurerm_resource_group.rg.name
  gateway_name         = local.hub_gateway_name
  subnet_id            = lookup(module.hub_vnet.created_subnets, "GatewaySubnet")
  client_address_space = local.hub_client_address_space
  auth_type            = local.auth_type
  tenant_id            = var.tenant_id
  audience             = var.audience
  issuer               = var.issuer

  depends_on = [
    module.hub_vnet
  ]
}

module "to_spoke_route_table" {
  source              = "./modules/RouteTable"
  route_table_name    = local.hub_route_table_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  routes              = jsondecode(templatefile("./jsons/hub_routes.json", { address_prefix = local.spoke_vnet_address_space[0], next_hop_ip = module.hub_firewall.firewall_private_ip }))
  subnet_ids          = [lookup(module.hub_vnet.created_subnets, "GatewaySubnet")]
  depends_on = [
    module.spoke_vnet, module.hub_vnet, module.hub_firewall
  ]
}



module "hub_virtual_machine" {
  source               = "./modules/VM"
  location             = azurerm_resource_group.rg.location
  resource_group_name  = azurerm_resource_group.rg.name
  is_linux             = local.is_linux
  subnet_id            = lookup(module.hub_vnet.created_subnets, local.hub_subnets.default_subnet.name)
  hostname             = local.hub_hostname
  vm_size              = local.hub_vm_size
  username             = var.vm_user
  password             = var.password
  caching              = local.hub_os_disk.caching
  storage_account_type = local.hub_os_disk.storage_account_type
  publisher            = local.hub_source_image_reference.publisher
  offer                = local.hub_source_image_reference.offer
  image_sku            = local.hub_source_image_reference.sku
  image_version        = local.hub_source_image_reference.version

  depends_on = [
    module.hub_vnet.vnet
  ]
}
