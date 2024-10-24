locals {
  location = "polandcentral"
}

data "azurerm_resource_group" "rg-tfworkshops" {
  name = "Terraform-workshops"
}

resource "azurerm_virtual_network" "vn" {
  address_space       = ["10.0.0.0/8"]
  location            = local.location
  name                = "multicloud-nick-dev-vn"
  resource_group_name = data.azurerm_resource_group.rg-tfworkshops.name
}

module "aks" {
  source               = "./modules/aks"
  env_prefix           = var.env_prefix
  prefix               = var.prefix
  resource_group_name  = data.azurerm_resource_group.rg-tfworkshops.name
  virtual_network_name = azurerm_virtual_network.vn.name
  location             = local.location

  depends_on = [azurerm_virtual_network.vn]
}

module "postgres" {
  source                  = "./modules/postgres"
  env_prefix              = var.env_prefix
  location                = local.location
  postgres_admin_password = var.postgres_admin_password
  prefix                  = var.prefix
  resource_group_name     = data.azurerm_resource_group.rg-tfworkshops.name
  virtual_network_name    = azurerm_virtual_network.vn.name

  depends_on = [azurerm_virtual_network.vn]
}

module "datahub" {
  source                            = "./modules/datahub"
  env_prefix                        = var.env_prefix
  prefix                            = var.prefix
  postgres_flexible_server_id       = module.postgres.flexible_server_id
  postgres_fqdn                     = module.postgres.fqdn
  postgres_password                 = module.postgres.admin_password
  postgres_login                    = module.postgres.admin_login
  postgres_db_name                  = var.postgres_db_name
  datahub-prerequisites-values-file = var.datahub-prerequisites-values-file
  datahub-values-file               = var.datahub-values-file
  neo4j_username                    = var.neo4j_username
  neo4j_password                    = var.neo4j_password
  datahub_root_user                 = var.datahub_root_user
  datahub_root_user_password        = var.datahub_root_user_password

  depends_on = [module.aks, module.postgres]
}