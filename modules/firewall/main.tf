resource "azurerm_public_ip" "pip" {
  name                = "${var.firewall_name}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.ip_allocation
  sku                 = var.pip_sku
}

module "firewall_policy" {
  source = "./modules/firewall-policy"

  location                           = var.location
  resource_group_name                = var.resource_group_name
  firewall_policy_name               = var.firewall_policy_name
  network_rule_collection_groups     = var.network_rule_collection_groups
  application_rule_collection_groups = var.application_rule_collection_groups
  nat_rule_collection_groups         = var.nat_rule_collection_groups
  firewall_private_ip                = azurerm_firewall.firewall.ip_configuration[0].private_ip_address
  firewall_public_ip                 = azurerm_public_ip.pip.ip_address
}

resource "azurerm_firewall" "firewall" {
  name                = var.firewall_name
  location            = var.location
  resource_group_name = var.resource_group_name
  firewall_policy_id  = module.firewall_policy.id

  ip_configuration {
    name                 = "${var.firewall_name}-ipconf"
    subnet_id            = var.subnet_id
    public_ip_address_id = azurerm_public_ip.pip.id
  }

  depends_on = [
    module.firewall_policy,
    azurerm_public_ip.pip
  ]
}

module "firewall_diagnostic_setting" {
  source = "../diagnostic-settings"

  diagnostic_setting_name    = "${var.firewall_name}-diagnostic-settings"
  target_resource_id         = azurerm_firewall.firewall.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  depends_on = [
    azurerm_firewall.firewall
  ]
}

