variable "env_prefix" {
  type = string
}

variable "prefix" {
  type = string
}

variable "postgres_admin_password" {
  type = string
  sensitive = true
}