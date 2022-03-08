module "vpn-gateway" {
  source = "./modules/vpn-gateway"

  gateway_name        = "example-virtual-network-gateway"
  location            = "westeurope"
  resource_group_name = "example-resource-group"
  public_ips = {
    gateway_public_ip = {
      name          = "example-hub-gw-pip"
      ip_allocation = "Dynamic"
    }
  }
  subnet_id            = "/subscriptions/xxx/resourceGroups/example-resource-group/providers/Microsoft.Network/virtualNetworks/example-virtual-network/subnets/GatewaySubnet"
  client_address_space = "[172.2.0.0/16]"
  auth_type            = ["AAD"]
  tenant_id            = "https://login.microsoftonline.com/xxx"
  audience             = "n7h67gtbybt76h7666rt5676ttt"
  issuer               = "https://sts.windows.net/xxx/"
}
