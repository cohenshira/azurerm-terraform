resource "azurerm_public_ip" "pip" {
  name                = "${var.firewall_name}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.ip_allocation
  sku                 = var.sku
}


module "firewall_policy" {
  source                              = "./modules/FirewallPolicy"
  location                            = var.location
  resource_group_name                 = var.resource_group_name
  firewall_policy_name                = var.firewall_policy_name
  firewall_rule_collection_group_name = var.firewall_rule_collection_group_name
  priority                            = var.priority
  app_rule_collections                = var.app_rule_collections
  network_rule_collections            = var.network_rule_collections
}


resource "azurerm_firewall" "hubfirewall" {
  name                = var.firewall_name
  location            = var.location
  resource_group_name = var.resource_group_name
  firewall_policy_id  = module.firewall_policy.id

  ip_configuration {
    name                 = "${var.firewall_name}-ipconf"
    subnet_id            = var.subnet_id
    public_ip_address_id = azurerm_public_ip.pip.id
  }
}


