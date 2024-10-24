locals {
  location = "germany"
}

data "azurerm_resource_group" "rg-tfworkshops" {
  name = "Terraform-workshops"
}

resource "azurerm_virtual_network" "vn" {
  address_space       = ["10.0.0.0/16"]
  location            = local.location
  name                = "terraform-muliticloud-nick-vn"
  resource_group_name = data.azurerm_resource_group.rg-tfworkshops.name
}