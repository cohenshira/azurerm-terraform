resource "azurerm_public_ip" "pip" {
  for_each = var.public_ips

  name                = each.value.name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = each.value.ip_allocation
}

resource "azurerm_virtual_network_gateway" "gateway" {
  name                = var.gateway_name
  location            = var.location
  resource_group_name = var.resource_group_name
  type                = var.gateway_type
  vpn_type            = var.vpn_type
  active_active       = var.active_active
  enable_bgp          = var.enable_bgp
  generation          = var.generation
  sku                 = var.gateway_sku

  dynamic "ip_configuration" {
    for_each = var.public_ips

    content {
      name                          = "${ip_configuration.value.name}-ipconf"
      public_ip_address_id          = azurerm_public_ip.pip[ip_configuration.key].id
      private_ip_address_allocation = ip_configuration.value.ip_allocation
      subnet_id                     = var.subnet_id
    }
  }

  vpn_client_configuration {
    address_space        = var.client_address_space
    vpn_auth_types       = var.auth_type
    vpn_client_protocols = var.client_protocols
    aad_tenant           = var.tenant_id
    aad_audience         = var.audience
    aad_issuer           = var.issuer
  }

  depends_on = [azurerm_public_ip.pip]
}

