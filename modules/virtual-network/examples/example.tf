module "virtual_network" {
  source              = "./modules/virtual-network"
  location            = "westeurope"
  resource_group_name = "example-resource-group"
  vnet_name           = "example-vnet"
  vnet_address_space  = "10.0.0.0/16"
  subnets = {
    example_subnet = {
      name             = "example-subnet"
      address_prefixes = ["10.0.0.0/24"]
    }
  }
}
