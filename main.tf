locals {
  location = "polandcentral"
}

data "azurerm_resource_group" "rg-tfworkshops" {
  name = "Terraform-workshops"
}

resource "azurerm_virtual_network" "vn" {
  address_space       = ["10.0.0.0/16"]
  location            = local.location
  name                = "multicloud-nick-dev-vn"
  resource_group_name = data.azurerm_resource_group.rg-tfworkshops.name
}

module "aks" {
  source = "./modules/aks"
  env_prefix = var.env_prefix
  prefix = var.prefix
  resource_group_name = data.azurerm_resource_group.rg-tfworkshops.name
  virtual_network_name = azurerm_virtual_network.vn.name
}