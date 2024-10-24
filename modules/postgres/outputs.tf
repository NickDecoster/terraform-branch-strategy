output "flexible_server_id" {
  value = azurerm_postgresql_flexible_server.postgres.id
}

output "fqdn" {
  value = azurerm_postgresql_flexible_server.postgres.fqdn
}

output "admin_password" {
  sensitive = true
  value = azurerm_postgresql_flexible_server.postgres.administrator_password
}

output "admin_login" {
  sensitive = true
  value = azurerm_postgresql_flexible_server.postgres.administrator_login
}