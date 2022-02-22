resource "azurerm_public_ip" "pip" {
  name                = "${var.gateway_name}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.ip_allocation
}

resource "azurerm_virtual_network_gateway" "gw" {
  name                = var.gateway_name
  location            = var.location
  resource_group_name = var.resource_group_name

  type     = var.gateway_type
  vpn_type = var.vpn_type

  active_active = var.active_active
  enable_bgp    = var.enable_bgp
  generation    = var.generation
  sku           = var.gateway_sku


  ip_configuration {
    name                          = "${var.gateway_name}-ipconf"
    public_ip_address_id          = azurerm_public_ip.pip.id
    private_ip_address_allocation = var.ip_allocation
    subnet_id                     = var.subnet_id
  }
  depends_on = [azurerm_public_ip.pip]

  vpn_client_configuration {
    address_space = var.client_address_space

    vpn_auth_types       = var.auth_type
    vpn_client_protocols = var.client_protocols
    aad_tenant           = var.tenant_id
    aad_audience         = var.audience
    aad_issuer           = var.issuer
  }
}

