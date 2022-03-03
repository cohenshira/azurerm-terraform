module "network-security-group" {
  source                      = "./modules/network-security-group"
  location                    = "westeurope"
  resource_group_name         = "example-resource-group"
  network_security_group_name = "example-network-security-group"
  network_security_group_rules = {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  subnet_ids = ["/subscriptions/xxx/resourceGroups/example-resource-group/providers/Microsoft.Network/virtualNetworks/example-virtual-network/subnets/example-subnet"]
}
