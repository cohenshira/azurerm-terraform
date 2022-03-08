locals {
  hub_resource_group_name = "shira-hub-rg-tf"
}

resource "azurerm_resource_group" "hub" {
  name     = local.hub_resource_group_name
  location = local.location
}

locals {
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
      name             = "ShiraHubSubnet"
      address_prefixes = ["10.0.2.0/24"]
    }
  }
}

module "hub_vnet" {
  source = "./modules/virtual-network"

  vnet_name                  = local.hub_vnet_name
  location                   = azurerm_resource_group.hub.location
  resource_group_name        = azurerm_resource_group.hub.name
  vnet_address_space         = local.hub_vnet_address_space
  subnets                    = local.hub_subnets
  log_analytics_workspace_id = azurerm_log_analytics_workspace.central_workspace.id

  depends_on = [
    azurerm_resource_group.hub,
    azurerm_log_analytics_workspace.central_workspace
  ]
}

locals {
  firewall_name        = "shira-hub-firewall-tf-final"
  firewall_policy_name = "shira-hub-firewall-policy-tf"
  network_collection_group_variables = {
    source_addresses    = local.hub_client_address_space[0],
    hub_address_space   = local.hub_vnet_address_space[0],
    spoke_address_space = local.spoke_vnet_address_space[0]
  }
}

module "hub_firewall" {
  source = "./modules/firewall"

  firewall_name                      = local.firewall_name
  firewall_policy_name               = local.firewall_policy_name
  location                           = azurerm_resource_group.hub.location
  resource_group_name                = azurerm_resource_group.hub.name
  network_rule_collection_groups     = jsondecode(templatefile("./rule_collection_groups/network_rule_collection_groups.json", local.network_collection_group_variables))
  application_rule_collection_groups = jsondecode(file("./rule_collection_groups/application_rule_collection_groups.json"))
  nat_rule_collection_groups         = jsondecode(file("./rule_collection_groups/nat_rule_collection_groups.json"))
  subnet_id                          = lookup(module.hub_vnet.created_subnets, local.hub_subnets.firewall_subnet.name)
  log_analytics_workspace_id         = azurerm_log_analytics_workspace.central_workspace.id

  depends_on = [ 
    module.hub_vnet,
    ]
}

locals {
  hub_gateway_name         = "shira-hub-gw-tf"
  hub_client_address_space = ["172.20.0.0/24"]
  auth_type                = ["AAD"]
  gateway_public_ips = {
    gateway_public_ip = {
      name          = "shira-hub-gw-pip"
      ip_allocation = "Dynamic"
    }
  }
}

module "hub_vnet_gateway" {
  source = "./modules/vpn-gateway"

  gateway_name         = local.hub_gateway_name
  public_ips           = local.gateway_public_ips
  location             = azurerm_resource_group.hub.location
  resource_group_name  = azurerm_resource_group.hub.name
  subnet_id            = lookup(module.hub_vnet.created_subnets, local.hub_subnets.gateway_subnet.name)
  client_address_space = local.hub_client_address_space
  auth_type            = local.auth_type
  tenant_id            = var.tenant_id
  audience             = var.audience
  issuer               = var.issuer

  depends_on = [
    module.hub_vnet
  ]
}

locals {
  hub_route_table_name = "shira-hub-route-table-tf"
  hub_routes_variables = {
    address_prefix = local.spoke_vnet_address_space[0],
    next_hop_ip    = module.hub_firewall.firewall_private_ip
  }
}

module "to_spoke_route_table" {
  source = "./modules/route-table"

  route_table_name    = local.hub_route_table_name
  location            = azurerm_resource_group.hub.location
  resource_group_name = azurerm_resource_group.hub.name
  routes              = jsondecode(templatefile("./routes/hub_routes.json", local.hub_routes_variables))
  subnets = {
    GatewaySubnet = lookup(module.hub_vnet.created_subnets, local.hub_subnets.gateway_subnet.name)
  }

  depends_on = [
    module.spoke_vnet,
    module.hub_firewall,
  ]
}

locals {
  hub_hostname = "shira-hub-vm-tf"
  hub_vm_size  = "Standard_B1s"
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
}

module "hub_virtual_machine" {
  source = "./modules/vm"

  hostname            = local.hub_hostname
  is_linux            = local.is_linux
  location            = azurerm_resource_group.hub.location
  resource_group_name = azurerm_resource_group.hub.name
  subnet_id           = lookup(module.hub_vnet.created_subnets, local.hub_subnets.default_subnet.name)
  vm_size             = local.hub_vm_size
  ############ Authentication ############
  username = var.vm_user
  password = var.password
  ############ OS disk ############
  caching              = local.hub_os_disk.caching
  storage_account_type = local.hub_os_disk.storage_account_type
  ############ Source image reference ############
  publisher                  = local.hub_source_image_reference.publisher
  offer                      = local.hub_source_image_reference.offer
  image_sku                  = local.hub_source_image_reference.sku
  image_version              = local.hub_source_image_reference.version

  data_disks                 = {}
  log_analytics_workspace_id = azurerm_log_analytics_workspace.central_workspace.id

  depends_on = [
    module.hub_vnet
  ]
}
